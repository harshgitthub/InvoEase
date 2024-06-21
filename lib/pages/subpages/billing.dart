// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:flutter/material.dart';

// // // // // class BillingPage extends StatefulWidget {
// // // // //   final Map<String, dynamic> invoice;

// // // // //   const BillingPage({super.key, required this.invoice});

// // // // //   @override
// // // // //   _BillingPageState createState() => _BillingPageState();
// // // // // }

// // // // // class _BillingPageState extends State<BillingPage> {
// // // // //   List<Map<String, dynamic>> selectedItems = [];
// // // // //   double totalAmount = 0.0;
// // // // //   List<Map<String, dynamic>> availableItems = [];

// // // // //   final currentUser = FirebaseAuth.instance.currentUser;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _fetchAvailableItems();
// // // // //   }

// // // // //   Future<void> _fetchAvailableItems() async {
// // // // //     if (currentUser != null) {
// // // // //       final userItemsRef = FirebaseFirestore.instance
// // // // //           .collection('USERS')
// // // // //           .doc(currentUser!.uid)
// // // // //           .collection('items');

// // // // //       final snapshot = await userItemsRef.get();
// // // // //       final items = snapshot.docs.map((doc) => doc.data()).toList();

// // // // //       setState(() {
// // // // //         availableItems = items.map((item) => {
// // // // //           'Description': item['Description'],
// // // // //           'Selling Price': item['Selling Price'],
// // // // //         }).toList();
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   void _addItem() {
// // // // //     if (availableItems.isNotEmpty) {
// // // // //       setState(() {
// // // // //         selectedItems.add({
// // // // //           'description': availableItems[0]['Description'],
// // // // //           'quantity': 1,
// // // // //           'price': availableItems[0]['Selling Price'],
// // // // //         });
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   void _removeItem(int index) {
// // // // //     setState(() {
// // // // //       selectedItems.removeAt(index);
// // // // //       _calculateTotalAmount();
// // // // //     });
// // // // //   }

// // // // //   void _updateItem(int index, String description, int quantity, int price) {
// // // // //     setState(() {
// // // // //       selectedItems[index] = {
// // // // //         'description': description,
// // // // //         'quantity': quantity,
// // // // //         'price': price,
// // // // //       };
// // // // //       _calculateTotalAmount();
// // // // //     });
// // // // //   }

// // // // //   void _calculateTotalAmount() {

// // // // //     double total = 0.0;
// // // // //     for (var item in selectedItems) {
// // // // //       total += item['quantity'] * item['price'];
// // // // //     }
// // // // //     setState(() {
// // // // //       totalAmount =  total;
// // // // //     });
// // // // //   }



// // // // //     void _submitBill() async {

// // // // //     // if () {
// // // // //     //   showDialog(
// // // // //     //     context: context,
// // // // //     //     builder: (BuildContext context) => AlertDialog(
// // // // //     //       title: Text('Missing Information'),
// // // // //     //       content: Text('Please fill in all required fields.'),
// // // // //     //       actions: <Widget>[
// // // // //     //         TextButton(
// // // // //     //           child: Text('OK'),
// // // // //     //           onPressed: () {
// // // // //     //             Navigator.of(context).pop();
// // // // //     //           },
// // // // //     //         ),
// // // // //     //       ],
// // // // //     //     ),
// // // // //     //   );
// // // // //     //   return;
// // // // //     // }

// // // // //     try {
// // // // //       await FirebaseFirestore.instance
// // // // //           .collection('USERS')
// // // // //           .doc(currentUser!.uid)
// // // // //           .collection('bills')
// // // // //           .doc(widget.invoice['invoiceId'])
// // // // //           .set({
// // // // //         'Customer Name': widget.invoice['customerName'],
// // // // //         'Customer Email': widget.invoice['Email'],
// // // // //         'Customer Address':  widget.invoice['Address'],
// // // // //         'status':widget.invoice['status'],
// // // // //         'Due Date': widget.invoice['dueDate'],
// // // // //         'Invoice Date': DateTime.now(),
// // // // //         'Invoice ID': widget.invoice['invoiceId'],
// // // // //         'Total Bill': totalAmount,
// // // // //         'Procedures': selectedItems,
        
// // // // //       });

// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: const Text('Success'),
// // // // //           content: const Text('Billing information submitted successfully.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: const Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //                 Navigator.pushNamed(context, '/about');
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );

// // // // //       // Clear fields after successful submission
// // // // //       setState(() {
// // // // //         selectedItems.clear();
// // // // //         totalAmount = 0.0;
// // // // //       });
// // // // //     } catch (e) {
// // // // //       print('Error submitting bill: $e');
// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: const Text('Error'),
// // // // //           content: const Text('An error occurred. Please try again later.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: const Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //   }


// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(

// // // // //       appBar: AppBar(
// // // // //         title: _buildInfoRow('Invoice Number:', widget.invoice['invoiceId'] ?? 'N/A'), 
        
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: const EdgeInsets.all(26.0),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             Row(
// // // // //   children: [
// // // // //     Expanded(
// // // // //       child: Container(
// // // // //         padding: const EdgeInsets.all(16.0),
// // // // //         decoration: BoxDecoration(
// // // // //           color: Colors.white,
// // // // //           borderRadius: BorderRadius.circular(12.0),
// // // // //           boxShadow: const [
// // // // //             BoxShadow(
// // // // //               color: Colors.black12,
// // // // //               blurRadius: 8.0,
// // // // //               offset: Offset(0, 2),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             const Row(
// // // // //               children: [
// // // // //                 Icon(Icons.person, color: Colors.blue, size: 28),
// // // // //                 SizedBox(width: 8),
// // // // //                 Text(
// // // // //                   'Customer Details',
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 24,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                     color: Colors.blue,
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //             const SizedBox(height: 16),
// // // // //             _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
// // // // //             _buildInfoRow('Payment Status', widget.invoice['status'] ?? 'N/A'),
// // // // //                   _buildInfoRow('Email:', widget.invoice['Email'] ?? 'N/A'),
// // // // //                   _buildInfoRow('Address:', widget.invoice['Address'] ?? 'N/A'),
// // // // //                    _buildInfoRow('Due Date:',widget.invoice['dueDate']?.toDate().toString() ?? 'No due date',
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     ),
// // // // //     const SizedBox(width: 32),
// // // // //     // Expanded(
// // // // //     //   child: Container(
// // // // //     //     padding: const EdgeInsets.all(16.0),
// // // // //     //     decoration: BoxDecoration(
// // // // //     //       color: Colors.white,
// // // // //     //       borderRadius: BorderRadius.circular(12.0),
// // // // //     //       boxShadow: const [
// // // // //     //         BoxShadow(
// // // // //     //           color: Colors.black12,
// // // // //     //           blurRadius: 8.0,
// // // // //     //           offset: Offset(0, 2),
// // // // //     //         ),
// // // // //     //       ],
// // // // //     //     ),
// // // // //         // child: Column(
// // // // //     //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //     //       children: [
// // // // //     //         const Row(
// // // // //     //           children: [
// // // // //     //             Icon(Icons.receipt, color: Colors.green, size: 28),
// // // // //     //             SizedBox(width: 8),
// // // // //     //             Text(
// // // // //     //               'Invoice Details',
// // // // //     //               style: TextStyle(
// // // // //     //                 fontSize: 24,
// // // // //     //                 fontWeight: FontWeight.bold,
// // // // //     //                 color: Colors.green,
// // // // //     //               ),
// // // // //     //             ),
// // // // //     //           ],
// // // // //     //         ),
// // // // //     //         const SizedBox(height: 16),
// // // // //     // //  _buildInfoRow('Invoice Number:', widget.invoice['invoiceId'] ?? 'N/A'),
// // // // //     //         // _buildInfoRow('Due Date:',widget.invoice['dueDate']?.toDate().toString() ?? 'No due date',
// // // // //     //         // ),
// // // // //     //         // _buildInfoRow('Status:', widget.invoice['procedure'] ?? 'No status'),
// // // // //     //       ],
// // // // //         // ),
// // // // //       // ),
// // // // //     // ),
// // // // //   ],
// // // // // ),
// // // // // const Text(
// // // // //   'Select Items',
// // // // //   style: TextStyle(
// // // // //     fontSize: 24,
// // // // //     fontWeight: FontWeight.bold,
// // // // //   ),
// // // // // ),

// // // // // Expanded(
// // // // //   child: ListView.builder(
// // // // //     itemCount: selectedItems.length,
// // // // //     itemBuilder: (context, index) {
// // // // //       final item = selectedItems[index];
// // // // //       return Card(
// // // // //         margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
// // // // //         elevation: 4.0,
// // // // //         shape: RoundedRectangleBorder(
// // // // //           borderRadius: BorderRadius.circular(12.0),
// // // // //         ),
// // // // //         child: Padding(
// // // // //           padding: const EdgeInsets.all(16.0),
// // // // //           child: Column(
// // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // //             children: [
// // // // //               // Styled Dropdown for item description
// // // // //               InputDecorator(
// // // // //                 decoration: InputDecoration(
// // // // //                   contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
// // // // //                   labelText: 'Description',
// // // // //                   border: OutlineInputBorder(
// // // // //                     borderRadius: BorderRadius.circular(12.0),
// // // // //                   ),
// // // // //                 ),
// // // // //                 child: DropdownButtonHideUnderline(
// // // // //                   child: DropdownButton<String>(
// // // // //                     value: item['description'],
// // // // //                     onChanged: (String? newValue) {
// // // // //                       if (newValue != null) {
// // // // //                         final newItem = availableItems.firstWhere(
// // // // //                           (element) => element['Description'] == newValue,
// // // // //                         );
// // // // //                         _updateItem(index, newValue, item['quantity'], newItem['Selling Price']);
// // // // //                       }
// // // // //                     },
// // // // //                     items: availableItems.map<DropdownMenuItem<String>>((dynamic item) {
// // // // //                       return DropdownMenuItem<String>(
// // // // //                         value: item['Description'],
// // // // //                         child: Text(item['Description']),
// // // // //                       );
// // // // //                     }).toList(),
// // // // //                     isExpanded: true,
// // // // //                     icon: const Icon(Icons.arrow_drop_down),
// // // // //                     style: const TextStyle(
// // // // //                       fontSize: 16,
// // // // //                       color: Colors.black,
// // // // //                     ),
// // // // //                     dropdownColor: Colors.white,
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(height: 16.0),
// // // // //               // Row for quantity input and price display
// // // // //               Row(
// // // // //                 children: [
// // // // //                   Expanded(
// // // // //                     child: TextField(
// // // // //                       decoration: const InputDecoration(
// // // // //                         labelText: 'Quantity',
// // // // //                         border: OutlineInputBorder(),
// // // // //                       ),
// // // // //                       keyboardType: TextInputType.number,
// // // // //                       onChanged: (value) {
// // // // //                         final int quantity = int.tryParse(value) ?? 1;
// // // // //                         _updateItem(index, item['Description'], quantity, item['Selling Price']);
// // // // //                       },
// // // // //                       controller: TextEditingController()
// // // // //                         ..text = item['quantity'].toString(),
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(width: 16.0),
// // // // //                   Text(
// // // // //                     '\$${item['Selling Price'].toString()}',
// // // // //                     style: const TextStyle(
// // // // //                       fontSize: 16,
// // // // //                       fontWeight: FontWeight.bold,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               const SizedBox(height: 16.0),
// // // // //               // Delete button
// // // // //               Align(
// // // // //                 alignment: Alignment.centerRight,
// // // // //                 child: IconButton(
// // // // //                   icon: const Icon(Icons.delete, color: Colors.red),
// // // // //                   onPressed: () => _removeItem(index),
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       );
// // // // //     },
// // // // //   ),
// // // // // ),

// // // // // const SizedBox(height: 16.0),

// // // // // ElevatedButton.icon(
// // // // //   onPressed: _addItem,
// // // // //   icon: const Icon(Icons.add),
// // // // //   label: const Text('Add Item'),
// // // // //   style: ElevatedButton.styleFrom(
// // // // //     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // // //   ),
// // // // // ),

// // // // // const SizedBox(height: 16.0),

// // // // // _buildTotalAmountRow('Total Amount:', totalAmount),

// // // // // const SizedBox(height: 16.0),

// // // // // ElevatedButton.icon(
// // // // //   onPressed: _submitBill,
// // // // //   icon: const Icon(Icons.save),
// // // // //   label: const Text('Save'),
// // // // //   style: ElevatedButton.styleFrom(
// // // // //     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // // //   ),
// // // // // ),

// // // // //           ],
          
// // // // //         ),
        
// // // // //       ),
      
// // // // //     );
// // // // //   }

// // // // //   Widget _buildInfoRow(String label, dynamic value) {
// // // // //   return Row(
// // // // //     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //     children: [
// // // // //       Text(
// // // // //         label,
// // // // //         style: const TextStyle(
// // // // //           fontSize: 16,
// // // // //           fontWeight: FontWeight.bold,
// // // // //         ),
// // // // //       ),
// // // // //      const SizedBox(width: 8),
// // // // //       Flexible(
// // // // //         child: value is bool
// // // // //             ? Text(value ? 'Paid' : 'Unpaid')  // Display "Paid" or "Unpaid" for boolean status
// // // // //             : Text(value ?? 'N/A'),  // Default to 'N/A' if value is null
// // // // //       ),
// // // // //     ],
// // // // //   );
// // // // // }


// // // // //   Widget _buildTotalAmountRow(String label, double amount) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // // // //       child: Row(
// // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //         children: [
// // // // //           Text(
// // // // //             label,
// // // // //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // //           ),
// // // // //           Text(
// // // // //             '\$${amount.toStringAsFixed(2)}',
// // // // //             style: const TextStyle(
// // // // //               fontSize: 16,
// // // // //               fontWeight: FontWeight.bold,
// // // // //               color: Colors.green,
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }



// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:flutter/material.dart';

// // // // // class BillingPage extends StatefulWidget {
// // // // //   final Map<String, dynamic> invoice;

// // // // //   const BillingPage({Key? key, required this.invoice}) : super(key: key);

// // // // //   @override
// // // // //   _BillingPageState createState() => _BillingPageState();
// // // // // }

// // // // // class _BillingPageState extends State<BillingPage> {
// // // // //   List<Map<String, dynamic>> selectedItems = [];
// // // // //   double totalAmount = 0.0;
// // // // //   List<Map<String, dynamic>> availableItems = [];

// // // // //   final currentUser = FirebaseAuth.instance.currentUser;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _fetchAvailableItems();
// // // // //   }

// // // // //   Future<void> _fetchAvailableItems() async {
// // // // //     if (currentUser != null) {
// // // // //       final userItemsRef = FirebaseFirestore.instance
// // // // //           .collection('USERS')
// // // // //           .doc(currentUser!.uid)
// // // // //           .collection('items');

// // // // //       final snapshot = await userItemsRef.get();
// // // // //       final items = snapshot.docs.map((doc) => doc.data()).toList();

// // // // //       setState(() {
// // // // //         availableItems = items.map((item) => {
// // // // //           'Description': item['Description'],
// // // // //           'Selling Price': item['Selling Price'],
// // // // //         }).toList();
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   void _addItem() {
// // // // //     if (availableItems.isNotEmpty) {
// // // // //       setState(() {
// // // // //         selectedItems.add({
// // // // //           'description': availableItems[0]['Description'],
// // // // //           'quantity': 1,
// // // // //           'price': availableItems[0]['Selling Price'],
// // // // //         });
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   void _removeItem(int index) {
// // // // //     setState(() {
// // // // //       selectedItems.removeAt(index);
// // // // //       _calculateTotalAmount();
// // // // //     });
// // // // //   }

// // // // //   void _updateItem(int index, String description, int quantity, int price) {
// // // // //     setState(() {
// // // // //       selectedItems[index] = {
// // // // //         'description': description,
// // // // //         'quantity': quantity,
// // // // //         'price': price,
// // // // //       };
// // // // //       _calculateTotalAmount();
// // // // //     });
// // // // //   }

// // // // //   void _calculateTotalAmount() {
// // // // //     double total = 0.0;
// // // // //     for (var item in selectedItems) {
// // // // //       total += item['quantity'] * item['price'];
// // // // //     }
// // // // //     setState(() {
// // // // //       totalAmount = total;
// // // // //     });
// // // // //   }

// // // // //   void _submitBill() async {
// // // // //     if (selectedItems.isEmpty) {
// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: Text('No Items Selected'),
// // // // //           content: Text('Please add at least one item to submit the bill.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );
// // // // //       return;
// // // // //     }

// // // // //     try {
// // // // //       await FirebaseFirestore.instance
// // // // //           .collection('USERS')
// // // // //           .doc(currentUser!.uid)
// // // // //           .collection('bills')
// // // // //           .doc(widget.invoice['invoiceId'])
// // // // //           .set({
// // // // //         'Customer Name': widget.invoice['customerName'],
// // // // //         'Customer Email': widget.invoice['Email'],
// // // // //         'Customer Address': widget.invoice['Address'],
// // // // //         'status': widget.invoice['status'],
// // // // //         'Due Date': widget.invoice['dueDate'],
// // // // //         'Invoice Date': DateTime.now(),
// // // // //         'Invoice ID': widget.invoice['invoiceId'],
// // // // //         'Total Bill': totalAmount,
// // // // //         'Procedures': selectedItems,
// // // // //       });

// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: const Text('Success'),
// // // // //           content: const Text('Billing information submitted successfully.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: const Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //                 Navigator.pushNamed(context, '/about');
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );

// // // // //       setState(() {
// // // // //         selectedItems.clear();
// // // // //         totalAmount = 0.0;
// // // // //       });
// // // // //     } catch (e) {
// // // // //       print('Error submitting bill: $e');
// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: const Text('Error'),
// // // // //           content: const Text('An error occurred. Please try again later.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: const Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: _buildInfoRow('Invoice Number:', widget.invoice['invoiceId'] ?? 'N/A'),
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: const EdgeInsets.all(26.0),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             // Customer Details Section
// // // // //             Container(
// // // // //               padding: const EdgeInsets.all(16.0),
// // // // //               decoration: BoxDecoration(
// // // // //                 color: Colors.white,
// // // // //                 borderRadius: BorderRadius.circular(12.0),
// // // // //                 boxShadow: const [
// // // // //                   BoxShadow(
// // // // //                     color: Colors.black12,
// // // // //                     blurRadius: 8.0,
// // // // //                     offset: Offset(0, 2),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   const Row(
// // // // //                     children: [
// // // // //                       Icon(Icons.person, color: Colors.blue, size: 28),
// // // // //                       SizedBox(width: 8),
// // // // //                       Text(
// // // // //                         'Customer Details',
// // // // //                         style: TextStyle(
// // // // //                           fontSize: 24,
// // // // //                           fontWeight: FontWeight.bold,
// // // // //                           color: Colors.blue,
// // // // //                         ),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                   const SizedBox(height: 16),
// // // // //                   _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
// // // // //                   _buildInfoRow('Payment Status:', widget.invoice['status'] ?? 'N/A'),
// // // // //                   _buildInfoRow('Email:', widget.invoice['Email'] ?? 'N/A'),
// // // // //                   _buildInfoRow('Address:', widget.invoice['Address'] ?? 'N/A'),
// // // // //                   _buildInfoRow('Due Date:', widget.invoice['dueDate']?.toDate().toString() ?? 'No due date'),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //             const SizedBox(height: 16.0),
// // // // //             // Selected Items Section
// // // // //             Row(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 Expanded(
// // // // //                   child: Container(
// // // // //                     padding: const EdgeInsets.all(16.0),
// // // // //                     decoration: BoxDecoration(
// // // // //                       color: Colors.white,
// // // // //                       borderRadius: BorderRadius.circular(12.0),
// // // // //                       boxShadow: const [
// // // // //                         BoxShadow(
// // // // //                           color: Colors.black12,
// // // // //                           blurRadius: 8.0,
// // // // //                           offset: Offset(0, 2),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                     child: Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                       children: [
// // // // //                         const SizedBox(height: 16),
// // // // //                         const Text(
// // // // //                           'Select Items',
// // // // //                           style: TextStyle(
// // // // //                             fontSize: 24,
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                           ),
// // // // //                         ),
// // // // //                         const SizedBox(height: 16.0),
// // // // //                         // Horizontal Add Item Button
// // // // //                         ElevatedButton.icon(
// // // // //                           onPressed: _addItem,
// // // // //                           icon: const Icon(Icons.add),
// // // // //                           label: const Text('Add Item'),
// // // // //                           style: ElevatedButton.styleFrom(
// // // // //                             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // // //                           ),
// // // // //                         ),
// // // // //                         const SizedBox(height: 16.0),
// // // // //                         // Display Selected Items
// // // // //                         Wrap(
// // // // //                           spacing: 16.0,
// // // // //                           runSpacing: 16.0,
// // // // //                           children: selectedItems.map((item) {
// // // // //                             return Container(
// // // // //                               padding: const EdgeInsets.all(12.0),
// // // // //                               decoration: BoxDecoration(
// // // // //                                 color: Colors.grey[200],
// // // // //                                 borderRadius: BorderRadius.circular(8.0),
// // // // //                               ),
// // // // //                               child: Row(
// // // // //                                 mainAxisSize: MainAxisSize.min,
// // // // //                                 children: [
// // // // //                                   Text(item['description'] ?? ''),
// // // // //                                   const SizedBox(width: 8.0),
// // // // //                                   IconButton(
// // // // //                                     icon: const Icon(Icons.close),
// // // // //                                     onPressed: () => _removeItem(selectedItems.indexOf(item)),
// // // // //                                   ),
// // // // //                                 ],
// // // // //                               ),
// // // // //                             );
// // // // //                           }).toList(),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //             const SizedBox(height: 16.0),
// // // // //             _buildTotalAmountRow('Total Amount:', totalAmount),
// // // // //             const SizedBox(height: 16.0),
// // // // //             ElevatedButton.icon(
// // // // //               onPressed: _submitBill,
// // // // //               icon: const Icon(Icons.save),
// // // // //               label: const Text('Save'),
// // // // //               style: ElevatedButton.styleFrom(
// // // // //                 padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildInfoRow(String label, dynamic value) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // // // //       child: Row(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           Text(
// // // // //             label,
// // // // //             style: const TextStyle(
// // // // //               fontSize: 16,
// // // // //               fontWeight: FontWeight.bold,
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(width: 8),
// // // // //           Flexible(
// // // // //             child: value is bool
// // // // //                 ? Text(value ? 'Paid' : 'Unpaid', style: TextStyle(fontSize: 16, color: value ? Colors.green : Colors.red)) // Display "Paid" or "Unpaid" for boolean status
// // // // //                 : Text(value?.toString() ?? 'N/A'), // Default to 'N/A' if value is null
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildTotalAmountRow(String label, double amount) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // // // //       child: Row(
// // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //         children: [
// // // // //           Text(
// // // // //             label,
// // // // //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // //           ),
// // // // //           Text(
// // // // //             '\$${amount.toStringAsFixed(2)}',
// // // // //             style: const TextStyle(
// // // // //               fontSize: 16,
// // // // //               fontWeight: FontWeight.bold,
// // // // //               color: Colors.green,
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }




// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:flutter/material.dart';

// // // // // class BillingPage extends StatefulWidget {
// // // // //   final Map<String, dynamic> invoice;

// // // // //   const BillingPage({Key? key, required this.invoice}) : super(key: key);

// // // // //   @override
// // // // //   _BillingPageState createState() => _BillingPageState();
// // // // // }

// // // // // class _BillingPageState extends State<BillingPage> {
// // // // //   List<Map<String, dynamic>> selectedItems = [];
// // // // //   double totalAmount = 0.0;
// // // // //   double taxPercentage = 0.0; // Tax percentage entered by the user
// // // // //   List<Map<String, dynamic>> availableItems = [];

// // // // //   final currentUser = FirebaseAuth.instance.currentUser;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _fetchAvailableItems();
// // // // //   }

// // // // //   Future<void> _fetchAvailableItems() async {
// // // // //     if (currentUser != null) {
// // // // //       final userItemsRef = FirebaseFirestore.instance
// // // // //           .collection('USERS')
// // // // //           .doc(currentUser!.uid)
// // // // //           .collection('items');

// // // // //       final snapshot = await userItemsRef.get();
// // // // //       final items = snapshot.docs.map((doc) => doc.data()).toList();

// // // // //       setState(() {
// // // // //         availableItems = items.map((item) => {
// // // // //           'Description': item['Description'],
// // // // //           'Selling Price': item['Selling Price'],
// // // // //         }).toList();
// // // // //       });
// // // // //     }
// // // // //   }

// // // // // void _addItem(BuildContext context) {
// // // // //   showDialog(
// // // // //     context: context,
// // // // //     builder: (BuildContext context) {
// // // // //       int quantity = 1;
// // // // //       Map<String, dynamic>? selectedItem =
// // // // //           availableItems.isNotEmpty ? availableItems[0] : null;

// // // // //       TextEditingController quantityController =
// // // // //           TextEditingController(text: '1');

// // // // //       return StatefulBuilder(
// // // // //         builder: (BuildContext context, setState) {
// // // // //           return AlertDialog(
// // // // //             title: Text('Add Item'),
// // // // //             content: SingleChildScrollView(
// // // // //               child: Column(
// // // // //                 mainAxisSize: MainAxisSize.min,
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   DropdownButtonFormField<Map<String, dynamic>>(
// // // // //                     value: selectedItem,
// // // // //                     onChanged: (value) {
// // // // //                       setState(() {
// // // // //                         selectedItem = value;
// // // // //                       });
// // // // //                     },
// // // // //                     items: availableItems.map((item) {
// // // // //                       return DropdownMenuItem<Map<String, dynamic>>(
// // // // //                         value: item,
// // // // //                         child: Text(item['Description']),
// // // // //                       );
// // // // //                     }).toList(),
// // // // //                     decoration: InputDecoration(
// // // // //                       labelText: 'Item',
// // // // //                       border: OutlineInputBorder(),
// // // // //                     ),
// // // // //                   ),
// // // // //                   SizedBox(height: 16.0),
// // // // //                   Row(
// // // // //                     children: [
// // // // //                       Text('Quantity: '),
// // // // //                       Expanded(
// // // // //                         child: SizedBox(
// // // // //                           width: 50,
// // // // //                           child: TextFormField(
// // // // //                             controller: quantityController,
// // // // //                             keyboardType: TextInputType.number,
// // // // //                             onChanged: (value) {
// // // // //                               quantity = int.tryParse(value) ?? 1;
// // // // //                             },
// // // // //                             decoration: InputDecoration(
// // // // //                               border: OutlineInputBorder(),
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //             actions: <Widget>[
// // // // //               TextButton(
// // // // //                 child: Text('Cancel'),
// // // // //                 onPressed: () {
// // // // //                   Navigator.of(context).pop();
// // // // //                 },
// // // // //               ),
// // // // //               TextButton(
// // // // //                 child: Text('Add'),
// // // // //                 onPressed: () {
// // // // //                   if (selectedItem != null) {
// // // // //                     setState(() {
// // // // //                       selectedItems.add({
// // // // //                         'description': selectedItem!['Description'],
// // // // //                         'quantity': quantity,
// // // // //                         'price': selectedItem!['Selling Price'],
// // // // //                       });
// // // // //                       _calculateTotalAmount();
// // // // //                       Navigator.of(context).pop();
// // // // //                     });
// // // // //                   }
// // // // //                 },
// // // // //               ),
// // // // //             ],
// // // // //           );
// // // // //         },
// // // // //       );
// // // // //     },
// // // // //   );
// // // // // }

// // // // //   void _removeItem(int index) {
// // // // //     setState(() {
// // // // //       selectedItems.removeAt(index);
// // // // //       _calculateTotalAmount();
// // // // //     });
// // // // //   }

// // // // //   void _updateItem(int index, String description, int quantity, int price) {
// // // // //     setState(() {
// // // // //       selectedItems[index] = {
// // // // //         'description': description,
// // // // //         'quantity': quantity,
// // // // //         'price': price,
// // // // //       };
// // // // //       _calculateTotalAmount();
// // // // //     });
// // // // //   }

// // // // //   void _calculateTotalAmount() {
// // // // //     double subtotal = 0.0;
// // // // //     for (var item in selectedItems) {
// // // // //       subtotal += item['quantity'] * item['price'];
// // // // //     }
// // // // //     double taxAmount = (subtotal * (taxPercentage / 100));
// // // // //     setState(() {
// // // // //       totalAmount = subtotal + taxAmount;
// // // // //     });
// // // // //   }

// // // // //   void _submitBill() async {
// // // // //     if (selectedItems.isEmpty) {
// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: Text('No Items Selected'),
// // // // //           content: Text('Please add at least one item to submit the bill.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );
// // // // //       return;
// // // // //     }

// // // // //     try {
// // // // //       await FirebaseFirestore.instance
// // // // //           .collection('USERS')
// // // // //           .doc(currentUser!.uid)
// // // // //           .collection('bills')
// // // // //           .doc(widget.invoice['invoiceId'])
// // // // //           .set({
// // // // //         'Customer Name': widget.invoice['customerName'],
// // // // //         'Customer Email': widget.invoice['Email'],
// // // // //         'Customer Address': widget.invoice['Address'],
// // // // //         'status': widget.invoice['status'],
// // // // //         'Due Date': widget.invoice['dueDate'],
// // // // //         'Invoice Date': DateTime.now(),
// // // // //         'Invoice ID': widget.invoice['invoiceId'],
// // // // //         'Total Bill': totalAmount,
// // // // //         'Procedures': selectedItems,
// // // // //         'Tax Percentage': taxPercentage,
// // // // //       });

// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: const Text('Success'),
// // // // //           content: const Text('Billing information submitted successfully.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: const Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //                 Navigator.pushNamed(context, '/about');
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );

// // // // //       setState(() {
// // // // //         selectedItems.clear();
// // // // //         totalAmount = 0.0;
// // // // //         taxPercentage = 0.0;
// // // // //       });
// // // // //     } catch (e) {
// // // // //       print('Error submitting bill: $e');
// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: const Text('Error'),
// // // // //           content: const Text('An error occurred. Please try again later.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: const Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: _buildInfoRow('Invoice Number:', widget.invoice['invoiceId'] ?? 'N/A'),
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: const EdgeInsets.all(26.0),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             // Customer Details Section
// // // // //             Container(
// // // // //               padding: const EdgeInsets.all(16.0),
// // // // //               decoration: BoxDecoration(
// // // // //                 color: Colors.white,
// // // // //                 borderRadius: BorderRadius.circular(12.0),
// // // // //                 boxShadow: const [
// // // // //                   BoxShadow(
// // // // //                     color: Colors.black12,
// // // // //                     blurRadius: 8.0,
// // // // //                     offset: Offset(0, 2),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   const Row(
// // // // //                     children: [
// // // // //                       Icon(Icons.person, color: Colors.blue, size: 28),
// // // // //                       SizedBox(width: 8),
// // // // //                       Text(
// // // // //                         'Customer Details',
// // // // //                         style: TextStyle(
// // // // //                           fontSize: 24,
// // // // //                           fontWeight: FontWeight.bold,
// // // // //                           color: Colors.blue,
// // // // //                         ),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                   const SizedBox(height: 16),
// // // // //                   _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
// // // // //                   _buildInfoRow('Payment Status:', widget.invoice['status'] ?? 'N/A'),
// // // // //                   _buildInfoRow('Email:', widget.invoice['Email'] ?? 'N/A'),
// // // // //                   _buildInfoRow('Address:', widget.invoice['Address'] ?? 'N/A'),
// // // // //                   _buildInfoRow('Due Date:', widget.invoice['dueDate']?.toDate().toString() ?? 'No due date'),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //             const SizedBox(height: 16.0),
// // // // //             // Selected Items Section
// // // // //             Row(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 Expanded(
// // // // //                   child: Container(
// // // // //                     padding: const EdgeInsets.all(16.0),
// // // // //                     decoration: BoxDecoration(
// // // // //                       color: Colors.white,
// // // // //                       borderRadius: BorderRadius.circular(12.0),
// // // // //                       boxShadow: const [
// // // // //                         BoxShadow(
// // // // //                           color: Colors.black12,
// // // // //                           blurRadius: 8.0,
// // // // //                           offset: Offset(0, 2),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                     child: Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                       children: [
// // // // //                         const SizedBox(height: 16),
// // // // //                         const Text(
// // // // //                           'Select Items',
// // // // //                           style: TextStyle(
// // // // //                             fontSize: 24,
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                           ),
                          
// // // // //                         ),
// // // // //                         const SizedBox(height: 16.0),
// // // // //                         // Display Selected Items
// // // // //                         ListView.builder(
// // // // //   scrollDirection: Axis.horizontal,
// // // // //   itemCount: selectedItems.length,
// // // // //   itemBuilder: (context, index) {
// // // // //     final item = selectedItems[index];
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
// // // // //       child: Column(
// // // // //         children: [
// // // // //           Text(
// // // // //             item['description'],
// // // // //             style: const TextStyle(
// // // // //               fontSize: 16,
// // // // //               fontWeight: FontWeight.bold,
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(height: 4.0),
// // // // //           Text(
// // // // //             'Qty: ${item['quantity']}',
// // // // //             style: TextStyle(fontSize: 12),
// // // // //           ),
// // // // //           const SizedBox(height: 4.0),
// // // // //           Text(
// // // // //             '\$${(item['quantity'] * item['price']).toStringAsFixed(2)}',
// // // // //             style: const TextStyle(
// // // // //               fontSize: 12,
// // // // //               color: Colors.green,
// // // // //             ),
// // // // //           ),
// // // // //           IconButton(
// // // // //             icon: const Icon(Icons.delete, color: Colors.red),
// // // // //             onPressed: () => _removeItem(index),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   },
// // // // // ),

// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(width: 32),
// // // // //                 Expanded(
// // // // //                   child: Container(
// // // // //                     padding: const EdgeInsets.all(16.0),
// // // // //                     decoration: BoxDecoration(
// // // // //                       color: Colors.white,
// // // // //                       borderRadius: BorderRadius.circular(12.0),
// // // // //                       boxShadow: const [
// // // // //                         BoxShadow(
// // // // //                           color: Colors.black12,
// // // // //                           blurRadius: 8.0,
// // // // //                           offset: Offset(0, 2),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                     child: Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                       children: [
// // // //                         // const SizedBox(height: 16.0),
// // // //                         // const Text(
// // // //                         //   'Total Amount',
// // // //                         //   style: TextStyle(
// // // //                         //     fontSize: 24,
// // // //                         //     fontWeight: FontWeight.bold,
// // // //                         //   ),
// // // //                         // ),
// // // //                         // const SizedBox(height: 16.0),
// // // //                         // _buildTotalAmountRow('Subtotal:', _calculateSubtotal()),
// // // //                         // const SizedBox(height: 8.0),
// // // //                         // _buildTaxInput(),
// // // //                         // const SizedBox(height: 16.0),
// // // //                         // _buildTotalAmountRow('Total:', totalAmount),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //             const SizedBox(height: 16.0),
// // // // //             ElevatedButton.icon(
// // // // //               onPressed: () => _addItem(context),
// // // // //               icon: const Icon(Icons.add),
// // // // //               label: const Text('Add Item'),
// // // // //               style: ElevatedButton.styleFrom(
// // // // //                 padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // // //               ),
// // // // //             ),
// // // // //             const SizedBox(height: 16.0),
// // // // //             ElevatedButton.icon(
// // // // //               onPressed: _submitBill,
// // // // //               icon: const Icon(Icons.save),
// // // // //               label: const Text('Save'),
// // // // //               style: ElevatedButton.styleFrom(
// // // // //                 padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //  Widget _buildQuantityRow(int index) {
// // // // //   final item = selectedItems[index];
// // // // //   return Row(
// // // // //     children: [
// // // // //       Text('Quantity: '),
// // // // //       Expanded(
// // // // //         child: SizedBox(
// // // // //           width: 50,
// // // // //           child: TextFormField(
// // // // //             initialValue: item['quantity'].toString(),
// // // // //             keyboardType: TextInputType.number,
// // // // //             onChanged: (value) {
// // // // //               int quantity = int.tryParse(value) ?? 1;
// // // // //               _updateItem(index, item['description'], quantity, item['price']);
// // // // //             },
// // // // //             decoration: InputDecoration(
// // // // //               border: OutlineInputBorder(),
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     ],
// // // // //   );
// // // // // }

// // // // //   Widget _buildTaxInput() {
// // // // //     return TextFormField(
// // // // //       keyboardType: TextInputType.numberWithOptions(decimal: true),
// // // // //       onChanged: (value) {
// // // // //         setState(() {
// // // // //           taxPercentage = double.tryParse(value) ?? 0.0;
// // // // //           _calculateTotalAmount();
// // // // //         });
// // // // //       },
// // // // //       decoration: InputDecoration(
// // // // //         labelText: 'Tax %',
// // // // //         border: OutlineInputBorder(),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildInfoRow(String label, dynamic value) {
// // // // //     return Row(
// // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //       children: [
// // // // //         Text(
// // // // //           label,
// // // // //           style: const TextStyle(
// // // // //             fontSize: 16,
// // // // //             fontWeight: FontWeight.bold,
// // // // //           ),
// // // // //         ),
// // // // //         const SizedBox(width: 8),
// // // // //         Flexible(
// // // // //           child: value is bool
// // // // //               ? Text(value ? 'Paid' : 'Unpaid') // Display "Paid" or "Unpaid" for boolean status
// // // // //               : Text(value ?? 'N/A', style: TextStyle(fontSize: 16)), // Default to 'N/A' if value is null
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _buildTotalAmountRow(String label, double amount) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // // // //       child: Row(
// // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //         children: [
// // // // //           Text(
// // // // //             label,
// // // // //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // //           ),
// // // // //           Text(
// // // // //             '\$${amount.toStringAsFixed(2)}',
// // // // //             style: const TextStyle(
// // // // //               fontSize: 16,
// // // // //               fontWeight: FontWeight.bold,
// // // // //               color: Colors.green,
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // //   // double _calculateSubtotal() {
// // // //   //   double subtotal = 0.0;
// // // //   //   for (var item in selectedItems) {
// // // //   //     subtotal += item['quantity'] * item['price'];
// // // //   //   }
// // // //   //   return subtotal;
// // // //   // }
// // // // // }

// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:flutter/material.dart';

// // // // // class BillingPage extends StatefulWidget {
// // // // //   final Map<String, dynamic> invoice;

// // // // //   const BillingPage({Key? key, required this.invoice}) : super(key: key);

// // // // //   @override
// // // // //   _BillingPageState createState() => _BillingPageState();
// // // // // }

// // // // // class _BillingPageState extends State<BillingPage> {
// // // // //   List<Map<String, dynamic>> selectedItems = [];
// // // // //   double totalAmount = 0.0;
// // // // //   double taxPercentage = 0.0;
// // // // //   List<Map<String, dynamic>> availableItems = [];

// // // // //   final currentUser = FirebaseAuth.instance.currentUser;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _fetchAvailableItems();
// // // // //   }

// // // // //   Future<void> _fetchAvailableItems() async {
// // // // //     if (currentUser != null) {
// // // // //       final userItemsRef = FirebaseFirestore.instance
// // // // //           .collection('USERS')
// // // // //           .doc(currentUser!.uid)
// // // // //           .collection('items');

// // // // //       final snapshot = await userItemsRef.get();
// // // // //       final items = snapshot.docs.map((doc) => doc.data()).toList();

// // // // //       setState(() {
// // // // //         availableItems = items.map((item) => {
// // // // //           'Description': item['Description'],
// // // // //           'Selling Price': item['Selling Price'],
// // // // //         }).toList();
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   void _addItem(BuildContext context) {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (BuildContext context) {
// // // // //         int quantity = 1;
// // // // //         Map<String, dynamic>? selectedItem = availableItems.isNotEmpty ? availableItems[0] : null;

// // // // //         TextEditingController quantityController = TextEditingController(text: '1');

// // // // //         return StatefulBuilder(
// // // // //           builder: (BuildContext context, setState) {
// // // // //             return AlertDialog(
// // // // //               title: Text('Add Item'),
// // // // //               content: SingleChildScrollView(
// // // // //                 child: Column(
// // // // //                   mainAxisSize: MainAxisSize.min,
// // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                   children: [
// // // // //                     DropdownButtonFormField<Map<String, dynamic>>(
// // // // //                       value: selectedItem,
// // // // //                       onChanged: (value) {
// // // // //                         setState(() {
// // // // //                           selectedItem = value;
// // // // //                         });
// // // // //                       },
// // // // //                       items: availableItems.map((item) {
// // // // //                         return DropdownMenuItem<Map<String, dynamic>>(
// // // // //                           value: item,
// // // // //                           child: Text(item['Description']),
// // // // //                         );
// // // // //                       }).toList(),
// // // // //                       decoration: InputDecoration(
// // // // //                         labelText: 'Item',
// // // // //                         border: OutlineInputBorder(),
// // // // //                       ),
// // // // //                     ),
// // // // //                     SizedBox(height: 16.0),
// // // // //                     Row(
// // // // //                       children: [
// // // // //                         Text('Quantity: '),
// // // // //                         Expanded(
// // // // //                           child: SizedBox(
// // // // //                             width: 50,
// // // // //                             child: TextFormField(
// // // // //                               controller: quantityController,
// // // // //                               keyboardType: TextInputType.number,
// // // // //                               onChanged: (value) {
// // // // //                                 quantity = int.tryParse(value) ?? 1;
// // // // //                               },
// // // // //                               decoration: InputDecoration(
// // // // //                                 border: OutlineInputBorder(),
// // // // //                               ),
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //               actions: <Widget>[
// // // // //                 TextButton(
// // // // //                   child: Text('Cancel'),
// // // // //                   onPressed: () {
// // // // //                     Navigator.of(context).pop();
// // // // //                   },
// // // // //                 ),
// // // // //                 TextButton(
// // // // //                   child: Text('Add'),
// // // // //                   onPressed: () {
// // // // //                     if (selectedItem != null) {
// // // // //                       setState(() {
// // // // //                         selectedItems.add({
// // // // //                           'description': selectedItem!['Description'],
// // // // //                           'quantity': quantity,
// // // // //                           'price': selectedItem!['Selling Price'],
// // // // //                         });
// // // // //                         _calculateTotalAmount();
// // // // //                         Navigator.of(context).pop();
// // // // //                       });
// // // // //                     }
// // // // //                   },
// // // // //                 ),
// // // // //               ],
// // // // //             );
// // // // //           },
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   void _removeItem(int index) {
// // // // //     setState(() {
// // // // //       selectedItems.removeAt(index);
// // // // //       _calculateTotalAmount();
// // // // //     });
// // // // //   }

// // // // //   void _updateItem(int index, String description, int quantity, int price) {
// // // // //     setState(() {
// // // // //       selectedItems[index] = {
// // // // //         'description': description,
// // // // //         'quantity': quantity,
// // // // //         'price': price,
// // // // //       };
// // // // //       _calculateTotalAmount();
// // // // //     });
// // // // //   }

// // // //   // void _calculateTotalAmount() {
// // // //   //   double subtotal = 0.0;
// // // //   //   for (var item in selectedItems) {
// // // //   //     subtotal += item['quantity'] * item['price'];
// // // //   //   }
// // // //   //   double taxAmount = (subtotal * (taxPercentage / 100));
// // // //   //   setState(() {
// // // //   //     totalAmount = subtotal + taxAmount;
// // // //   //   });
// // // //   // }

// // // // //   void _submitBill() async {
// // // // //     if (selectedItems.isEmpty) {
// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: Text('No Items Selected'),
// // // // //           content: Text('Please add at least one item to submit the bill.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );
// // // // //       return;
// // // // //     }

// // // // //     try {
// // // // //       await FirebaseFirestore.instance
// // // // //           .collection('USERS')
// // // // //           .doc(currentUser!.uid)
// // // // //           .collection('bills')
// // // // //           .doc(widget.invoice['invoiceId'])
// // // // //           .set({
// // // // //             'Customer Name': widget.invoice['customerName'],
// // // // //             'Customer Email': widget.invoice['Email'],
// // // // //             'Customer Address': widget.invoice['Address'],
// // // // //             'status': widget.invoice['status'],
// // // // //             'Due Date': widget.invoice['dueDate'],
// // // // //             'Invoice Date': DateTime.now(),
// // // // //             'Invoice ID': widget.invoice['invoiceId'],
// // // // //             'Total Bill': totalAmount,
// // // // //             'Procedures': selectedItems,
// // // // //             'Tax Percentage': taxPercentage,
// // // // //           });

// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: const Text('Success'),
// // // // //           content: const Text('Billing information submitted successfully.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: const Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //                 Navigator.pushNamed(context, '/about');
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );

// // // // //       setState(() {
// // // // //         selectedItems.clear();
// // // // //         totalAmount = 0.0;
// // // // //         taxPercentage = 0.0;
// // // // //       });
// // // // //     } catch (e) {
// // // // //       print('Error submitting bill: $e');
// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: const Text('Error'),
// // // // //           content: const Text('An error occurred. Please try again later.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: const Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Billing Page'),
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: const EdgeInsets.all(16.0),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.stretch,
// // // // //           children: [
// // // // //             // Customer Details Card
// // // // //             Card(
// // // // //               elevation: 4.0,
// // // // //               child: Padding(
// // // // //                 padding: const EdgeInsets.all(16.0),
// // // // //                 child: Column(
// // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                   children: [
// // // // //                     Text(
// // // // //                       'Customer Details',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 20,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                       ),
// // // // //                     ),
// // // // //                     SizedBox(height: 8.0),
// // // // //                     _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
// // // // //                     _buildInfoRow('Payment Status:', widget.invoice['status'] ?? 'N/A'),
// // // // //                     _buildInfoRow('Email:', widget.invoice['Email'] ?? 'N/A'),
// // // // //                     _buildInfoRow('Address:', widget.invoice['Address'] ?? 'N/A'),
// // // // //                     _buildInfoRow('Due Date:', widget.invoice['dueDate']?.toDate().toString() ?? 'No due date'),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 16.0),
// // // // //             ElevatedButton.icon(
// // // // //               onPressed: () => _addItem(context),
// // // // //               icon: Icon(Icons.add),
// // // // //               label: Text('Add Item'),
// // // // //               style: ElevatedButton.styleFrom(
// // // // //                 padding: EdgeInsets.symmetric(vertical: 12.0),
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 16.0),
// // // // //             Expanded(
// // // // //               child: ListView.builder(
// // // // //                 itemCount: selectedItems.length,
// // // // //                 itemBuilder: (context, index) {
// // // // //                   final item = selectedItems[index];
// // // // //                   return ListTile(
// // // // //                     title: Text(item['description']),
// // // // //                     subtitle: Text('Qty: ${item['quantity']}'),
// // // // //                     trailing: Text('\$${(item['quantity'] * item['price']).toStringAsFixed(2)}'),
// // // // //                     onTap: () {
// // // // //                       // Optionally implement an action when tapping on an item in the list
// // // // //                     },
// // // // //                   );
// // // // //                 },
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 16.0),
// // // // //             ElevatedButton.icon(
// // // // //   onPressed: () {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (BuildContext context) => AlertDialog(
// // // // //         title: Text('Selected Items Checklist'),
// // // // //         content: Container(
// // // // //           width: double.maxFinite,
// // // // //           child: Column(
// // // // //             mainAxisSize: MainAxisSize.min,
// // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // //             children: [
// // // // //               Expanded(
// // // // //                 child: ListView.builder(
// // // // //                   shrinkWrap: true,
// // // // //                   itemCount: selectedItems.length,
// // // // //                   itemBuilder: (context, index) {
// // // // //                     final item = selectedItems[index];
// // // // //                     return ListTile(
// // // // //                       title: Text(item['description']),
// // // // //                       subtitle: Text('Qty: ${item['quantity']}'),
// // // // //                       trailing: Text('\$${(item['quantity'] * item['price']).toStringAsFixed(2)}'),
// // // // //                     );
// // // // //                   },
// // // // //                 ),
// // // // //               ),
// // // // //               SizedBox(height: 16.0),
// // // // //               Text(
// // // // //                 'Total Amount',
// // // // //                 style: TextStyle(
// // // // //                   fontSize: 24,
// // // // //                   fontWeight: FontWeight.bold,
// // // // //                 ),
// // // // //               ),
// // // // //               SizedBox(height: 8.0),
// // // // //               _buildTotalAmountRow('Subtotal:', _calculateSubtotal()),
// // // // //               SizedBox(height: 8.0),
// // // // //               _buildTaxInput(),
// // // // //               SizedBox(height: 16.0),
// // // // //               _buildTotalAmountRow('Total:', ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //         actions: <Widget>[
// // // // //           TextButton(
// // // // //             child: Text('Close'),
// // // // //             onPressed: () {
// // // // //               Navigator.of(context).pop();
// // // // //             },
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   },
// // // // //   icon: Icon(Icons.view_list),
// // // // //   label: Text('View Checklist'),
// // // // //   style: ElevatedButton.styleFrom(
// // // // //     padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // // //   ),
// // // // // ),

// // // // //             SizedBox(height: 16.0),
// // // // //             ElevatedButton.icon(
// // // // //               onPressed: _submitBill,
// // // // //               icon: Icon(Icons.save),
// // // // //               label: Text('Save'),
// // // // //               style: ElevatedButton.styleFrom(
// // // // //                 padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildInfoRow(String label, dynamic value) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 4.0),
// // // // //       child: Row(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           Text(
// // // // //             label,
// // // // //             style: TextStyle(
// // // // //               fontWeight: FontWeight.bold,
// // // // //             ),
// // // // //           ),
// // // // //           SizedBox(width: 8.0),
// // // // //           Expanded(
// // // // //             child: Text(
// // // // //               value != null ? value.toString() : 'N/A',
// // // // //               style: TextStyle(fontSize: 16),
// // // // //             ),
// // // // //           )
// // // // //       ])
// // // // //     );
// // // // //   }

// // // //   //   Widget _buildTaxInput() {
// // // //   //   return TextFormField(
// // // //   //     keyboardType: TextInputType.numberWithOptions(decimal: true),
// // // //   //     onChanged: (value) {
// // // //   //       setState(() {
// // // //   //         taxPercentage = double.tryParse(value) ?? 0.0;
// // // //   //         _calculateTotalAmount();
// // // //   //       });
// // // //   //     },
// // // //   //     decoration: InputDecoration(
// // // //   //       labelText: 'Tax %',
// // // //   //       border: OutlineInputBorder(),
// // // //   //     ),
// // // //   //   );
// // // //   // }

// // // // //   // Widget _buildInfoRow(String label, dynamic value) {
// // // // //   //   return Row(
// // // // //   //     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //   //     children: [
// // // // //   //       Text(
// // // // //   //         label,
// // // // //   //         style: const TextStyle(
// // // // //   //           fontSize: 16,
// // // // //   //           fontWeight: FontWeight.bold,
// // // // //   //         ),
// // // // //   //       ),
// // // // //   //       const SizedBox(width: 8),
// // // // //   //       Flexible(
// // // // //   //         child: value is bool
// // // // //   //             ? Text(value ? 'Paid' : 'Unpaid') // Display "Paid" or "Unpaid" for boolean status
// // // // //   //             : Text(value ?? 'N/A', style: TextStyle(fontSize: 16)), // Default to 'N/A' if value is null
// // // // //   //       ),
// // // // //   //     ],
// // // // //   //   );
// // // // //   // }

// // // // //   Widget _buildTotalAmountRow(String label, double amount) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // // // //       child: Row(
// // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //         children: [
// // // // //           Text(
// // // // //             label,
// // // // //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // //           ),
// // // // //           Text(
// // // // //             '\$${amount.toStringAsFixed(2)}',
// // // // //             style: const TextStyle(
// // // // //               fontSize: 16,
// // // // //               fontWeight: FontWeight.bold,
// // // // //               color: Colors.green,
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // //   // void _calculateTotalAmount() {
// // // //   //   double subtotal = 0.0;
// // // //   //   for (var item in selectedItems) {
// // // //   //     subtotal += item['quantity'] * item['price'];
// // // //   //   }
// // // //   //   double taxAmount = (subtotal * (taxPercentage / 100));
// // // //   //   setState(() {
// // // //   //     totalAmount = subtotal + taxAmount;
// // // //   //   });
// // // //   // }

// // // // // //   }



// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:flutter/material.dart';

// // // // // class BillingPage extends StatefulWidget {
// // // // //   final Map<String, dynamic> invoice;

// // // // //   const BillingPage({Key? key, required this.invoice}) : super(key: key);

// // // // //   @override
// // // // //   _BillingPageState createState() => _BillingPageState();
// // // // // }

// // // // // class _BillingPageState extends State<BillingPage> {
// // // // //   List<Map<String, dynamic>> selectedItems = [];
// // // // //   double totalAmount = 0.0;
// // // // //   double taxPercentage = 0.0;
// // // // //   List<Map<String, dynamic>> availableItems = [];

// // // // //   final currentUser = FirebaseAuth.instance.currentUser;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _fetchAvailableItems();
// // // // //   }

// // // // //   Future<void> _fetchAvailableItems() async {
// // // // //     if (currentUser != null) {
// // // // //       final userItemsRef = FirebaseFirestore.instance
// // // // //           .collection('USERS')
// // // // //           .doc(currentUser!.uid)
// // // // //           .collection('items');

// // // // //       final snapshot = await userItemsRef.get();
// // // // //       final items = snapshot.docs.map((doc) => doc.data()).toList();

// // // // //       setState(() {
// // // // //         availableItems = items.map((item) => {
// // // // //           'Description': item['Description'],
// // // // //           'Selling Price': item['Selling Price'],
// // // // //         }).toList();
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   void _addItem(BuildContext context) {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (BuildContext context) {
// // // // //         int quantity = 1;
// // // // //         Map<String, dynamic>? selectedItem =
// // // // //             availableItems.isNotEmpty ? availableItems[0] : null;

// // // // //         TextEditingController quantityController =
// // // // //             TextEditingController(text: '1');

// // // // //         return StatefulBuilder(
// // // // //           builder: (BuildContext context, setState) {
// // // // //             return AlertDialog(
// // // // //               title: Text('Add Item'),
// // // // //               content: SingleChildScrollView(
// // // // //                 child: Column(
// // // // //                   mainAxisSize: MainAxisSize.min,
// // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                   children: [
// // // // //                     DropdownButtonFormField<Map<String, dynamic>>(
// // // // //                       value: selectedItem,
// // // // //                       onChanged: (value) {
// // // // //                         setState(() {
// // // // //                           selectedItem = value;
// // // // //                         });
// // // // //                       },
// // // // //                       items: availableItems.map((item) {
// // // // //                         return DropdownMenuItem<Map<String, dynamic>>(
// // // // //                           value: item,
// // // // //                           child: Text(item['Description']),
// // // // //                         );
// // // // //                       }).toList(),
// // // // //                       decoration: InputDecoration(
// // // // //                         labelText: 'Item',
// // // // //                         border: OutlineInputBorder(),
// // // // //                       ),
// // // // //                     ),
// // // // //                     SizedBox(height: 16.0),
// // // // //                     Row(
// // // // //                       children: [
// // // // //                         Text('Quantity: '),
// // // // //                         Expanded(
// // // // //                           child: SizedBox(
// // // // //                             width: 50,
// // // // //                             child: TextFormField(
// // // // //                               controller: quantityController,
// // // // //                               keyboardType: TextInputType.number,
// // // // //                               onChanged: (value) {
// // // // //                                 quantity = int.tryParse(value) ?? 1;
// // // // //                               },
// // // // //                               decoration: InputDecoration(
// // // // //                                 border: OutlineInputBorder(),
// // // // //                               ),
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //               actions: <Widget>[
// // // // //                 TextButton(
// // // // //                   child: Text('Cancel'),
// // // // //                   onPressed: () {
// // // // //                     Navigator.of(context).pop();
// // // // //                   },
// // // // //                 ),
// // // // //                 TextButton(
// // // // //                   child: Text('Add'),
// // // // //                   onPressed: () {
// // // // //                     if (selectedItem != null) {
// // // // //                       setState(() {
// // // // //                         selectedItems.add({
// // // // //                           'description': selectedItem!['Description'],
// // // // //                           'quantity': quantity,
// // // // //                           'price': selectedItem!['Selling Price'],
// // // // //                         });
// // // // //                         _calculateTotalAmount();
// // // // //                         Navigator.of(context).pop();
// // // // //                       });
// // // // //                     }
// // // // //                   },
// // // // //                 ),
// // // // //               ],
// // // // //             );
// // // // //           },
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   void _removeItem(int index) {
// // // // //     setState(() {
// // // // //       selectedItems.removeAt(index);
// // // // //       _calculateTotalAmount();
// // // // //     });
// // // // //   }

// // // // //   void _updateItem(int index, String description, int quantity, int price) {
// // // // //     setState(() {
// // // // //       selectedItems[index] = {
// // // // //         'description': description,
// // // // //         'quantity': quantity,
// // // // //         'price': price,
// // // // //       };
// // // // //       _calculateTotalAmount();
// // // // //     });
// // // // //   }

// // // // //     Widget _buildTaxInput() {
// // // // //     return TextFormField(
// // // // //       keyboardType: TextInputType.numberWithOptions(decimal: true),
// // // // //       onChanged: (value) {
// // // // //         setState(() {
// // // // //           taxPercentage = double.tryParse(value) ?? 0.0;
// // // // //           _calculateTotalAmount();
// // // // //         });
// // // // //       },
// // // // //       decoration: InputDecoration(
// // // // //         labelText: 'Tax %',
// // // // //         border: OutlineInputBorder(),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //   void _calculateTotalAmount() {
// // // // //     double subtotal = 0.0;
// // // // //     for (var item in selectedItems) {
// // // // //       subtotal += item['quantity'] * item['price'];
// // // // //     }
// // // // //     double taxAmount = (subtotal * (taxPercentage / 100));
// // // // //     setState(() {
// // // // //       totalAmount = subtotal + taxAmount;
// // // // //     });
// // // // //   }

// // // // //   void _submitBill() async {
// // // // //     if (selectedItems.isEmpty) {
// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: Text('No Items Selected'),
// // // // //           content: Text('Please add at least one item to submit the bill.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );
// // // // //       return;
// // // // //     }

// // // // //     try {
// // // // //       await FirebaseFirestore.instance
// // // // //           .collection('USERS')
// // // // //           .doc(currentUser!.uid)
// // // // //           .collection('bills')
// // // // //           .doc(widget.invoice['invoiceId'])
// // // // //           .set({
// // // // //         'Customer Name': widget.invoice['customerName'],
// // // // //         'Customer Email': widget.invoice['customerEmail'],
// // // // //         'Customer Address': widget.invoice['Address'],
// // // // //         'status': widget.invoice['status'],
// // // // //         'Due Date': widget.invoice['dueDate'],
// // // // //         'Invoice Date': DateTime.now(),
// // // // //         'Invoice ID': widget.invoice['invoiceId'],
// // // // //         'Total Bill': totalAmount,
// // // // //         'Procedures': selectedItems,
// // // // //         'Tax Percentage': taxPercentage,
// // // // //       });

// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: const Text('Success'),
// // // // //           content: const Text('Billing information submitted successfully.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: const Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //                 Navigator.pushNamed(context, '/about');
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );

// // // // //       setState(() {
// // // // //         selectedItems.clear();
// // // // //         totalAmount = 0.0;
// // // // //         taxPercentage = 0.0;
// // // // //       });
// // // // //     } catch (e) {
// // // // //       print('Error submitting bill: $e');
// // // // //       showDialog(
// // // // //         context: context,
// // // // //         builder: (BuildContext context) => AlertDialog(
// // // // //           title: const Text('Error'),
// // // // //           content: const Text('An error occurred. Please try again later.'),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               child: const Text('OK'),
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Billing Page'),
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: const EdgeInsets.all(16.0),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.stretch,
// // // // //           children: [
// // // // //             // Customer Details Card
// // // // //             Card(
// // // // //               elevation: 4.0,
// // // // //               child: Padding(
// // // // //                 padding: const EdgeInsets.all(16.0),
// // // // //                 child: Column(
// // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                   children: [
// // // // //                     Text(
// // // // //                       'Customer Details',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 20,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                       ),
// // // // //                     ),
// // // // //                     SizedBox(height: 8.0),
// // // // //                     _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
// // // // //                     _buildInfoRow('Payment Status:', widget.invoice['status'] ?? 'N/A'),
// // // // //                     _buildInfoRow('Email:', widget.invoice['customerEmail'] ?? 'N/A'),
// // // // //                     _buildInfoRow('Address:', widget.invoice['Address'] ?? 'N/A'),
// // // // //                     _buildInfoRow('Due Date:', widget.invoice['dueDate']?.toDate().toString() ?? 'No due date'),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 16.0),
// // // // //             ElevatedButton.icon(
// // // // //               onPressed: () => _addItem(context),
// // // // //               icon: Icon(Icons.add),
// // // // //               label: Text('Add Item'),
// // // // //               style: ElevatedButton.styleFrom(
// // // // //                 padding: EdgeInsets.symmetric(vertical: 12.0),
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 16.0),
// // // // //             Expanded(
// // // // //               child: ListView.builder(
// // // // //                 itemCount: selectedItems.length,
// // // // //                 itemBuilder: (context, index) {
// // // // //                   final item = selectedItems[index];
// // // // //                   return ListTile(
// // // // //                     title: Text(item['description']),
// // // // //                     subtitle: Text('Qty: ${item['quantity']}'),
// // // // //                     trailing: Text('\$${(item['quantity'] * item['price']).toStringAsFixed(2)}'),
// // // // //                     onTap: () {
// // // // //                       // Optionally implement an action when tapping on an item in the list
// // // // //                     },
// // // // //                   );
// // // // //                 },
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 16.0),
// // // // //             ElevatedButton.icon(
// // // // //               onPressed: () {
// // // // //                 showDialog(
// // // // //                   context: context,
// // // // //                   builder: (BuildContext context) => AlertDialog(
// // // // //                     title: Text('Selected Items Checklist'),
// // // // //                     content: Container(
// // // // //                       width: double.maxFinite,
// // // // //                       child: Column(
// // // // //                         mainAxisSize: MainAxisSize.min,
// // // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                         children: [
// // // // //                           Expanded(
// // // // //                             child: ListView.builder(
// // // // //   itemCount: selectedItems.length,
// // // // //   itemBuilder: (context, index) {
// // // // //     final item = selectedItems[index];
// // // // //     return ListTile(
// // // // //       title: Text(item['description']),
// // // // //       subtitle: Text('Qty: ${item['quantity']}'),
// // // // //        trailing: Row(
// // // // //     mainAxisSize: MainAxisSize.min, // Ensure the row only takes up the space it needs
// // // // //     children: [
// // // // //       Text('\$${(item['quantity'] * item['price']).toStringAsFixed(2)}'),
// // // // //       IconButton(
// // // // //         icon: Icon(Icons.cancel),
// // // // //         onPressed: () {
// // // // //           _removeItem(index); // Call remove function with the index of the item
// // // // //         },
// // // // //       ),
// // // // //     ],
// // // // //   ),
// // // // //   onTap: () {
// // // // //     // Optionally implement an action when tapping on an item in the list
  
// // // // //   },
// // // // //     );
// // // // //   }
// // // // //                             )
// // // // //                           ),          
// // // // //                           SizedBox(height: 16.0),
// // // // //                           Text(
// // // // //                             'Total Amount',
// // // // //                             style: TextStyle(
// // // // //                               fontSize: 24,
// // // // //                               fontWeight: FontWeight.bold,
// // // // //                             ),
// // // // //                           ),
// // // // //                           SizedBox(height: 8.0),
// // // // //                           _buildTotalAmountRow('Subtotal:', totalAmount ),
// // // // //                           SizedBox(height: 8.0),
// // // // //                           _buildTaxInput(),
// // // // //                           SizedBox(height: 16.0),
// // // // //                           _buildTotalAmountRow('Total:', totalAmount ),
// // // // //                         ],
// // // // //                       ),
// // // // //                     ),
// // // // //                     actions: <Widget>[
// // // // //                       TextButton(
// // // // //                         child: Text('Close'),
// // // // //                         onPressed: () {
// // // // //                           Navigator.of(context).pop();
// // // // //                         },
// // // // //                       ),
// // // // //                     ]));
                  
// // // // //                 },
// // // // //                 icon: Icon(Icons.view_list),
// // // // //                 label: Text('View Checklist'),
// // // // //                 style: ElevatedButton.styleFrom(
// // // // //                   padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // // //                 ),
// // // // //               ),
// // // // //               SizedBox(height: 16.0),
// // // // //               ElevatedButton.icon(
// // // // //                 onPressed: _submitBill,
// // // // //                 icon: Icon(Icons.save),
// // // // //                 label: Text('Save'),
// // // // //                 style: ElevatedButton.styleFrom(
// // // // //                   padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ));
// // // // //   }

// // // // //   Widget _buildInfoRow(String label, dynamic value) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 4.0),
// // // // //       child: Row(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           Text(
// // // // //             label,
// // // // //             style: TextStyle(
// // // // //               fontWeight: FontWeight.bold,
// // // // //             ),
// // // // //           ),
// // // // //           SizedBox(width: 8.0),
// // // // //           Expanded(
// // // // //             child: Text(
// // // // //               value != null ? value.toString() : 'N/A',
// // // // //               style: TextStyle(fontSize: 16),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   // Widget _buildTaxInput() {
// // // // //   //   return TextFormField(
// // // // //   //     keyboardType: TextInputType.numberWithOptions(decimal: true),
// // // // //   //     onChanged: (value) {
// // // // //   //       setState(() {
// // // // //   //         taxPercentage = double.tryParse(value) ?? 0.0;
// // // // //   //         _calculateTotalAmount();
// // // // //   //       });
// // // // //   //     },
// // // // //   //     decoration: InputDecoration(
// // // // //   //       labelText: 'Tax %',
// // // // //   //       border: OutlineInputBorder(),
// // // // //   //     ),
// // // // //   //   );
// // // // //   // }

// // // // //   Widget _buildTotalAmountRow(String label, double amount) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // // // //       child: Row(
// // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //         children: [
// // // // //           Text(
// // // // //             label,
// // // // //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // //           ),
// // // // //           Text(
// // // // //             '\$${amount.toStringAsFixed(2)}',
// // // // //             style: const TextStyle(
// // // // //               fontSize: 16,
// // // // //               fontWeight: FontWeight.bold,
// // // // //               color: Colors.green,
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }



// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:flutter/material.dart';

// // // // class BillingPage extends StatefulWidget {
// // // //   final Map<String, dynamic> invoice;

// // // //   const BillingPage({Key? key, required this.invoice}) : super(key: key);

// // // //   @override
// // // //   _BillingPageState createState() => _BillingPageState();
// // // // }

// // // // class _BillingPageState extends State<BillingPage> {
// // // //   List<Map<String, dynamic>> selectedItems = [];
// // // //   double totalAmount = 0.0;
// // // //   double taxPercentage = 0.0;
// // // //   List<Map<String, dynamic>> availableItems = [];

// // // //   final currentUser = FirebaseAuth.instance.currentUser;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _fetchAvailableItems();
// // // //   }

// // // //   Future<void> _fetchAvailableItems() async {
// // // //     if (currentUser != null) {
// // // //       final userItemsRef = FirebaseFirestore.instance
// // // //           .collection('USERS')
// // // //           .doc(currentUser!.uid)
// // // //           .collection('items');

// // // //       final snapshot = await userItemsRef.get();
// // // //       final items = snapshot.docs.map((doc) => doc.data()).toList();

// // // //       setState(() {
// // // //         availableItems = items.map((item) => {
// // // //           'Description': item['Description'],
// // // //           'Selling Price': item['Selling Price'],
// // // //         }).toList();
// // // //       });
// // // //     }
// // // //   }

// // // //   void _addItem(BuildContext context) {
// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (BuildContext context) {
// // // //         int quantity = 1;
// // // //         Map<String, dynamic>? selectedItem =
// // // //             availableItems.isNotEmpty ? availableItems[0] : null;

// // // //         TextEditingController quantityController =
// // // //             TextEditingController(text: '1');

// // // //         return StatefulBuilder(
// // // //           builder: (BuildContext context, setState) {
// // // //             return AlertDialog(
// // // //               title: Text('Add Item'),
// // // //               content: SingleChildScrollView(
// // // //                 child: Column(
// // // //                   mainAxisSize: MainAxisSize.min,
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     DropdownButtonFormField<Map<String, dynamic>>(
// // // //                       value: selectedItem,
// // // //                       onChanged: (value) {
// // // //                         setState(() {
// // // //                           selectedItem = value;
// // // //                         });
// // // //                       },
// // // //                       items: availableItems.map((item) {
// // // //                         return DropdownMenuItem<Map<String, dynamic>>(
// // // //                           value: item,
// // // //                           child: Text(item['Description']),
// // // //                         );
// // // //                       }).toList(),
// // // //                       decoration: InputDecoration(
// // // //                         labelText: 'Item',
// // // //                         border: OutlineInputBorder(),
// // // //                       ),
// // // //                     ),
// // // //                     SizedBox(height: 16.0),
// // // //                     Row(
// // // //                       children: [
// // // //                         Text('Quantity: '),
// // // //                         Expanded(
// // // //                           child: SizedBox(
// // // //                             width: 50,
// // // //                             child: TextFormField(
// // // //                               controller: quantityController,
// // // //                               keyboardType: TextInputType.number,
// // // //                               onChanged: (value) {
// // // //                                 quantity = int.tryParse(value) ?? 1;
// // // //                               },
// // // //                               decoration: InputDecoration(
// // // //                                 border: OutlineInputBorder(),
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               actions: <Widget>[
// // // //                 TextButton(
// // // //                   child: Text('Cancel'),
// // // //                   onPressed: () {
// // // //                     Navigator.of(context).pop();
// // // //                   },
// // // //                 ),
// // // //                 TextButton(
// // // //                   child: Text('Add'),
// // // //                   onPressed: () {
// // // //                     if (selectedItem != null) {
// // // //                       setState(() {
// // // //                         selectedItems.add({
// // // //                           'description': selectedItem!['Description'],
// // // //                           'quantity': quantity,
// // // //                           'price': selectedItem!['Selling Price'],
// // // //                         });
// // // //                         _calculateTotalAmount();
// // // //                         Navigator.of(context).pop();
// // // //                       });
// // // //                     }
// // // //                   },
// // // //                 ),
// // // //               ],
// // // //             );
// // // //           },
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   void _removeItem(int index) {
// // // //     setState(() {
// // // //       selectedItems.removeAt(index);
// // // //       _calculateTotalAmount();
// // // //     });
// // // //   }

// // // //   void _updateItem(int index, String description, int quantity, int price) {
// // // //     setState(() {
// // // //       selectedItems[index] = {
// // // //         'description': description,
// // // //         'quantity': quantity,
// // // //         'price': price,
// // // //       };
// // // //       _calculateTotalAmount();
// // // //     });
// // // //   }

// // // //   Widget _buildTaxInput() {
// // // //     return TextFormField(
// // // //       keyboardType: TextInputType.numberWithOptions(decimal: true),
// // // //       onChanged: (value) {
// // // //         setState(() {
// // // //           taxPercentage = double.tryParse(value) ?? 0.0;
// // // //           _calculateTotalAmount();
// // // //         });
// // // //       },
// // // //       decoration: InputDecoration(
// // // //         labelText: 'Tax %',
// // // //         border: OutlineInputBorder(),
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _calculateTotalAmount() {
// // // //     double subtotal = 0.0;
// // // //     for (var item in selectedItems) {
// // // //       subtotal += item['quantity'] * item['price'];
// // // //     }
// // // //     double taxAmount = (subtotal * (taxPercentage / 100));
// // // //     setState(() {
// // // //       totalAmount = subtotal + taxAmount;
// // // //     });
// // // //   }

// // // //   void _submitBill() async {
// // // //     if (selectedItems.isEmpty) {
// // // //       showDialog(
// // // //         context: context,
// // // //         builder: (BuildContext context) => AlertDialog(
// // // //           title: Text('No Items Selected'),
// // // //           content: Text('Please add at least one item to submit the bill.'),
// // // //           actions: <Widget>[
// // // //             TextButton(
// // // //               child: Text('OK'),
// // // //               onPressed: () {
// // // //                 Navigator.of(context).pop();
// // // //               },
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       );
// // // //       return;
// // // //     }

// // // //     try {
// // // //       await FirebaseFirestore.instance
// // // //           .collection('USERS')
// // // //           .doc(currentUser!.uid)
// // // //           .collection('bills')
// // // //           .doc(widget.invoice['invoiceId'])
// // // //           .set({
// // // //         'Customer Name': widget.invoice['customerName'],
// // // //         'Customer Email': widget.invoice['customerEmail'],
// // // //         'Customer Address': widget.invoice['Address'],
// // // //         'status': widget.invoice['status'],
// // // //         'Due Date': widget.invoice['dueDate'],
// // // //         'Invoice Date': DateTime.now(),
// // // //         'Invoice ID': widget.invoice['invoiceId'],
// // // //         'Total Bill': totalAmount,
// // // //         'Procedures': selectedItems,
// // // //         'Tax Percentage': taxPercentage,
// // // //       });

// // // //       showDialog(
// // // //         context: context,
// // // //         builder: (BuildContext context) => AlertDialog(
// // // //           title: const Text('Success'),
// // // //           content: const Text('Billing information submitted successfully.'),
// // // //           actions: <Widget>[
// // // //             TextButton(
// // // //               child: const Text('OK'),
// // // //               onPressed: () {
// // // //                 Navigator.of(context).pop();
// // // //                 Navigator.pushNamed(context, '/about');
// // // //               },
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       );

// // // //       setState(() {
// // // //         selectedItems.clear();
// // // //         totalAmount = 0.0;
// // // //         taxPercentage = 0.0;
// // // //       });
// // // //     } catch (e) {
// // // //       print('Error submitting bill: $e');
// // // //       showDialog(
// // // //         context: context,
// // // //         builder: (BuildContext context) => AlertDialog(
// // // //           title: const Text('Error'),
// // // //           content: const Text('An error occurred. Please try again later.'),
// // // //           actions: <Widget>[
// // // //             TextButton(
// // // //               child: const Text('OK'),
// // // //               onPressed: () {
// // // //                 Navigator.of(context).pop();
// // // //               },
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       );
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Billing Page'),
// // // //       ),
// // // //       body: Padding(
// // // //         padding: const EdgeInsets.all(16.0),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.stretch,
// // // //           children: [
// // // //             // Customer Details Card
// // // //             Card(
// // // //               elevation: 4.0,
// // // //               child: Padding(
// // // //                 padding: const EdgeInsets.all(16.0),
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     Text(
// // // //                       'Customer Details',
// // // //                       style: TextStyle(
// // // //                         fontSize: 20,
// // // //                         fontWeight: FontWeight.bold,
// // // //                       ),
// // // //                     ),
// // // //                     SizedBox(height: 8.0),
// // // //                     _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
// // // //                     _buildInfoRow('Payment Status:', widget.invoice['status'] ?? 'N/A'),
// // // //                     _buildInfoRow('Email:', widget.invoice['customerEmail'] ?? 'N/A'),
// // // //                     _buildInfoRow('Address:', widget.invoice['Address'] ?? 'N/A'),
// // // //                     _buildInfoRow('Due Date:', widget.invoice['dueDate']?.toDate().toString() ?? 'No due date'),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             SizedBox(height: 16.0),
// // // //             ElevatedButton.icon(
// // // //               onPressed: () => _addItem(context),
// // // //               icon: Icon(Icons.add),
// // // //               label: Text('Add Item'),
// // // //               style: ElevatedButton.styleFrom(
// // // //                 padding: EdgeInsets.symmetric(vertical: 12.0),
// // // //               ),
// // // //             ),
// // // //             SizedBox(height: 16.0),
// // // //             Expanded(
// // // //               child: ListView.builder(
// // // //                 itemCount: selectedItems.length,
// // // //                 itemBuilder: (context, index) {
// // // //                   final item = selectedItems[index];
// // // //                   return ListTile(
// // // //                     title: Text(item['description']),
// // // //                     subtitle: Text('Qty: ${item['quantity']}'),
// // // //                     trailing: Text('\$${(item['quantity'] * item['price']).toStringAsFixed(2)}'),
// // // //                     onTap: () {
// // // //                       _removeItem(index); // Remove item when tapped
// // // //                     },
// // // //                   );
// // // //                 },
// // // //               ),
// // // //             ),
// // // //             SizedBox(height: 16.0),
// // // //             ElevatedButton.icon(
// // // //               onPressed: () {
// // // //                 showDialog(
// // // //                   context: context,
// // // //                   builder: (BuildContext context) => AlertDialog(
// // // //                     title: Text('Selected Items Checklist'),
// // // //                     content: Container(
// // // //                       width: double.maxFinite,
// // // //                       child: Column(
// // // //                         mainAxisSize: MainAxisSize.min,
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           Expanded(
// // // //                             child: ListView.builder(
// // // //                               itemCount: selectedItems.length,
// // // //                               itemBuilder: (context, index) {
// // // //                                 final item = selectedItems[index];
// // // //                                 return ListTile(
// // // //                                   title: Text(item['description']),
// // // //                                   subtitle: Text('Qty: ${item['quantity']}'),
// // // //                                   trailing: Row(
// // // //                                     mainAxisSize: MainAxisSize.min,
// // // //                                     children: [
// // // //                                                                           Text('\$${(item['quantity'] * item['price']).toStringAsFixed(2)}'),
// // // //                                       IconButton(
// // // //                                         icon: Icon(Icons.cancel),
// // // //                                         onPressed: () {
// // // //                                           _removeItem(index); // Call remove function with the index of the item
// // // //                                         },
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                   onTap: () {
// // // //                                     // Optionally implement an action when tapping on an item in the list
// // // //                                   },
// // // //                                 );
// // // //                               },
// // // //                             ),
// // // //                           ),
// // // //                           SizedBox(height: 16.0),
// // // //                           Text(
// // // //                             'Total Amount',
// // // //                             style: TextStyle(
// // // //                               fontSize: 24,
// // // //                               fontWeight: FontWeight.bold,
// // // //                             ),
// // // //                           ),
// // // //                           SizedBox(height: 8.0),
// // // //                           _buildTotalAmountRow('Subtotal:', totalAmount - (totalAmount * taxPercentage / 100)),
// // // //                           SizedBox(height: 8.0),
// // // //                           _buildTaxInput(),
// // // //                           SizedBox(height: 16.0),
// // // //                           _buildTotalAmountRow('Total:', totalAmount),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                     actions: <Widget>[
// // // //                       TextButton(
// // // //                         child: Text('Close'),
// // // //                         onPressed: () {
// // // //                           Navigator.of(context).pop();
// // // //                         },
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 );
// // // //               },
// // // //               icon: Icon(Icons.view_list),
// // // //               label: Text('View Checklist'),
// // // //               style: ElevatedButton.styleFrom(
// // // //                 padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // //               ),
// // // //             ),
// // // //             SizedBox(height: 16.0),
// // // //             ElevatedButton.icon(
// // // //               onPressed: _submitBill,
// // // //               icon: Icon(Icons.save),
// // // //               label: Text('Save'),
// // // //               style: ElevatedButton.styleFrom(
// // // //                 padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // //   // Widget _buildInfoRow(String label, dynamic value) {
// // //   //   return Padding(
// // //   //     padding: const EdgeInsets.symmetric(vertical: 4.0),
// // //   //     child: Row(
// // //   //       crossAxisAlignment: CrossAxisAlignment.start,
// // //   //       children: [
// // //   //         Text(
// // //   //           label,
// // //   //           style: TextStyle(
// // //   //             fontWeight: FontWeight.bold,
// // //   //           ),
// // //   //         ),
// // //   //         SizedBox(width: 8.0),
// // //   //         Expanded(
// // //   //           child: Text(
// // //   //             value != null ? value.toString() : 'N/A',
// // //   //             style: TextStyle(fontSize: 16),
// // //   //           ),
// // //   //         ),
// // //   //       ],
// // //   //     ),
// // //   //   );
// // //   // }

// // // //   Widget _buildTotalAmountRow(String label, double amount) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // // //       child: Row(
// // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //         children: [
// // // //           Text(
// // // //             label,
// // // //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // //           ),
// // // //           Text(
// // // //             '\$${amount.toStringAsFixed(2)}',
// // // //             style: const TextStyle(
// // // //               fontSize: 16,
// // // //               fontWeight: FontWeight.bold,
// // // //               color: Colors.green,
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }



// // // import 'package:awesome_dialog/awesome_dialog.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/material.dart';

// // // class BillingPage extends StatefulWidget {
// // //   final Map<String, dynamic> invoice;

// // //   const BillingPage({Key? key, required this.invoice}) : super(key: key);

// // //   @override
// // //   _BillingPageState createState() => _BillingPageState();
// // // }

// // // class _BillingPageState extends State<BillingPage> {
// // //   List<Map<String, dynamic>> selectedItems = [];
// // //   double totalAmount = 0.0;
// // //   double taxPercentage = 0.0;
// // //   List<Map<String, dynamic>> availableItems = [];

// // //   final currentUser = FirebaseAuth.instance.currentUser;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _fetchAvailableItems();
    
// // //   }

// // //   Future<void> _fetchAvailableItems() async {
// // //     if (currentUser != null) {
// // //       final userItemsRef = FirebaseFirestore.instance
// // //           .collection('USERS')
// // //           .doc(currentUser!.uid)
// // //           .collection('items');

// // //       final snapshot = await userItemsRef.get();
// // //       final items = snapshot.docs.map((doc) => doc.data()).toList();

// // //       setState(() {
// // //         availableItems = items.map((item) => {
// // //           'Description': item['Item Name'],
// // //           'Selling Price': item['Selling Price'],
// // //         }).toList();
// // //       });
// // //     }
// // //   }

// // //   void _addItem(BuildContext context) {
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         int quantity = 1;
// // //         Map<String, dynamic>? selectedItem =
// // //             availableItems.isNotEmpty ? availableItems[0] : null;

// // //         TextEditingController quantityController =
// // //             TextEditingController(text: '1');

// // //         return StatefulBuilder(
// // //           builder: (BuildContext context, setState) {
// // //             ElevatedButton(
// // //       onPressed: () {
// // //         AwesomeDialog(
// // //           context: context,
// // //           dialogType: DialogType.noHeader,
// // //           animType: AnimType.scale,
// // //           title: 'Add Item',
// // //           body: SingleChildScrollView(
// // //             child: Column(
// // //               mainAxisSize: MainAxisSize.min,
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 availableItems.isEmpty
// // //                     ? ElevatedButton(
// // //                         onPressed: () {
// // //                           setState(() {
// // //                             availableItems.add({
// // //                               'Description': 'New Item',
// // //                               'Selling Price': 0.0,
// // //                             });
// // //                             selectedItem = availableItems.first;
// // //                           });
// // //                         },
// // //                         child: const Text('Add Item'),
// // //                       )
// // //                     : DropdownButtonFormField<Map<String, dynamic>>(
// // //                         value: selectedItem,
// // //                         onChanged: (value) {
// // //                           setState(() {
// // //                             selectedItem = value;
// // //                           });
// // //                         },
// // //                         items: availableItems.map((item) {
// // //                           return DropdownMenuItem<Map<String, dynamic>>(
// // //                             value: item,
// // //                             child: Text(item['Description']),
// // //                           );
// // //                         }).toList(),
// // //                         decoration: const InputDecoration(
// // //                           labelText: 'Item',
// // //                           border: OutlineInputBorder(),
// // //                         ),
// // //                       ),
// // //                 Row(
// // //                   children: [
// // //                     const Text('Quantity: '),
// // //                     Expanded(
// // //                       child: SizedBox(
// // //                         width: 50,
// // //                         child: TextFormField(
// // //                           controller: quantityController,
// // //                           keyboardType: TextInputType.number,
// // //                           onChanged: (value) {
// // //                             quantity = int.tryParse(value) ?? 1;
// // //                           },
// // //                           decoration: const InputDecoration(
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           btnCancelOnPress: () {},
// // //           btnOkOnPress: () {
// // //             if (selectedItem != null) {
// // //               setState(() {
// // //                 selectedItems.add({
// // //                   'description': selectedItem!['Description'],
// // //                   'quantity': quantity,
// // //                   'price': selectedItem!['Selling Price'],
// // //                 });
// // //                 _calculateTotalAmount();
// // //               });
// // //             }
// // //           },
// // //         ).show();
// // //       },
// // //       child: const Text('Show Add Item Dialog'),
// // //     );
          
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }

// // // double _calculateSubtotal() {
// // //   double subtotal = 0.0;
// // //   for (var item in selectedItems) {
// // //     subtotal += item['quantity'] * item['price'];
// // //   }
// // //   return subtotal;
// // // }


// // // double _calculateTax() {
// // //   double subtotal = _calculateSubtotal();
// // //   // return (subtotal * (taxPercentage / 100));
// // //   return taxPercentage ;
// // // }


// // //   void _removeItem(int index) {
// // //     setState(() {
// // //       selectedItems.removeAt(index);
// // //       _calculateTotalAmount();
// // //     });
// // //   }

// // //   void _updateItem(int index, String description, int quantity, int price) {
// // //     setState(() {
// // //       selectedItems[index] = {
// // //         'description': description,
// // //         'quantity': quantity,
// // //         'price': price,
// // //       };
// // //       _calculateTotalAmount();
// // //     });
// // //   }

// // //   Widget _buildTaxInput() {
// // //     return TextFormField(
// // //       initialValue: taxPercentage.toString(),
// // //       keyboardType: const TextInputType.numberWithOptions(decimal: true),
// // //       onChanged: (value) {
// // //         setState(() {
// // //           taxPercentage = double.tryParse(value) ?? 0.0;
// // //           _calculateTotalAmount();
// // //         });
// // //       },
// // //       decoration: const InputDecoration(
// // //         labelText: 'Tax %',
// // //         border: OutlineInputBorder(),
// // //       ),
// // //     );
// // //   }

// // //   void _calculateTotalAmount() {
// // //     double subtotal = 0.0;
// // //     for (var item in selectedItems) {
// // //       subtotal += item['quantity'] * item['price'];
// // //     }
// // //     double taxAmount = (subtotal * (taxPercentage / 100));
// // //     setState(() {
// // //       totalAmount = subtotal + taxAmount;
// // //     });
// // //   }

// // //   void _submitBill() async {
// // //     if (selectedItems.isEmpty) {
// // //       showDialog(
// // //         context: context,
// // //         builder: (BuildContext context) => AlertDialog(
// // //           title: const Text('No Items Selected'),
// // //           content: const Text('Please add at least one item to submit the bill.'),
// // //           actions: <Widget>[
// // //             TextButton(
// // //               child: const Text('OK'),
// // //               onPressed: () {
// // //                 Navigator.of(context).pop();
// // //               },
// // //             ),
// // //           ],
// // //         ),
// // //       );
// // //       return;
// // //     }

// // //     try {
// // //       await FirebaseFirestore.instance
// // //           .collection('USERS')
// // //           .doc(currentUser!.uid)
// // //           .collection('bills')
// // //           .doc(widget.invoice['invoiceId'])
// // //           .set({
// // //         'Customer Name': widget.invoice['customerName'],
// // //         'Customer Email': widget.invoice['customerEmail'],
// // //         'Customer Address': widget.invoice['Address'],
// // //         'Customer ID:': widget.invoice['customerID'],
// // //         'status': widget.invoice['status'],
// // //         'Due Date': widget.invoice['dueDate'],
// // //         'Invoice Date': DateTime.now(),
// // //         'Invoice ID': widget.invoice['invoiceId'],
// // //         'Total Bill': totalAmount,
// // //         'Procedures': selectedItems,
// // //         'Tax Percentage': taxPercentage,
// // //       });

// // //       showDialog(
// // //         context: context,
// // //         builder: (BuildContext context) => AlertDialog(
// // //           title: const Text('Success'),
// // //           content: const Text('Billing information submitted successfully.'),
// // //           actions: <Widget>[
// // //             TextButton(
// // //               child: const Text('OK'),
// // //               onPressed: () {
// // //                 Navigator.of(context).pop();
// // //                 Navigator.pushNamed(context, '/about');
// // //               },
// // //             ),
// // //           ],
// // //         ),
// // //       );

// // //       setState(() {
// // //         selectedItems.clear();
// // //         totalAmount = 0.0;
// // //         taxPercentage = 0.0;
// // //       });
// // //     } catch (e) {
// // //       print('Error submitting bill: $e');
// // //       showDialog(
// // //         context: context,
// // //         builder: (BuildContext context) => AlertDialog(
// // //           title: const Text('Error'),
// // //           content: const Text('An error occurred. Please try again later.'),
// // //           actions: <Widget>[
// // //             TextButton(
// // //               child: const Text('OK'),
// // //               onPressed: () {
// // //                 Navigator.of(context).pop();
// // //               },
// // //             ),
// // //           ],
// // //         ),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Billing Page'),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.stretch,
// // //           children: [
// // //             // Customer Details Card
// // //             Card(
// // //               elevation: 4.0,
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(16.0),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     const Text(
// // //                       'Customer Details',
// // //                       style: TextStyle(
// // //                         fontSize: 20,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 8.0),
// // //                     _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
// // //                      _buildInfoRow('Customer ID:', widget.invoice['customerID'] ?? 'N/A'),
// // //                     _buildInfoRow('Payment Status:', widget.invoice['status'] ?? 'N/A'),
// // //                     _buildInfoRow('Email:', widget.invoice['customerEmail'] ?? 'N/A'),
// // //                     _buildInfoRow('Address:', widget.invoice['customerAddress'] ?? 'N/A'),
// // //                     _buildInfoRow('Mobile:', widget.invoice['mobile'] ?? 'N/A'),
// // //                     _buildInfoRow('Work-Phone:', widget.invoice['workphone'] ?? 'N/A'),
// // //                     _buildInfoRow('Due Date:', widget.invoice['dueDate']?.toDate().toString() ?? 'No due date'),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //            const SizedBox(height: 16.0),
// // // ElevatedButton.icon(
// // //   onPressed: () => _addItem(context),
// // //   icon: const Icon(Icons.add),
// // //   label: const Text('Add Item'),
// // //   style: ElevatedButton.styleFrom(
// // //     padding: const EdgeInsets.symmetric(vertical: 12.0),
// // //   ),
// // // ),
// // // const SizedBox(height: 16.0),
// // // Expanded(
// // //   child: ListView.builder(
// // //     itemCount: selectedItems.length,
// // //     itemBuilder: (context, index) {
// // //       final item = selectedItems[index];
// // //       return ListTile(
// // //         title: Text(item['description']),
// // //         subtitle: Text('Qty: ${item['quantity']}'),
// // //         trailing: Text('₹${(item['quantity'] * item['price']).toStringAsFixed(2)}'),
// // //         onTap: () {
// // //           // Optionally implement an action when tapping on an item in the list
// // //         },
// // //       );
// // //     },
// // //   ),
// // // ),
// // // const SizedBox(height: 16.0),
// // // ElevatedButton(
// // //   onPressed: () {
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) => AlertDialog(
// // //         title: const Text('Selected Items Checklist'),
// // //         content: Container(
// // //           width: double.maxFinite,
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Expanded(
// // //                 child: ListView.builder(
// // //                   itemCount: selectedItems.length,
// // //                   itemBuilder: (context, index) {
// // //                     final item = selectedItems[index];
// // //                     return ListTile(
// // //                       title: Text(item['description']),
// // //                       subtitle: Text('Qty: ${item['quantity']}'),
// // //                       trailing: Text(
// // //                         '₹${(item['quantity'] * item['price']).toStringAsFixed(2)}',
// // //                       ),
// // //                       onTap: () {
// // //                         Navigator.of(context).pop();
// // //                         _updateItem(
// // //                           index,
// // //                           item['description'],
// // //                           item['quantity'],
// // //                           item['price'],
// // //                         );
// // //                       },
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 16.0),
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: [
// // //                   const Text(
// // //                     'Subtotal:',
// // //                     style: TextStyle(fontWeight: FontWeight.bold),
// // //                   ),
// // //                   Text('₹${_calculateSubtotal().toStringAsFixed(2)}'),
// // //                 ],
// // //               ),
// // //               const SizedBox(height: 8.0),
// // //               _buildTaxInput(),
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: [
// // //                   Text(
// // //                     'Tax (${taxPercentage.toStringAsFixed(2)}%):',
// // //                     style: const TextStyle(fontWeight: FontWeight.bold),
// // //                   ),
// // //                   Text('₹${_calculateTax().toStringAsFixed(2)}'),
// // //                 ],
// // //               ),
// // //               const Divider(),
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: [
// // //                   const Text(
// // //                     'Total Amount:',
// // //                     style: TextStyle(fontWeight: FontWeight.bold),
// // //                   ),
// // //                   Text(
// // //                     '₹${totalAmount.toStringAsFixed(2)}',
// // //                     style: const TextStyle(fontWeight: FontWeight.bold),
// // //                   ),
// // //                 ],
// // //               ),
// // //               const SizedBox(height: 16.0),
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                 children: [
// // //                   ElevatedButton(
// // //                     onPressed: () {
// // //                       Navigator.of(context).pop();
// // //                     },
// // //                     child: const Text('Close'),
// // //                   ),
// // //                   ElevatedButton(
// // //                     onPressed: _submitBill,
// // //                     child: const Text('Submit Bill'),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   },
// // //   child: const Text('Show Checklist'),
// // // ),

  
// // //           ])));
// // // }

// // //   Widget _buildInfoRow(String label, dynamic value) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 4.0),
// // //       child: Row(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Text(
// // //             label,
// // //             style: const TextStyle(
// // //               fontWeight: FontWeight.bold,
// // //             ),
// // //           ),
// // //           const SizedBox(width: 8.0),
// // //           Expanded(
// // //             child: Text(
// // //               value != null ? value.toString() : 'N/A',
// // //               style: const TextStyle(fontSize: 16),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:awesome_dialog/awesome_dialog.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';

// // class BillingPage extends StatefulWidget {
// //   final Map<String, dynamic> invoice;

// //   const BillingPage({Key? key, required this.invoice}) : super(key: key);

// //   @override
// //   _BillingPageState createState() => _BillingPageState();
// // }

// // class _BillingPageState extends State<BillingPage> {
// //   List<Map<String, dynamic>> selectedItems = [];
// //   double totalAmount = 0.0;
// //   double taxPercentage = 0.0;
// //   double discountPercentage = 0.0;
// //   List<Map<String, dynamic>> availableItems = [];

// //   final currentUser = FirebaseAuth.instance.currentUser;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchAvailableItems();
// //   }

// //   Future<void> _fetchAvailableItems() async {
// //     if (currentUser != null) {
// //       final userItemsRef = FirebaseFirestore.instance
// //           .collection('USERS')
// //           .doc(currentUser!.uid)
// //           .collection('items');

// //       final snapshot = await userItemsRef.get();
// //       final items = snapshot.docs.map((doc) => doc.data()).toList();

// //       setState(() {
// //         availableItems = items.map((item) => {
// //           'Description': item['Item Name'],
// //           'Selling Price': item['Selling Price'],
// //         }).toList();
// //       });
// //     }
// //   }

// //   void _addItem(BuildContext context) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         int quantity = 1;
// //         Map<String, dynamic>? selectedItem =
// //             availableItems.isNotEmpty ? availableItems[0] : null;

// //         TextEditingController quantityController =
// //             TextEditingController(text: '1');

// //         return StatefulBuilder(
// //         builder: (BuildContext context, setState) {
// //   return availableItems.isEmpty
// //       ? ElevatedButton.icon(
// //           onPressed: () {
// //             AwesomeDialog(
// //               context: context,
// //               dialogType: DialogType.noHeader,
// //               animType: AnimType.scale,
// //               body: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: SingleChildScrollView(
// //                   child: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       ElevatedButton.icon(
// //                         onPressed: () {
// //                           setState(() {
// //                             availableItems.add({
// //                               'Description': 'New Item',
// //                               'Selling Price': 0.0,
// //                             });
// //                             selectedItem = availableItems.first;
// //                           });
// //                         },
// //                         icon: const Icon(Icons.add),
// //                         label: const Text('Add Item'),
// //                         style: ElevatedButton.styleFrom(
// //                           elevation: 0, // No elevation
// //                           // primary: Colors.blue, // Custom button color
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(8.0), // Rounded corners
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               btnCancelOnPress: () {
// //                 Navigator.of(context).pop();
// //               },
// //               btnOkOnPress: () {
// //                 if (selectedItem != null) {
// //                   setState(() {
// //                     selectedItems.add({
// //                       'description': selectedItem!['Description'],
// //                       'quantity': quantity,
// //                       'price': selectedItem!['Selling Price'],
// //                     });
// //                     _calculateTotalAmount();
// //                   });
// //                 }
// //               },
// //               headerAnimationLoop: false,
// //               btnOkIcon: Icons.check_circle,
// //               btnCancelIcon: Icons.arrow_back,
// //               btnOkColor: Colors.green,
// //               btnCancelColor: Colors.red,
// //             ).show();
// //           },
// //           icon: const Icon(Icons.add),
// //           label: const Text('Add Item'),
// //           style: ElevatedButton.styleFrom(
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(8.0), // Rounded corners
// //             ),
// //           ),
// //         )
// //       : ElevatedButton(
// //           onPressed: () {
// //             AwesomeDialog(
// //               context: context,
// //               dialogType: DialogType.noHeader,
// //               animType: AnimType.scale,
// //               body: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: SingleChildScrollView(
// //                   child: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       DropdownButtonFormField<Map<String, dynamic>>(
// //                         value: selectedItem,
// //                         onChanged: (value) {
// //                           setState(() {
// //                             selectedItem = value;
// //                           });
// //                         },
// //                         items: availableItems.map((item) {
// //                           return DropdownMenuItem<Map<String, dynamic>>(
// //                             value: item,
// //                             child: Text(item['Description']),
// //                           );
// //                         }).toList(),
// //                         decoration: const InputDecoration(
// //                           labelText: 'Item',
// //                           border: OutlineInputBorder(),
// //                         ),
// //                       ),
// //                       const SizedBox(height: 10),
// //                       Row(
// //                         children: [
// //                           const Text('Quantity: '),
// //                           const SizedBox(width: 10),
// //                           Expanded(
// //                             child: SizedBox(
// //                               width: 50,
// //                               child: TextFormField(
// //                                 controller: quantityController,
// //                                 keyboardType: TextInputType.number,
// //                                 onChanged: (value) {
// //                                   quantity = int.tryParse(value) ?? 1;
// //                                 },
// //                                 decoration: const InputDecoration(
// //                                   border: OutlineInputBorder(),
// //                                   isDense: true,
// //                                   contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               btnCancelOnPress: () {
// //                 Navigator.of(context).pop();
// //               },
// //               btnOkOnPress: () {
// //                 if (selectedItem != null) {
// //                   setState(() {
// //                     selectedItems.add({
// //                       'description': selectedItem!['Description'],
// //                       'quantity': quantity,
// //                       'price': selectedItem!['Selling Price'],
// //                     });
// //                     _calculateTotalAmount();
// //                   });
// //                 }
// //               },
// //               headerAnimationLoop: false,
// //               btnOkIcon: Icons.check_circle,
// //               btnCancelIcon: Icons.arrow_back,
// //               btnOkColor: Colors.green,
// //               btnCancelColor: Colors.red,
// //             ).show();
// //           },
// //           child: const Icon(Icons.add, size: 24.0),
// //           style: ElevatedButton.styleFrom(
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(8.0), // Rounded corners
// //             ),
// //           ),
// //         );
// // },


// //         );
// //       },
// //     );
// //   }

// //   double _calculateSubtotal() {
// //     double subtotal = 0.0;
// //     for (var item in selectedItems) {
// //       subtotal += item['quantity'] * item['price'];
// //     }
// //     return subtotal;
// //   }

// //   double _calculateTax(double subtotal) {
// //     return (subtotal * (taxPercentage / 100));
// //   }

// //   double _calculateDiscount(double subtotal) {
// //     return (subtotal * (discountPercentage / 100));
// //   }

// //   void _removeItem(int index) {
// //     setState(() {
// //       selectedItems.removeAt(index);
// //       _calculateTotalAmount();
// //     });
// //   }

// //   void _updateItem(int index, String description, int quantity, int price) {
// //     setState(() {
// //       selectedItems[index] = {
// //         'description': description,
// //         'quantity': quantity,
// //         'price': price,
// //       };
// //       _calculateTotalAmount();
// //     });
// //   }

// //   Widget _buildTaxInput() {
// //     return TextFormField(
// //       initialValue: taxPercentage.toString(),
// //       keyboardType: const TextInputType.numberWithOptions(decimal: true),
// //       onChanged: (value) {
// //         setState(() {
// //           taxPercentage = double.tryParse(value) ?? 0.0;
// //           _calculateTotalAmount();
// //         });
// //       },
// //       decoration: const InputDecoration(
// //         labelText: 'Tax %',
// //         border: OutlineInputBorder(),
// //       ),
// //     );
// //   }

// //   Widget _buildDiscountInput() {
// //     return TextFormField(
// //       initialValue: discountPercentage.toString(),
// //       keyboardType: const TextInputType.numberWithOptions(decimal: true),
// //       onChanged: (value) {
// //         setState(() {
// //           discountPercentage = double.tryParse(value) ?? 0.0;
// //           _calculateTotalAmount();
// //         });
// //       },
// //       decoration: const InputDecoration(
// //         labelText: 'Discount %',
// //         border: OutlineInputBorder(),
// //       ),
// //     );
// //   }

// //   void _calculateTotalAmount() {
// //     double subtotal = _calculateSubtotal();
// //     double taxAmount = _calculateTax(subtotal);
// //     double discountAmount = _calculateDiscount(subtotal);
// //     setState(() {
// //       totalAmount = subtotal + taxAmount - discountAmount;
// //     });
// //   }

// //   void _submitBill() async {
// //     if (selectedItems.isEmpty) {
// //       showDialog(
// //         context: context,
// //         builder: (BuildContext context) => AlertDialog(
// //           title: const Text('No Items Selected'),
// //           content: const Text('Please add at least one item to submit the bill.'),
// //           actions: <Widget>[
// //             TextButton(
// //               child: const Text('OK'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         ),
// //       );
// //       return;
// //     }

// //     try {
// //       await FirebaseFirestore.instance
// //           .collection('USERS')
// //           .doc(currentUser!.uid)
// //           .collection('bills')
// //           .doc(widget.invoice['invoiceId'])
// //           .set({
// //         'Customer Name': widget.invoice['customerName'],
// //         'Customer Email': widget.invoice['customerEmail'],
// //         'Customer Address': widget.invoice['Address'],
// //         'Customer ID:': widget.invoice['customerID'],
// //         'status': widget.invoice['status'],
// //         'Due Date': widget.invoice['dueDate'],
// //         'Invoice Date': DateTime.now(),
// //         'Invoice ID': widget.invoice['invoiceId'],
// //         'Total Bill': totalAmount,
// //         'Procedures': selectedItems,
// //         'Tax Percentage': taxPercentage,
// //         'Discount Percentage': discountPercentage,
// //       });

// //       showDialog(
// //         context: context,
// //         builder: (BuildContext context) => AlertDialog(
// //           title: const Text('Success'),
// //           content: const Text('Billing information submitted successfully.'),
// //           actions: <Widget>[
// //             TextButton(
// //               child: const Text('OK'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //                 Navigator.pushNamed(context, '/about');
// //               },
// //             ),
// //           ],
// //         ),
// //       );

// //       setState(() {
// //         selectedItems.clear();
// //         totalAmount = 0.0;
// //         taxPercentage = 0.0;
// //         discountPercentage = 0.0;
// //       });
// //     } catch (e) {
// //       print('Error submitting bill: $e');
// //       showDialog(
// //         context: context,
// //         builder: (BuildContext context) => AlertDialog(
// //           title: const Text('Error'),
// //           content: const Text('An error occurred. Please try again later.'),
// //           actions: <Widget>[
// //             TextButton(
// //               child: const Text('OK'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         ),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Billing Page'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             // Customer Details Card
// //             Card(
// //               elevation: 4.0,
// //               child: Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text(
// //                       'Customer Details',
// //                       style: TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8.0),
// //                     _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
// //                     _buildInfoRow('Customer ID:', widget.invoice['customerID'] ?? 'N/A'),
// //                     _buildInfoRow('Payment Status:', widget.invoice['status'] ?? 'N/A'),
// //                     _buildInfoRow('Email:', widget.invoice['customerEmail'] ?? 'N/A'),
// //                     _buildInfoRow('Address:', widget.invoice['customerAddress'] ?? 'N/A'),
// //                     _buildInfoRow('Mobile:', widget.invoice['mobile'] ?? 'N/A'),
// //                     _buildInfoRow('Work-Phone:', widget.invoice['workphone'] ?? 'N/A'),
// //                     _buildInfoRow('Due Date:', widget.invoice['dueDate']?.toDate().toString() ?? 'No due date'),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 16.0),
// //             ElevatedButton.icon(
// //               onPressed: () => _addItem(context),
// //               icon: const Icon(Icons.add),
// //               label: const Text('Add Item'),
// //               style: ElevatedButton.styleFrom(
// //                 padding: const EdgeInsets.symmetric(vertical: 12.0),
// //               ),
// //             ),
// //             const SizedBox(height: 16.0),
// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: selectedItems.length,
// //                 itemBuilder: (context, index) {
// //                   final item = selectedItems[index];
// //                   return ListTile(
// //                     title: Text(item['description']),
// //                     subtitle: Text('Qty: ${item['quantity']}'),
// //                     trailing: Text('₹${(item['quantity'] * item['price']).toStringAsFixed(2)}'),
// //                     onTap: () {
// //                       // Optionally implement an action when tapping on an item in the list
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //             const SizedBox(height: 16.0),
// //             ElevatedButton(
// //               onPressed: () {
// //                 showDialog(
// //                   context: context,
// //                   builder: (BuildContext context) => AlertDialog(
// //                     title: const Text('Selected Items Checklist'),
// //                     content: Container(
// //                       width: double.maxFinite,
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Expanded(
// //                             child: ListView.builder(
// //                               itemCount: selectedItems.length,
// //                               itemBuilder: (context, index) {
// //                                 final item = selectedItems[index];
// //                                 return ListTile(
// //                                   title: Text(item['description']),
// //                                   subtitle: Text('Qty: ${item['quantity']}'),
// //                                   trailing: Text(
// //                                     '₹${(item['quantity'] * item['price']).toStringAsFixed(2)}',
// //                                   ),
// //                                   onTap: () {
// //                                     Navigator.of(context).pop();
// //                                     _updateItem(
// //                                       index,
// //                                       item['description'],
// //                                       item['quantity'],
// //                                       item['price'],
// //                                     );
// //                                   },
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                           const SizedBox(height: 16.0),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               const Text(
// //                                 'Subtotal:',
// //                                 style: TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                               Text('₹${_calculateSubtotal().toStringAsFixed(2)}'),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 8.0),
// //                           _buildTaxInput(),
// //                           const SizedBox(height: 8.0),
// //                           _buildDiscountInput(),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 'Tax (${taxPercentage.toStringAsFixed(2)}%):',
// //                                 style: const TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                               Text('₹${_calculateTax(_calculateSubtotal()).toStringAsFixed(2)}'),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 8.0),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 'Discount (${discountPercentage.toStringAsFixed(2)}%):',
// //                                 style: const TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                               Text('₹${_calculateDiscount(_calculateSubtotal()).toStringAsFixed(2)}'),
// //                             ],
// //                           ),
// //                           const Divider(),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               const Text(
// //                                 'Total Amount:',
// //                                 style: TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                               Text(
// //                                 '₹${totalAmount.toStringAsFixed(2)}',
// //                                 style: const TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 16.0),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //                               ElevatedButton(
// //                                 onPressed: () {
// //                                   Navigator.of(context).pop();
// //                                 },
// //                                 child: const Text('Close'),
// //                               ),
// //                               ElevatedButton(
// //                                 onPressed: _submitBill,
// //                                 child: const Text('Submit Bill'),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //               child: const Text('Show Checklist'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildInfoRow(String label, dynamic value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4.0),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             label,
// //             style: const TextStyle(
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           const SizedBox(width: 8.0),
// //           Expanded(
// //             child: Text(
// //               value != null ? value.toString() : 'N/A',
// //               style: const TextStyle(fontSize: 16),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }



// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class BillingPage extends StatefulWidget {
//   final Map<String, dynamic> invoice;

//   const BillingPage({Key? key, required this.invoice}) : super(key: key);

//   @override
//   _BillingPageState createState() => _BillingPageState();
// }

// class _BillingPageState extends State<BillingPage> {
//   List<Map<String, dynamic>> selectedItems = [];
//   double totalAmount = 0.0;
//   double taxPercentage = 0.0;
//   double discountPercentage = 0.0;
//   List<Map<String, dynamic>> availableItems = [];

//   final currentUser = FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//     super.initState();
//     _fetchAvailableItems();
//   }

//   Future<void> _fetchAvailableItems() async {
//     if (currentUser != null) {
//       final userItemsRef = FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentUser!.uid)
//           .collection('items');

//       final snapshot = await userItemsRef.get();
//       final items = snapshot.docs.map((doc) => doc.data()).toList();

//       setState(() {
//         availableItems = items.map((item) => {
//               'Description': item['Item Name'],
//               'Selling Price': item['Selling Price'],
//             }).toList();
//       });
//     }
//   }

//   void _addItem(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         int quantity = 1;
//         Map<String, dynamic>? selectedItem =
//             availableItems.isNotEmpty ? availableItems[0] : null;

//         TextEditingController quantityController =
//             TextEditingController(text: '1');

//         return StatefulBuilder(
//           builder: (BuildContext context, setState) {
//   return availableItems.isEmpty
//       ? ElevatedButton.icon(
//           onPressed: () {
//             AwesomeDialog(
//               context: context,
//               dialogType: DialogType.noHeader,
//               animType: AnimType.scale,
//               body: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           setState(() {
//                             availableItems.add({
//                               'Description': 'New Item',
//                               'Selling Price': 0.0,
//                             });
//                             selectedItem = availableItems.first;
//                           });
//                         },
//                         icon: const Icon(Icons.add),
//                         label: const Text('Add Item'),
//                         style: ElevatedButton.styleFrom(
//                           elevation: 0, // No elevation
//                           // primary: Colors.blue, // Custom button color
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0), // Rounded corners
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               btnCancelOnPress: () {
//                 Navigator.of(context).pop();
//               },
//               btnOkOnPress: () {
//                 if (selectedItem != null) {
//                   setState(() {
//                     selectedItems.add({
//                       'description': selectedItem!['Description'],
//                       'quantity': quantity,
//                       'price': selectedItem!['Selling Price'],
//                     });
//                     _calculateTotalAmount();
//                   });
//                 }
//               },
//               headerAnimationLoop: false,
//               btnOkIcon: Icons.check_circle,
//               btnCancelIcon: Icons.arrow_back,
//               btnOkColor: Colors.green,
//               btnCancelColor: Colors.red,
//             ).show();
//           },
//           icon: const Icon(Icons.add),
//           label: const Text('Add Item'),
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0), // Rounded corners
//             ),
//           ),
//         )
//       : ElevatedButton(
//           onPressed: () {
//             AwesomeDialog(
//               context: context,
//               dialogType: DialogType.noHeader,
//               animType: AnimType.scale,
//               body: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       DropdownButtonFormField<Map<String, dynamic>>(
//                         value: selectedItem,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedItem = value;
//                           });
//                         },
//                         items: availableItems.map((item) {
//                           return DropdownMenuItem<Map<String, dynamic>>(
//                             value: item,
//                             child: Text(item['Description']),
//                           );
//                         }).toList(),
//                         decoration: const InputDecoration(
//                           labelText: 'Item',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           const Text('Quantity: '),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: SizedBox(
//                               width: 50,
//                               child: TextFormField(
//                                 controller: quantityController,
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (value) {
//                                   quantity = int.tryParse(value) ?? 1;
//                                 },
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   isDense: true,
//                                   contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               btnCancelOnPress: () {
//                 Navigator.of(context).pop();
//               },
//               btnOkOnPress: () {
//                 if (selectedItem != null) {
//                   setState(() {
//                     selectedItems.add({
//                       'description': selectedItem!['Description'],
//                       'quantity': quantity,
//                       'price': selectedItem!['Selling Price'],
//                     });
//                     _calculateTotalAmount();
//                   });
//                 }
//               },
//               headerAnimationLoop: false,
//               btnOkIcon: Icons.check_circle,
//               btnCancelIcon: Icons.arrow_back,
//               btnOkColor: Colors.green,
//               btnCancelColor: Colors.red,
//             ).show();
//           },
//           child: const Icon(Icons.add, size: 24.0),
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0), // Rounded corners
//             ),
//           ),
//         );
// },

//         );
//       },
//     );
//   }

//   double _calculateSubtotal() {
//     double subtotal = 0.0;
//     for (var item in selectedItems) {
//       subtotal += item['quantity'] * item['price'];
//     }
//     return subtotal;
//   }

//   double _calculateTax(double subtotal) {
//     return (subtotal * (taxPercentage / 100));
//   }

//   double _calculateDiscount(double subtotal) {
//     return (subtotal * (discountPercentage / 100));
//   }

//   void _removeItem(int index) {
//     setState(() {
//       selectedItems.removeAt(index);
//       _calculateTotalAmount();
//     });
//   }

//   void _updateItem(int index, String description, int quantity, int price) {
//     setState(() {
//       selectedItems[index] = {
//         'description': description,
//         'quantity': quantity,
//         'price': price,
//       };
//       _calculateTotalAmount();
//     });
//   }

//   Widget _buildTaxInput() {
//     return TextFormField(
//       initialValue: taxPercentage.toString(),
//       keyboardType: const TextInputType.numberWithOptions(decimal: true),
//       onChanged: (value) {
//         setState(() {
//           taxPercentage = double.tryParse(value) ?? 0.0;
//           _calculateTotalAmount();
//         });
//       },
//       decoration: const InputDecoration(
//         labelText: 'Tax %',
//         border: OutlineInputBorder(),
//       ),
//     );
//   }

//   Widget _buildDiscountInput() {
//     return TextFormField(
//       initialValue: discountPercentage.toString(),
//       keyboardType: const TextInputType.numberWithOptions(decimal: true),
//       onChanged: (value) {
//         setState(() {
//           discountPercentage = double.tryParse(value) ?? 0.0;
//           _calculateTotalAmount();
//         });
//       },
//       decoration: const InputDecoration(
//         labelText: 'Discount %',
//         border: OutlineInputBorder(),
//       ),
//     );
//   }

//   void _calculateTotalAmount() {
//     double subtotal = _calculateSubtotal();
//     double taxAmount = _calculateTax(subtotal);
//     double discountAmount = _calculateDiscount(subtotal);
//     setState(() {
//       totalAmount = subtotal + taxAmount - discountAmount;
//     });
//   }

//   void _submitBill() async {
//     if (selectedItems.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('No Items Selected'),
//           content: const Text('Please add at least one item to submit the bill.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//       return;
//     }

//     try {
//       await FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentUser!.uid)
//           .collection('bills')
//           .doc(widget.invoice['invoiceId'])
//           .set({
//         'Customer Name': widget.invoice['customerName'],
//         'Customer Email': widget.invoice['customerEmail'],
//         'Customer Address': widget.invoice['Address'],
//         'Customer ID:': widget.invoice['customerID'],
//         'status': widget.invoice['status'],
//         'Due Date': widget.invoice['dueDate'],
//         'Invoice Date': DateTime.now(),
//         'Invoice ID': widget.invoice['invoiceId'],
//         'Total Bill': totalAmount,
//         'Procedures': selectedItems,
//         'Tax Percentage': taxPercentage,
//         'Discount Percentage': discountPercentage,
//       });

//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Success'),
//           content: const Text('Billing information submitted successfully.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.pushNamed(context, '/about');
//               },
//             ),
//           ],
//         ),
//       );

//       setState(() {
//         selectedItems.clear();
//         totalAmount = 0.0;
//         taxPercentage = 0.0;
//         discountPercentage = 0.0;
//       });
//     } catch (e) {
//       print('Error submitting bill: $e');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Error'),
//           content: const Text('An error occurred. Please try again later.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Billing Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Customer Details Card
//             Card(
//               elevation: 4.0,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Customer Details',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
//                     _buildInfoRow('Customer ID:', widget.invoice['customerID'] ?? 'N/A'),
//                     _buildInfoRow('Payment Status:', widget.invoice[ 'status'] ?? 'N/A'),
//                     _buildInfoRow('Email:', widget.invoice['customerEmail'] ?? 'N/A'),
//                     _buildInfoRow('Address:', widget.invoice['customerAddress'] ?? 'N/A'),
//                     _buildInfoRow('Mobile:', widget.invoice['mobile'] ?? 'N/A'),
//                     _buildInfoRow('Work-Phone:', widget.invoice['workphone'] ?? 'N/A'),
//                     _buildInfoRow('Due Date:', widget.invoice['dueDate']?.toDate().toString() ?? 'No due date'),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton.icon(
//               onPressed: () => _addItem(context),
//               icon: const Icon(Icons.add),
//               label: const Text('Add Item'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 12.0),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: selectedItems.length,
//                 itemBuilder: (context, index) {
//                   final item = selectedItems[index];
//                   return ListTile(
//                     title: Text(item['description']),
//                     subtitle: Text('Qty: ${item['quantity']}'),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text('₹${(item['quantity'] * item['price']).toStringAsFixed(2)}'),
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) => AlertDialog(
//                                 title: const Text('Confirm Delete'),
//                                 content: const Text('Are you sure you want to delete this item?'),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     child: const Text('Cancel'),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                   TextButton(
//                                     child: const Text('Delete'),
//                                     onPressed: () {
//                                       setState(() {
//                                         selectedItems.removeAt(index);
//                                         _calculateTotalAmount();
//                                       });
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                     onTap: () {
//                       _showItemDetailDialog(item);
//                       // Optionally implement an action when tapping on an item in the list
//                     },
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 16.0),
//            return ElevatedButton(
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) => AlertDialog(
//             title: const Text('Selected Items Checklist'),
//             content: SingleChildScrollView(
//               child: Container(
//                 width: double.maxFinite,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: selectedItems.length,
//                       itemBuilder: (context, index) {
//                         final item = selectedItems[index];
//                         return ListTile(
//                           title: Text(item['description']),
//                           subtitle: Text('Qty: ${item['quantity']}'),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 '₹${(item['quantity'] * item['price']).toStringAsFixed(2)}',
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.delete),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) => AlertDialog(
//                                       title: const Text('Confirm Delete'),
//                                       content: const Text('Are you sure you want to delete this item?'),
//                                       actions: <Widget>[
//                                         TextButton(
//                                           child: const Text('Cancel'),
//                                           onPressed: () {
//                                             Navigator.of(context).pop();
//                                           },
//                                         ),
//                                         TextButton(
//                                           child: const Text('Delete'),
//                                           onPressed: () {
//                                             setState(() {
//                                               selectedItems.removeAt(index);
//                                               _calculateTotalAmount();
//                                             });
//                                             Navigator.of(context).pop();
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             Navigator.of(context).pop();
//                             _updateItem(
//                               index,
//                               item['description'],
//                               item['quantity'],
//                               item['price'],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 16.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Subtotal:',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text('₹${_calculateSubtotal().toStringAsFixed(2)}'),
//                       ],
//                     ),
//                     const SizedBox(height: 8.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextField(
//                           controller: taxPercentage,
//                           decoration: InputDecoration(
//                             labelText: 'Tax %',
//                             border: OutlineInputBorder(),
//                           ),
//                           keyboardType: TextInputType.numberWithOptions(decimal: true),
//                           onChanged: (value) {
//                             setState(() {
//                               taxPercentage = double.parse(value);
//                               _calculateTotalAmount();
//                             });
//                           },
//                         ),
//                         Text('₹${_calculateTax(_calculateSubtotal()).toStringAsFixed(2)}'),
//                       ],
//                     ),
//                     const SizedBox(height: 8.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextField(
//                           controller: ,
//                           decoration: InputDecoration(
//                             labelText: 'Discount %',
//                             border: OutlineInputBorder(),
//                           ),
//                           keyboardType: TextInputType.numberWithOptions(decimal: true),
//                           onChanged: (value) {
//                             setState(() {
//                               discountPercentage = double.parse(value);
//                               _calculateTotalAmount();
//                             });
//                           },
//                         ),
//                         Text('₹${_calculateDiscount(_calculateSubtotal()).toStringAsFixed(2)}'),
//                       ],
//                     ),
//                     const Divider(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Total Amount:',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           '₹${totalAmount.toStringAsFixed(2)}',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text('Close'),
//                         ),
//                         ElevatedButton(
//                           onPressed: _submitBill,
//                           child: const Text('Submit Bill'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       child: const Text('Show Checklist'),
//     );
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, dynamic value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(width: 8.0),
//           Expanded(
//             child: Text(
//               value != null ? value.toString() : 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   void  _showItemDetailDialog(Map<String, dynamic> item) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.info,
//       animType: AnimType.scale,
//       title: 'Item Details',
//       desc: 'Description: ${item['description']}\n'
//             'Quantity: ${item['quantity']}\n'
//             'Price: ₹${item['price'].toStringAsFixed(2)}',
//       btnOkOnPress: () {},
//     ).show();
//   }
// }


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillingPage extends StatefulWidget {
  final Map<String, dynamic> invoice;
  

  const BillingPage({Key? key, required this.invoice}) : super(key: key);

  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  List<Map<String, dynamic>> selectedItems = [];
  double totalAmount = 0.0;
  double taxPercentage = 0.0;
  double discountPercentage = 0.0;
  List<Map<String, dynamic>> availableItems = [];

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchAvailableItems();
    _calculateTotalAmount();
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
              'Description': item['Item Name'],
              'Selling Price': item['Selling Price'],
            }).toList();
      });
    }
  }

  void _addItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int quantity = 1;
        Map<String, dynamic>? selectedItem =
            availableItems.isNotEmpty ? availableItems[0] : null;

        TextEditingController quantityController =
            TextEditingController(text: '1');

        return StatefulBuilder(
       builder: (BuildContext context, setState) {
  return availableItems.isEmpty
      ? ElevatedButton(
          onPressed: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              animType: AnimType.scale,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          availableItems.add({
                            'Description': 'New Item',
                            'Selling Price': 0.0,
                          });
                          selectedItem = availableItems.first;
                        });
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text(
                        'Click to add item',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              btnCancelOnPress: () {
                Navigator.of(context).pop();
              },
              // bodyDecoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(8.0), // Rounded corners for dialog body
              //   color: Colors.white, // Custom body color
              // ),
              headerAnimationLoop: false,
              btnCancelIcon: Icons.arrow_back,
              btnCancelColor: Colors.red,
            ).show();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add, size: 24.0),
              SizedBox(width: 8),
              Text('Add Item'),
            ],
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners for button
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          ),
        )
      : ElevatedButton(
          onPressed: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              animType: AnimType.scale,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<Map<String, dynamic>>(
                        value: selectedItem,
                        onChanged: (value) {
                          setState(() {
                            selectedItem = value;
                          });
                        },
                        items: availableItems.map((item) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: item,
                            child: Text(item['Description']),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Item',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Quantity: '),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              width: 50,
                              child: TextFormField(
                                controller: quantityController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  quantity = int.tryParse(value) ?? 1;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              btnCancelOnPress: () {
                Navigator.of(context).pop();
              },
              btnOkOnPress: () {
                if (selectedItem != null) {
                  setState(() {
                    selectedItems.add({
                      'description': selectedItem!['Description'],
                      'quantity': quantity,
                      'price': selectedItem!['Selling Price'],
                    });
                    _calculateTotalAmount();
                  });
                }
              },
              // bodyDecoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(8.0), // Rounded corners for dialog body
              //   color: Colors.white, // Custom body color
              // ),
              headerAnimationLoop: false,
              btnOkIcon: Icons.check_circle,
              btnCancelIcon: Icons.arrow_back,
              btnOkColor: Colors.green,
              btnCancelColor: Colors.red,
            ).show();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add, size: 24.0),
              SizedBox(width: 8),
              Text('Add Item'),
            ],
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners for button
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          ),
        );
},



        );
      },
    );
  }

  double _calculateSubtotal() {
    double subtotal = 0.0;
    for (var item in selectedItems) {
      subtotal += item['quantity'] * item['price'];
    }
    return subtotal;
  }

  double _calculateTax(double subtotal) {
    return (subtotal * (taxPercentage / 100));
  }

  double _calculateDiscount(double subtotal) {
    return (subtotal * (discountPercentage / 100));
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

  Widget _buildTaxInput() {
    return TextFormField(
      initialValue: taxPercentage.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) {
        setState(() {
          taxPercentage = double.tryParse(value) ?? 0.0;
          _calculateTotalAmount();
        });
      },
      decoration: const InputDecoration(
        labelText: 'Tax %',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDiscountInput() {
    return TextFormField(
      initialValue: discountPercentage.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) {
        setState(() {
          discountPercentage = double.tryParse(value) ?? 0.0;
          _calculateTotalAmount();
        });
      },
      decoration: const InputDecoration(
        labelText: 'Discount %',
        border: OutlineInputBorder(),
      ),
    );
  }

  void _calculateTotalAmount() {
    double subtotal = _calculateSubtotal();
    double taxAmount = _calculateTax(subtotal);
    double discountAmount = _calculateDiscount(subtotal);
    setState(() {
      totalAmount = subtotal + taxAmount - discountAmount;
    });
  }

  void _submitBill() async {
    if (selectedItems.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No Items Selected'),
          content: const Text('Please add at least one item to submit the bill.'),
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
      return;
    }
   
    try {
      await FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.uid)
          .collection('bills')
          .doc(widget.invoice['invoiceId'])
          .set({
        'Customer Name': widget.invoice['customerName'],
        'Customer Email': widget.invoice['customerEmail'],
        'Customer Address': widget.invoice['Address'],
        'Customer ID:': widget.invoice['customerID'],
        'status': widget.invoice['status'],
        'Due Date': widget.invoice['dueDate'],
        'Invoice Date': DateTime.now(),
        'Invoice ID': widget.invoice['invoiceId'],
        'Total Bill': totalAmount,
        'Procedures': selectedItems,
        'Tax Percentage': taxPercentage,
        'Discount Percentage': discountPercentage,
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

      setState(() {
        selectedItems.clear();
        totalAmount = 0.0;
        taxPercentage = 0.0;
        discountPercentage = 0.0;
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
        title: const Text('Billing Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Customer Details Card
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Customer Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _buildInfoRow('Name:', widget.invoice['customerName'] ?? 'N/A'),
                    _buildInfoRow('Customer ID:', widget.invoice['customerID'] ?? 'N/A'),
                    _buildInfoRow('Payment Status:', widget.invoice['status'] ?? 'N/A'),
                    _buildInfoRow('Email:', widget.invoice['customerEmail'] ?? 'N/A'),
                    _buildInfoRow('Address:', widget.invoice['customerAddress'] ?? 'N/A'),
                    _buildInfoRow('Mobile:', widget.invoice['mobile'] ?? 'N/A'),
                    _buildInfoRow('Work-Phone:', widget.invoice['workphone'] ?? 'N/A'),
                    _buildInfoRow('Due Date:', widget.invoice['dueDate']?.toDate().toString() ?? 'No due date'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () => _addItem(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Item'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  final item = selectedItems[index];
                  return ListTile(
                    title: Text(item['description']),
                    subtitle: Text('Qty: ${item['quantity']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('₹${(item['quantity'] * item['price']).toStringAsFixed(2)}'),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text('Are you sure you want to delete this item?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      setState(() {
                                        selectedItems.removeAt(index);
                                        _calculateTotalAmount();
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      _showItemDetailDialog(item);
                      // Optionally implement an action when tapping on an item in the list
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Selected Items Checklist'),
                    content: SingleChildScrollView(
  child: Container(
    padding: EdgeInsets.all(16.0),
    width: double.maxFinite,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 300, // Example constraint, adjust as needed
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: selectedItems.length,
            itemBuilder: (context, index) {
              final item = selectedItems[index];
              return ListTile(
                title: Text(item['description']),
                subtitle: Text('Qty: ${item['quantity']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '₹${(item['quantity'] * item['price']).toStringAsFixed(2)}',
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: const Text('Are you sure you want to delete this item?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  setState(() {
                                    selectedItems.removeAt(index);
                                    _calculateTotalAmount();
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateItem(
                    index,
                    item['description'],
                    item['quantity'],
                    item['price'],
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtotal:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('₹${_calculateSubtotal().toStringAsFixed(2)}'),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                initialValue: taxPercentage.toString(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  setState(() {
                    taxPercentage = double.tryParse(value) ?? 0.0;
                    _calculateTotalAmount(); // Recalculate total amount on tax change
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Tax %',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Text('₹${_calculateTax(_calculateSubtotal()).toStringAsFixed(2)}'),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                initialValue: discountPercentage.toString(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  setState(() {
                    discountPercentage = double.tryParse(value) ?? 0.0;
                    _calculateTotalAmount(); // Recalculate total amount on discount change
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Discount %',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Text('₹${_calculateDiscount(_calculateSubtotal()).toStringAsFixed(2)}'),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Amount:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '₹${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: _submitBill,
              child: const Text('Submit Bill'),
            ),
          ],
        ),
      ],
    ),
  ),
),




                  ),
                );
              },
              child: const Text('Show Checklist'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value != null ? value.toString() : 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _showItemDetailDialog(Map<String, dynamic> item) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      title: 'Item Details',
      desc: 'Description: ${item['description']}\n'
            'Quantity: ${item['quantity']}\n'
            'Price: ₹${item['price'].toStringAsFixed(2)}',
      btnOkOnPress: () {},
    ).show();
  }
}
