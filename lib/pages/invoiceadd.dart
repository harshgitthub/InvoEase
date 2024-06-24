import 'dart:math';
import 'package:cloneapp/pages/subpages/billing.dart';
import 'package:cloneapp/pages/subpages/settings/invoicedraft.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:cloneapp/pages/home.dart';

class InvoiceAdd extends StatefulWidget {
  final String customerID;
  const InvoiceAdd({Key? key, required this.customerID}) : super(key: key);

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
    
    super.initState();
    _fetchCustomerDetails();
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
            children: [
              ListTile(
                title: Text(
                  ' ${_customerName ?? ''}',
                  
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Customer Details'),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('Name', _customerName ?? ''),
                              _buildDetailRow('Address', _customerAddress ?? ''),
                              _buildDetailRow('Email', _customerEmail ?? ''),
                              _buildDetailRow('Work Phone', _customerWorkPhone ?? ''),
                              _buildDetailRow('Mobile', _customerMobile ?? ''),
                              _buildDetailRow('Customer ID', widget.customerID),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
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
  child: Row(
    children: [
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(8.0), // Adjust margin as needed
          child: TextField(
            controller: _taxController,
            decoration: const InputDecoration(
              hintText: 'Enter the tax amount',
              // Additional styling options can be added here
            ),
          ),
        ),
      ),
      
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(8.0), // Adjust margin as needed
          child: TextField(
            controller: _discountController,
            decoration: const InputDecoration(
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
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
                decoration: const  InputDecoration(
                  labelText: 'Select Terms of Payment',
                  labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                items: _paymentMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
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

// making things compulsory in this add warnings and other things 


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

  final currentuser = FirebaseAuth.instance.currentUser;

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
    super.dispose();
  }

  Future<void> fetchItems() async {
    final snapshot = await FirebaseFirestore.instance.collection('USERS').doc(currentuser!.uid).collection("items").get();
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
    final snapshot = await FirebaseFirestore.instance.
        collection('USERS').doc(currentuser!.uid).collection("items")
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
    if (selectedItem != null && quantityController.text.isNotEmpty && rate != null && price != null) {
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
      print('Please ensure all fields are filled correctly.');
    }
  }

  void saveAndNewItem() {
     Navigator.pushNamed(context, '/invoiceadd');
    saveItem();
    setState(() {
      selectedItem = null;
      searchController.clear();
      quantityController.clear();
      rate = null;
      price = null;
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items'),
        actions: [
          IconButton(onPressed:(){
            Navigator.pushNamed(context , '/itemadd');
          }, icon: Icon(Icons.add))
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Item',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedItem,
              hint: const Text('Select an item'),
              items: filteredItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                  fetchRate(value!);
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                calculatePrice();
              },
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }
}

// import 'package:cloneapp/pages/subpages/billing.dart';
// import 'package:cloneapp/pages/subpages/settings/invoicedraft.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:cloneapp/pages/home.dart';

// class InvoiceAdd extends StatefulWidget {
//   final String customerID;
//   const InvoiceAdd({Key? key, required this.customerID}) : super(key: key);

//   @override
//   _InvoiceAddState createState() => _InvoiceAddState();
// }

// class _InvoiceAddState extends State<InvoiceAdd> {
//   String _invoiceId = '';
//   String formattedDate = '';
//   DateTime? _selectedDate;
//   String? _paymentMethod;
//   final List<String> _paymentMethods = [
//     'Advance',
//     'Due on receipt',
//     'Due at end of week',
//     'Due within 15 days',
//     'Due end of the month'
//   ];
//   List<Map<String, dynamic>> _selectedItems = [];
//   String? _customerName;
//   String? _customerAddress;
//   String? _customerEmail;
//   String? _customerWorkPhone;
//   String? _customerMobile;
//   String?  _customerid ;
//   final currentuser = FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//       _fetchCustomerDetails();
//     super.initState();
//     _generateInvoiceId();
//     _formatDate();
  
//   }

//   void _generateInvoiceId() {
//     const length = 5;
//     const chars = 'ABC1234';
//     final random = Random();
//     setState(() {
//       _invoiceId = String.fromCharCodes(Iterable.generate(
//           length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
//     });
//   }

//   void _formatDate() {
//     formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//   }

//   Future<void> _fetchCustomerDetails() async {
//     try {
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentuser!.uid)
//           .collection('customers')
//           .doc(widget.customerID)
//           .get();

//       if (customerSnapshot.exists) {
//         setState(() {
//            String salutation = customerSnapshot['Salutation'] ?? ''; // Fetching salutation
//         String firstName = customerSnapshot['First Name'] ?? ''; 
//                 String lastName = customerSnapshot['Last Name'] ?? ''; 
//           _customerName = '$salutation $firstName $lastName';
//           _customerAddress = customerSnapshot['Address'];
//           _customerEmail = customerSnapshot['Email'];
//           _customerWorkPhone = customerSnapshot['Work-Phone'];
//           _customerMobile = customerSnapshot['Mobile'];
//           _customerid=  customerSnapshot["customerID"];
//         });
//       }
//     } catch (e) {
//       print("Error fetching customer details: $e");
//     }
//   }

//   Future<void> _selectDueDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   void _addItems() async {
//     final Map<String, dynamic>? result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const AddItems()),
//     );
//     if (result != null) {
//       setState(() {
//         _selectedItems.add(result);
//       });
//     }
//   }

//   Future<void> _saveInvoice() async {
//     try {
//       Map<String, dynamic> invoice = {
//         "customerName": _customerName,
//         "customerAddress": _customerAddress,
//         "customerEmail": _customerEmail,
//         "customerID":  widget.customerID,
//         "workphone": _customerWorkPhone,
//         "mobile": _customerMobile,
//         "invoiceId": _invoiceId,
//         "invoiceDate": Timestamp.fromDate(DateTime.now()), // Convert invoice date to Timestamp
//         "paymentMethod": _paymentMethod,
//         "dueDate": _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null, // Convert due date to Timestamp
//         "items": _selectedItems, // Add selected items to the invoice data
//         "status": false
//       };

//       await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("invoices")
//           .doc(_invoiceId)
//           .set(invoice);

//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Success'),
//           content: const Text('Invoice saved successfully'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Invoicedraft(invoiceId: _invoiceId),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//       setState(() {
//         _selectedItems.clear();
//       });
//     } catch (e) {
//       print("Error saving invoice: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("New Invoice"),
//       ),
//       drawer: drawer(context),

// body:  SingleChildScrollView(
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         // // mainAxisAlignment: MainAxisAlignment.end,
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: [
          
//           ListTile(
          
//             title: Text('Customer Name: ${_customerName ?? ''}' ,  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold , decoration: TextDecoration.underline , decorationColor: Colors.white),
//               ),
              
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//   title: Text('Customer Details'),
//   content: SingleChildScrollView(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildDetailRow('Name', _customerName ?? ''),
//         _buildDetailRow('Address', _customerAddress ?? ''),
//         _buildDetailRow('Email', _customerEmail ?? ''),
//         _buildDetailRow('Work Phone', _customerWorkPhone ?? ''),
//         _buildDetailRow('Mobile', _customerMobile ?? ''),
//         _buildDetailRow('Customer ID', widget.customerID ?? ''),
//       ],
//     ),
//   ),
//   actions: [
//     TextButton(
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//       child: Text('Close'),
//     ),
//   ],
// );
//                 },
//               );
//             },
//           ),
//            Icon(Icons.arrow_drop_down),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'Invoice ID: $_invoiceId',
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(width: 105),
//               Text(
//                 '$formattedDate',
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Text(
//                 'Due Date:',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(width: 165),
//               GestureDetector(
//                 onTap: _selectDueDate,
//                 child: Text(
//                   _selectedDate == null
//                       ? '$formattedDate'
//                       : DateFormat('dd-MM-yyyy').format(_selectedDate!),
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//     //       DropdownButtonFormField<String>(
//     //   value: _paymentMethod,
//     //   onChanged: (value) {
//     //     setState(() {
//     //       _paymentMethod = value!;
//     //     });
//     //   },
//     //   decoration: InputDecoration(
//     //     labelText: 'Select Terms of Payment',
//     //     labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
//     //   ),
//     //   items: _paymentMethods.map((String method) {
//     //     return DropdownMenuItem<String>(
//     //       value: method,
//     //       child: Text(method),
//     //     );
//     //   }).toList(),
//     // ),
//           const SizedBox(height: 16),
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blue, width: 2),
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: ElevatedButton(
//               onPressed: _addItems,
//               style: ElevatedButton.styleFrom(
//                 elevation: 0,
//               ),
//               child: Text(
//                 '+ Add inline items',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
//               ),
//             ),
//           ),
//           if (_selectedItems.isNotEmpty) ...[
//             const SizedBox(height: 16),
//             const Text(
//               'Selected Items:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: _selectedItems.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_selectedItems[index]['itemName']),
//                   subtitle: Text('Quantity: ${_selectedItems[index]['quantity']}'),
//                   trailing: Text('Price: \$${_selectedItems[index]['price'].toStringAsFixed(2)}'),
//                 );
//               },
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _saveInvoice,
//               child: const Text('Save Invoice'),
//             ),
//           ],
//         ],
//       ),
//     ),
// )
//   );
// }

 
// Widget _buildDetailRow(String label, String value) {
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: 8.0),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 120, // Adjust as needed
//           child: Text(
//             '$label:',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         SizedBox(width: 12), // Adjust spacing between label and value
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(fontSize: 16),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// }





//   }
// }
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ListView(
//         children: [
//           ListTile(
//             title: Text('Customer Name: ${_customerName ?? ''}'),
//             subtitle: Text('Customer Address: '),
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Customer Details'),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text('Customer Name: ${_customerName ?? ''}'),
//                         Text('Customer Address: ${_customerAddress ?? ''}'),
//                         Text('Customer Email: ${_customerEmail ?? ''}'),
//                          Text('Work Phone: ${_customerWorkPhone ?? ''}'),
//                         Text('Mobile: ${_customerMobile ?? ''}'),
//                         Text(widget.customerID ),
//                       ],
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Close'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//               ),
//                Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//   children: <Widget>[
    
//     Text(
//       'Invoice ID: $_invoiceId', // Display customer ID
//       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//     ),
//     const SizedBox(width: 90,),
//     Text(
//   '$formattedDate',
//   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),

    
//   ],
// ),
//   const SizedBox(height: 10,),              
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Text('Due Date:' ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//                   const SizedBox(width: 155),
//                   GestureDetector(
//                     onTap: _selectDueDate,
//                     child: Text(
//                       _selectedDate == null
//                           ? '$formattedDate'
//                           : DateFormat('dd-MM-yyyy').format(_selectedDate!),
//                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               DropdownButtonFormField<String>(
//                 value: _paymentMethod,
//                 onChanged: (value) {
//                   setState(() {
//                     _paymentMethod = value;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Select Terms of Payment',
//                   labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.black),
//                 ),
//                 items: _paymentMethods.map((String method) {
//                   return DropdownMenuItem<String>(
//                     value: method,
//                     child: Text(method),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 16),
//               Text('Customer Name: ${_customerName ?? ''}'),
//               Text('Customer Address: ${_customerAddress ?? ''}'),
//               Text('Customer Email: ${_customerEmail ?? ''}'),
//               Text('Work Phone: ${_customerWorkPhone ?? ''}'),
//               Text('Mobile: ${_customerMobile ?? ''}'),
//               Text(widget.customerID ),
//               const SizedBox(height: 16),
//               // ElevatedButton(
//               //   onPressed: _addItems,
//               //   child: const Text('Add Items'),
//               // ),
//                Container(
//       width: double.infinity, // Makes the container span the full width
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blue, width: 2), // Blue border
//         borderRadius: BorderRadius.circular(5), // Optional: rounded corners
//       ),
//       child: ElevatedButton(
//         onPressed: _addItems,
//         style: ElevatedButton.styleFrom(
//            // Text color
//           elevation: 0, // Remove shadow
//         ),
//         child: Text(' + Add inline items' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.blue),),
//       ),
//     ),
//               if (_selectedItems.isNotEmpty) ...[
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Selected Items:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: _selectedItems.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(_selectedItems[index]['itemName']),
//                       subtitle: Text('Quantity: ${_selectedItems[index]['quantity']}'),
//                       trailing: Text('Price: \$${_selectedItems[index]['price'].toStringAsFixed(2)}'),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _saveInvoice,
//                   child: const Text('Save Invoice'),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }