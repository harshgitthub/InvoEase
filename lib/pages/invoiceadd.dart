import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloneapp/pages/subpages/billing.dart';
import 'package:cloneapp/pages/subpages/settings/invoicedraft.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:cloneapp/pages/home.dart';

class InvoiceAdd extends StatefulWidget {
  final String customerID;
  const InvoiceAdd({super.key, required this.customerID});

  @override
  _InvoiceAddState createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd> {
  String _invoiceId = '';
  String formattedDate = '';
  DateTime? _selectedDate;
  String? _paymentMethod;
  final List<String> _paymentMethods = [
    'Advance',
    'Due on receipt',
    'Due at end of week',
    'Due within 15 days',
    'Due end of the month'
  ];
  List<Map<String, dynamic>> _selectedItems = [];
  String? _customerName;
  String? _customerAddress;
  String? _customerEmail;
  String? _customerWorkPhone;
  String? _customerMobile;
  String? _customerid;
  final currentuser = FirebaseAuth.instance.currentUser;
  double _totalAmount = 0.0 ;
final _taxController = TextEditingController();
  final _discountController = TextEditingController();
  double _tax = 0;
  double _discount= 0 ; 
  double _totalBill = 0.0;

  @override
  void initState() {
    _fetchCustomerDetails();
    super.initState();
   
    _generateInvoiceId();
    _formatDate();
    _calculateTotalAmount();
     _calculatetotalbill(); // Initial calculation

    // Add listener to tax controller
    _taxController.addListener( _calculatetotalbill);
    // Add listener to discount controller
    _discountController.addListener( _calculatetotalbill);
     _taxController.text = _tax.toString();
    _discountController.text = _discount.toString();
  }

  void _generateInvoiceId() {
    const length = 5;
    const chars = 'ABC1234';
    final random = Random();
    setState(() {
      _invoiceId = String.fromCharCodes(Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    });
  }

  void _formatDate() {
    formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }


  void _fetchCustomerDetails() async {
    try {
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentuser!.uid)
          .collection('customers')
          .doc(widget.customerID)
          .get();

      if (customerSnapshot.exists) {
        setState(() {
          String salutation = customerSnapshot['Salutation'] ?? ''; // Fetching salutation
          String firstName = customerSnapshot['First Name'] ?? '';
          String lastName = customerSnapshot['Last Name'] ?? '';
          _customerName = '$salutation $firstName $lastName';
          _customerAddress = customerSnapshot['Address'];
          _customerEmail = customerSnapshot['Email'];
          _customerWorkPhone = customerSnapshot['Work-Phone'];
          _customerMobile = customerSnapshot['Mobile'];
          _customerid = customerSnapshot["customerID"];
        });
      }
    } catch (e) {
      print("Error fetching customer details: $e");
    }
  }

  Future<void> _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addItems() async {
    final Map<String, dynamic>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddItems()),
    );
    if (result != null) {
      setState(() {
        _selectedItems.add(result);
        _calculateTotalAmount();
        _calculatetotalbill();
      });
    }
  }

  void _calculateTotalAmount() {
    double total = 0.0;
    _selectedItems.forEach((item) {
       double price = item['price'].toDouble(); 
      total += price;
    });
    setState(() {
      _totalAmount = total;
      _calculatetotalbill();
    });
  }
 void _calculatetotalbill() {
  // Calculate total amount of selected items
   _tax = double.tryParse(_taxController.text) ?? 0.0;
    _discount = double.tryParse(_discountController.text) ?? 0.0;
  double totalAmount = _totalAmount;

  // Get tax and discount values from text controllers
  double tax = double.tryParse(_taxController.text) ?? 0.0; // Assuming _tax is a TextEditingController
  double discount = double.tryParse(_discountController.text) ?? 0.0; // Assuming _discount is a TextEditingController

  // Calculate tax amount
  double taxAmount = totalAmount * (tax / 100); // Assuming _tax is in percentage

  // Calculate discount amount
  double discountAmount = totalAmount * (discount / 100); // Assuming _discount is in percentage

  // Calculate total bill amount
  double totalBill = totalAmount + taxAmount - discountAmount;

  // Optionally update state or perform other actions with totalBill
  setState(() {
    
    _totalBill = totalBill;
  });
}

@override
  void dispose() {
    // Clean up controllers
    _taxController.dispose();
    _discountController.dispose();
    super.dispose();
  }


  Future<void> _saveInvoice() async {

  // Calculate total amount
 
    try {
      Map<String, dynamic> invoice = {
        "customerName": _customerName,
        "customerAddress": _customerAddress,
        "customerEmail": _customerEmail,
        "customerID": widget.customerID,
        "workphone": _customerWorkPhone,
        "mobile": _customerMobile,
        "invoiceId": _invoiceId,
        "invoiceDate": Timestamp.fromDate(DateTime.now()), // Convert invoice date to Timestamp
        "paymentMethod": _paymentMethod,
        "dueDate": _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null, // Convert due date to Timestamp
        "items": _selectedItems,
        "total amount": _totalAmount, 
        "tax": _tax,
        "discount" : _discount,
        "totalBill": _totalBill,// Add selected items to the invoice data
        "status": false
      };

      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("invoices")
          .doc(_invoiceId)
          .set(invoice);

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Invoice saved successfully'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Invoicedraft(invoiceId: _invoiceId),
                  ),
                );
              },
            ),
          ],
        ),
      );
      setState(() {
        _selectedItems.clear();
      });
    } catch (e) {
      print("Error saving invoice: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Invoice"),
      ),
      drawer: drawer(context),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Invoice ID: $_invoiceId',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 105),
                  Text(
                    '$formattedDate',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Due Date:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 165),
                  GestureDetector(
                    onTap: _selectDueDate,
                    child: Text(
                      _selectedDate == null
                          ? '$formattedDate'
                          : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey.shade400, width: 1.5),
    borderRadius: BorderRadius.circular(8.0),
  ),
  child: Row(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            controller: _taxController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter the tax amount',
              // Additional styling options can be added here
            ),
          ),
        ),
      ),
      Container(
        height: 40.0,
        width: 1.5,
        color: Colors.grey.shade400,
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            controller: _discountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter the discount amount',
              // Additional styling options can be added here
            ),
          ),
        ),
      ),
    ],
  ),
)

              ,const SizedBox(height: 10,)
             ,
              DropdownButton<String>(
                  value: _paymentMethod,
                  onChanged: (String? newValue) {
                    setState(() {
                      _paymentMethod = newValue;
                    });
                  },
                  items: _paymentMethods.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
             
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                  onPressed: _addItems,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  child: const Text(
                    '+ Add inline items',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              ),
              if (_selectedItems.isNotEmpty) ...[
                const SizedBox(height: 16),
               

                const SizedBox(height: 16),
                const Text(
                  'Selected Items:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _selectedItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_selectedItems[index]['itemName']),
                      subtitle: Text('${_selectedItems[index]['quantity']} X ${_selectedItems[index]['rate']}'),
                      trailing: Text('Price: \₹${_selectedItems[index]['price'].toStringAsFixed(2)}', style: const TextStyle(fontSize: 15),),
                    );
                  },

                ),
                 const SizedBox(height: 16),

                Row(
                  
                  children: [
                    Text(
                      'Sub Total:                               ₹${_totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Total:                                       ₹${_totalBill.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _saveInvoice,
                  child: const Text('Save Invoice'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120, // Adjust as needed
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12), // Adjust spacing between label and value
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
// Display Customer Name
            // Container(
            //   padding: const EdgeInsets.all(16.0),
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey.shade400, width: 1.5),
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Customer Name:',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(height: 8),
            //       Text(
            //         _customerName ?? 'Not Available',
            //         style: TextStyle(fontSize: 18),
            //       ),
            //     ],
            //   ),
            // ),
          

// add warnings and make the things compulsory awesome boxes

 // DropdownButtonFormField<String>(
              //   value: _paymentMethod,
              //   onChanged: (value) {
              //     setState(() {
              //       _paymentMethod = value!;
              //     });
              //   },
              //   decoration: const  InputDecoration(
              //     labelText: 'Select Terms of Payment',
              //     labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              //   ),
              //   items: _paymentMethods.map((String method) {
              //     return DropdownMenuItem<String>(
              //       value: method,
              //       child: Text(method),
              //     );
              //   }).toList(),
              // ),
  
 // ListTile(
              //   title: Text(
              //     ' ${_customerName ?? ''}',
                  
              //   ),
                // onTap: () {
                //   showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: const Text('Customer Details'),
                //         content: SingleChildScrollView(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               _buildDetailRow('Name', _customerName ?? ''),
                //               _buildDetailRow('Address', _customerAddress ?? ''),
                //               _buildDetailRow('Email', _customerEmail ?? ''),
                //               _buildDetailRow('Work Phone', _customerWorkPhone ?? ''),
                //               _buildDetailRow('Mobile', _customerMobile ?? ''),
                //               _buildDetailRow('Customer ID', widget.customerID),
                //             ],
                //           ),
                //         ),
              //           actions: [
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.of(context).pop();
              //               },
              //               child: const Text('Close'),
              //             ),
              //           ],
              //         );
              //       },
              //     );
              //   },
              // ),

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  String? selectedItem;
  TextEditingController quantityController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  double? rate;
  double? price;
  List<String> items = [];
  List<String> filteredItems = [];
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchItems();
    searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterItems);
    searchController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  Future<void> fetchItems() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentUser!.uid)
        .collection("items")
        .get();
    setState(() {
      items = snapshot.docs.map((doc) => doc['Item Name'].toString()).toList();
      filteredItems = items;
    });
  }

  void _filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = items
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  void calculatePrice() {
    if (quantityController.text.isNotEmpty && rate != null) {
      setState(() {
        price = double.parse(quantityController.text) * rate!;
      });
    } else {
      setState(() {
        price = null;
      });
    }
  }

  Future<void> fetchRate(String itemName) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentUser!.uid)
        .collection("items")
        .where('Item Name', isEqualTo: itemName)
        .get();

    if (snapshot.docs.isNotEmpty) {
      setState(() {
        rate = snapshot.docs.first['Selling Price'].toDouble();
        calculatePrice();
      });
    }
  }

  void saveItem() {
    if (selectedItem != null &&
        quantityController.text.isNotEmpty &&
        rate != null &&
        price != null) {
      Navigator.pop(
        context,
        {
          'itemName': selectedItem,
          'quantity': quantityController.text,
          'rate': rate,
          'price': price,
        },
      );
    } else {
    _showErrorDialog(context, "Fill the details properly");
    }
  }

  void saveAndNewItem() {
    saveItem();
    setState(() {
      selectedItem = null;
      searchController.clear();
      quantityController.clear();
      rate = null;
      price = null;
    });
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/itemadd');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search box with autocomplete suggestions
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                     BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Item',
                    hintText: 'Type to search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (searchController.text.isNotEmpty && filteredItems.isNotEmpty)
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 200.0, // Limit height of suggestions box
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredItems[index]),
                        onTap: () {
                          setState(() {
                            selectedItem = filteredItems[index];
                            searchController.text = selectedItem!;
                            filteredItems.clear();
                          });
                          fetchRate(selectedItem!);
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              // Quantity input field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    calculatePrice();
                  },
                ),
              ),
              const SizedBox(height: 16),
              if (rate != null)
                Text(
                  'Rate: ${NumberFormat.currency(symbol: "\₹").format(rate)}',
                  style: const TextStyle(fontSize: 16),
                ),
              if (price != null)
                Text(
                  'Price: ${NumberFormat.currency(symbol: "\₹").format(price)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: saveAndNewItem,
                    child: const Text('Save and New'),
                  ),
                  ElevatedButton(
                    onPressed: saveItem,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showErrorDialog(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: 'Error',
    desc: message,
    btnOkText: 'OK',
    btnOkColor: Colors.red,
    btnOkOnPress: () {
      // Optionally perform some action on button press
    },
  ).show();
}
}
