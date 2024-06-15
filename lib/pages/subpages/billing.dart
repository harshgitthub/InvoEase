import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BillingPage extends StatefulWidget {
  final Map<String, dynamic> invoice;

  const BillingPage({super.key, required this.invoice});

  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  List<Map<String, dynamic>> selectedItems = [];
  double totalAmount = 0.0;
  List<Map<String, dynamic>> availableItems = [];

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchAvailableItems();
  }

  Future<void> _fetchAvailableItems() async {
    if (currentUser != null) {
      final userItemsRef = FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.uid)
          .collection('items');

      final snapshot = await userItemsRef.get();
      final items = snapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        availableItems = items.map((item) => {
          'Description': item['Description'],
          'Selling Price': item['Selling Price'],
        }).toList();
      });
    }
  }

  void _addItem() {
    if (availableItems.isNotEmpty) {
      setState(() {
        selectedItems.add({
          'description': availableItems[0]['Description'],
          'quantity': 1,
          'price': availableItems[0]['Selling Price'],
        });
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      selectedItems.removeAt(index);
      _calculateTotalAmount();
    });
  }

  void _updateItem(int index, String description, int quantity, int price) {
    setState(() {
      selectedItems[index] = {
        'description': description,
        'quantity': quantity,
        'price': price,
      };
      _calculateTotalAmount();
    });
  }

  void _calculateTotalAmount() {

    double total = 0.0;
    for (var item in selectedItems) {
      total += item['quantity'] * item['price'];
    }
    setState(() {
      totalAmount =  total;
    });
  }



    void _submitBill() async {

    // if () {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: Text('Missing Information'),
    //       content: Text('Please fill in all required fields.'),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('OK'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     ),
    //   );
    //   return;
    // }

    try {
      await FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.uid)
          .collection('bills')
          .doc(widget.invoice['invoiceId'])
          .set({
        'Customer Name': widget.invoice['customerName'],
        'Customer Email': widget.invoice['Email'],
        'Customer Address':  widget.invoice['Address'],
        'Due Date': widget.invoice['dueDate'],
        'Invoice Date': DateTime.now(),
        'Invoice ID': widget.invoice['invoiceId'],
        'Total Bill': totalAmount,
        'Procedures': selectedItems,
        
      });

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Billing information submitted successfully.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      );

      // Clear fields after successful submission
      setState(() {
        selectedItems.clear();
        totalAmount = 0.0;
      });
    } catch (e) {
      print('Error submitting bill: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred. Please try again later.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Billing for ${widget.invoice['customerName']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
  children: [
    Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.person, color: Colors.blue, size: 28),
                SizedBox(width: 8),
                Text(
                  'Customer Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
                  _buildInfoRow('Email:', widget.invoice['Email'] ?? 'N/A'),
                  _buildInfoRow('Address:', widget.invoice['Address'] ?? 'N/A'),
          ],
        ),
      ),
    ),
    const SizedBox(width: 32),
    Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.receipt, color: Colors.green, size: 28),
                SizedBox(width: 8),
                Text(
                  'Invoice Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
     _buildInfoRow('Invoice Number:', widget.invoice['invoiceId'] ?? 'N/A'),
            _buildInfoRow('Due Date:',widget.invoice['dueDate']?.toDate().toString() ?? 'No due date',
            ),
            _buildInfoRow('Status:', widget.invoice['procedure'] ?? 'No status'),
          ],
        ),
      ),
    ),
  ],
),
const Text(
  'Select Items',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
),

Expanded(
  child: ListView.builder(
    itemCount: selectedItems.length,
    itemBuilder: (context, index) {
      final item = selectedItems[index];
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Styled Dropdown for item description
              InputDecorator(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: item['description'],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        final newItem = availableItems.firstWhere(
                          (element) => element['Description'] == newValue,
                        );
                        _updateItem(index, newValue, item['quantity'], newItem['Selling Price']);
                      }
                    },
                    items: availableItems.map<DropdownMenuItem<String>>((dynamic item) {
                      return DropdownMenuItem<String>(
                        value: item['Description'],
                        child: Text(item['Description']),
                      );
                    }).toList(),
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    dropdownColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Row for quantity input and price display
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final int quantity = int.tryParse(value) ?? 1;
                        _updateItem(index, item['Description'], quantity, item['Selling Price']);
                      },
                      controller: TextEditingController()
                        ..text = item['quantity'].toString(),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    '\$${item['Selling Price'].toString()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Delete button
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeItem(index),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
),

const SizedBox(height: 16.0),

ElevatedButton.icon(
  onPressed: _addItem,
  icon: const Icon(Icons.add),
  label: const Text('Add Item'),
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  ),
),

const SizedBox(height: 16.0),

_buildTotalAmountRow('Total Amount:', totalAmount),

const SizedBox(height: 16.0),

ElevatedButton.icon(
  onPressed: _submitBill,
  icon: const Icon(Icons.save),
  label: const Text('Save'),
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  ),
),

          ],
          
        ),
        
      ),
      
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalAmountRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}



