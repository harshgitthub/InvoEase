// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // // // // class SetupPatternScreen extends StatefulWidget {
// // // // //   const SetupPatternScreen({super.key});

// // // // //   @override
// // // // //   _SetupPatternScreenState createState() => _SetupPatternScreenState();
// // // // // }

// // // // // class _SetupPatternScreenState extends State<SetupPatternScreen> {
// // // // //   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

// // // // //   Future<void> _savePattern() async {
// // // // //     // This should be replaced with actual pattern input and storage
// // // // //     await _secureStorage.write(key: 'lockType', value: 'Pattern');
// // // // //     await _secureStorage.write(key: 'lockValue', value: 'dummy_pattern');
// // // // //     Navigator.pop(context);
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: const Text('Setup Pattern'),
// // // // //       ),
// // // // //       body: Center(
// // // // //         child: ElevatedButton(
// // // // //           onPressed: _savePattern,
// // // // //           child: const Text('Save Pattern (Dummy)'),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';

// // // // void main() => runApp(MyApp());

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       home: Scaffold(
// // // //         appBar: AppBar(title: Text('Flutter Custom Animated Loader')),
// // // //         body: Center(
// // // //           child: CustomLoader(),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class CustomLoader extends StatefulWidget {
// // // //   @override
// // // //   _CustomLoaderState createState() => _CustomLoaderState();
// // // // }

// // // // class _CustomLoaderState extends State<CustomLoader> with SingleTickerProviderStateMixin {
// // // //   late AnimationController _controller;
// // // //   late Animation<double> _animation;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _controller = AnimationController(
// // // //       duration: const Duration(seconds: 2),
// // // //       vsync: this,
// // // //     )..repeat();
// // // //     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _controller.dispose();
// // // //     super.dispose();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return AnimatedBuilder(
// // // //       animation: _animation,
// // // //       builder: (context, child) {
// // // //         return Transform.rotate(
// // // //           angle: _animation.value * 6.3, // 2 * pi (approximately)
// // // //           child: child,
// // // //         );
// // // //       },
// // // //       child: Icon(
// // // //         Icons.refresh,
// // // //         size: 50,
// // // //         color: Colors.blue,
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'dart:math';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:intl/intl.dart';

// // // class Invoicedetails extends StatefulWidget {
// // //   final Map<String, dynamic> customerData;

// // //   const Invoicedetails({Key? key, required this.customerData}) : super(key: key);

// // //   @override
// // //   State<Invoicedetails> createState() => _InvoicedetailsState();
// // // }

// // // class _InvoicedetailsState extends State<Invoicedetails> {
// // //   String _invoiceId = '';
// // //   String formattedDate = '';
// // //   DateTime? _selectedDate;
// // //   String? _paymentMethod;
// // //   String _review = '';
// // //   final Set<String> _selectedProcedures = {}; // Changed to Set for multi-selection

// // //   final currentuser = FirebaseAuth.instance.currentUser;
// // //   final List<String> _paymentMethods = ['Cash', 'Cheque', 'Online'];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _generateInvoiceId();
// // //     _formatDate();
// // //   }

// // //   void _generateInvoiceId() {
// // //     const length = 5;
// // //     const chars = 'ABC1234';
// // //     final random = Random();
// // //     setState(() {
// // //       _invoiceId = String.fromCharCodes(
// // //           Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
// // //     });
// // //   }

// // //   void _formatDate() {
// // //     formattedDate = DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
// // //   }

// // //   Future<void> _selectDueDate() async {
// // //     final DateTime? picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: _selectedDate ?? DateTime.now(),
// // //       firstDate: DateTime(2000),
// // //       lastDate: DateTime(2101),
// // //     );
// // //     if (picked != null && picked != _selectedDate) {
// // //       setState(() {
// // //         _selectedDate = picked;
// // //       });
// // //     }
// // //   }

// // //  Future<void> saveInvoice() async {
// // //   try {
// // //     if (widget.customerData == null) {
// // //       throw "Customer data is null";
// // //     }

// // //     if (currentuser == null) {
// // //       throw "User not logged in";
// // //     }

// // //     Timestamp now = Timestamp.now();

// // //     await FirebaseFirestore.instance
// // //         .collection("USERS")
// // //         .doc(currentuser!.uid)
// // //         .collection("invoices")
// // //         .doc(_invoiceId)
// // //         .set({
// // //       "customerName": '${widget.customerData["Salutation"] ?? ""} ${widget.customerData["First Name"] ?? ""} ${widget.customerData["Last Name"] ?? ""}',
// // //       "customerAddress": widget.customerData["Address"] ?? "",
// // //       "customerEmail": widget.customerData["Email"] ?? "",
// // //       "customerID": widget.customerData["customerID"] ?? "",
// // //       "workphone": widget.customerData["Work-phone"] ?? "",
// // //       "mobile": widget.customerData["Mobile"] ?? "",
// // //       "invoiceId": _invoiceId,
// // //       "invoiceDate": now,
// // //       "paymentMethod": _paymentMethod ?? "",
// // //       "review": _review ?? "",
// // //       "dueDate": _selectedDate,
// // //       "procedures": _selectedProcedures.toList(),
// // //       "status": false,
// // //     });

// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) => AlertDialog(
// // //         title: const Text('Success'),
// // //         content: const Text('Invoice saved successfully. Proceed to Billing Page'),
// // //         actions: <Widget>[
// // //           TextButton(
// // //             child: const Text('OK'),
// // //             onPressed: () {
// // //               Navigator.of(context).pop();
// // //               navigateToBillingPage(); // Navigate to BillingPage
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //     print("Invoice saved successfully!");
// // //   } catch (e) {
// // //     print("Error saving invoice: $e");

// // //     // Show error dialog
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) => AlertDialog(
// // //         title: const Text('Error'),
// // //         content: Text('Failed to save invoice: $e'),
// // //         actions: <Widget>[
// // //           TextButton(
// // //             child: const Text('OK'),
// // //             onPressed: () {
// // //               Navigator.of(context).pop();
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }


// // // void navigateToBillingPage() {
// // //   var invoice = {
// // //     "customerName": '${widget.customerData["Salutation"]} ${widget.customerData["First Name"]} ${widget.customerData["Last Name"]}',
// // //     "customerAddress": widget.customerData["Address"],
// // //     "customerEmail": widget.customerData["Email"],
// // //     "customerID": widget.customerData["customerID"],
// // //     "workphone": widget.customerData["Work-phone"],
// // //     "mobile": widget.customerData["Mobile"],
// // //     "invoiceId": _invoiceId,
// // //     "invoiceDate": Timestamp.now(),
// // //     "paymentMethod": _paymentMethod,
// // //     "review": _review,
// // //     "dueDate": _selectedDate,
// // //     "procedures": _selectedProcedures.toList(),
// // //     "status": false,
// // //   };

// // //   Navigator.pushNamed(context, '/billingpage', arguments: invoice);
// // // }


// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text("Invoice Details"),
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Text(
// // //                 '${widget.customerData["Salutation"]} ${widget.customerData["First Name"]} ${widget.customerData["Last Name"]}',
// // //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(height: 16),
// // //               const Text(
// // //                 "Invoice ID and Date:",
// // //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(height: 8),
// // //               Row(
// // //                 children: [
// // //                   Expanded(
// // //                     flex: 1,
// // //                     child: Card(
// // //                       elevation: 0,
// // //                       child: Padding(
// // //                         padding: const EdgeInsets.all(12.0),
// // //                         child: Column(
// // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // //                           children: [
// // //                             const Text(
// // //                               "Invoice ID:",
// // //                               style: TextStyle(fontSize: 18),
// // //                             ),
// // //                             const SizedBox(height: 4),
// // //                             Text(
// // //                               _invoiceId,
// // //                               style: const TextStyle(fontSize: 20),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(width: 16),
// // //                   Expanded(
// // //                     flex: 1,
// // //                     child: Card(
// // //                       elevation: 0,
// // //                       child: Padding(
// // //                         padding: const EdgeInsets.all(12.0),
// // //                         child: Column(
// // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // //                           children: [
// // //                             const Text(
// // //                               "Invoice Date:",
// // //                               style: TextStyle(fontSize: 18),
// // //                             ),
// // //                             const SizedBox(height: 4),
// // //                             Text(
// // //                               formattedDate,
// // //                               style: const TextStyle(fontSize: 20),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //               const SizedBox(height: 16),
// // //               const Text(
// // //                 "Due Date:",
// // //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(height: 8),
// // //               Card(
// // //                 elevation: 4,
// // //                 child: InkWell(
// // //                   onTap: () => _selectDueDate(),
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.all(12.0),
// // //                     child: Row(
// // //                       mainAxisSize: MainAxisSize.min,
// // //                       children: [
// // //                         Text(
// // //                           _selectedDate == null
// // //                               ? 'Select Due Date'
// // //                               : '${_selectedDate!.toLocal()}'.split(' ')[0],
// // //                           style: const TextStyle(fontSize: 20),
// // //                         ),
// // //                         const Icon(Icons.calendar_today),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 16),
// // //               const Text(
// // //                 "Payment Method:",
// // //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(height: 8),
// // //               DropdownButtonFormField<String>(
// // //                 value: _paymentMethod,
// // //                 onChanged: (value) {
// // //                   setState(() {
// // //                     _paymentMethod = value;
// // //                   });
// // //                 },
// // //                 decoration: const InputDecoration(
// // //                   border: OutlineInputBorder(),
// // //                   hintText: 'Select payment method',
// // //                 ),
// // //                 items: _paymentMethods.map((String method) {
// // //                   return DropdownMenuItem<String>(
// // //                     value: method,
// // //                     child: Text(method),
// // //                   );
// // //                 }).toList(),
// // //               ),
// // //               const SizedBox(height: 24),
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: [
// // //                   ElevatedButton(
// // //                     onPressed: () {
// // //                       saveInvoice();
// // //                     },
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: Colors.blue,
// // //                       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
// // //                       shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(4),
// // //                       ),
// // //                     ),
// // //                     child: const Text('Save', style: TextStyle(fontSize: 18, color: Colors.white)),
// // //                   ),
// // //                   const SizedBox(width: 16),
// // //                   ElevatedButton(
// // //                     onPressed: () {
// // //                       Navigator.of(context).pop();
// // //                     },
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: Colors.red,
// // //                       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
// // //                       shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(4),
// // //                       ),
// // //                     ),
// // //                     child: const Text('Cancel', style: TextStyle(fontSize: 18, color: Colors.white)),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }




// // import 'dart:math';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // class Invoicedetails extends StatefulWidget {
// //   final Map<String, dynamic> customerData;

// //   const Invoicedetails({Key? key, required this.customerData}) : super(key: key);

// //   @override
// //   State<Invoicedetails> createState() => _InvoicedetailsState();
// // }

// // class _InvoicedetailsState extends State<Invoicedetails> {
// //   String _invoiceId = '';
// //   String formattedDate = '';
// //   DateTime? _selectedDate;
// //   String? _paymentMethod;


// //   final currentuser = FirebaseAuth.instance.currentUser;
// //   final List<String> _paymentMethods = ['Cash', 'Cheque', 'Online'];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _generateInvoiceId();
// //     _formatDate();
// //   }

// //   void _generateInvoiceId() {
// //     const length = 5;
// //     const chars = 'ABC1234';
// //     final random = Random();
// //     setState(() {
// //       _invoiceId = String.fromCharCodes(
// //           Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
// //     });
// //   }

// //   void _formatDate() {
// //     formattedDate = DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
// //   }

// //   Future<void> _selectDueDate() async {
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: _selectedDate ?? DateTime.now(),
// //       firstDate: DateTime(2000),
// //       lastDate: DateTime(2101),
// //     );
// //     if (picked != null && picked != _selectedDate) {
// //       setState(() {
// //         _selectedDate = picked;
// //       });
// //     }
// //   }

// //   Future<void> saveInvoice() async {
// //     try {
// //       if (widget.customerData == null) {
// //         throw "Customer data is null";
// //       }

// //       if (currentuser == null) {
// //         throw "User not logged in";
// //       }

// //       Timestamp now = Timestamp.now();

// //       await FirebaseFirestore.instance
// //           .collection("USERS")
// //           .doc(currentuser!.uid)
// //           .collection("invoices")
// //           .doc(_invoiceId)
// //           .set({
// //         "customerName": '${widget.customerData["Salutation"] ?? ""} ${widget.customerData["First Name"] ?? ""} ${widget.customerData["Last Name"] ?? ""}',
// //         "customerAddress": widget.customerData["Address"] ?? "",
// //         "customerEmail": widget.customerData["Email"] ?? "",
// //         "customerID": widget.customerData["customerID"] ?? "",
// //         "workphone": widget.customerData["Work-phone"] ?? "",
// //         "mobile": widget.customerData["Mobile"] ?? "",
// //         "invoiceId": _invoiceId,
// //         "invoiceDate": now,
// //         "paymentMethod": _paymentMethod ?? "",
// //         "dueDate": _selectedDate,
       
// //         "status": false,
// //       });

// //       showDialog(
// //         context: context,
// //         builder: (BuildContext context) => AlertDialog(
// //           title: const Text('Success'),
// //           content: const Text('Invoice saved successfully. Proceed to Billing Page'),
// //           actions: <Widget>[
// //             TextButton(
// //               child: const Text('OK'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //                 navigateToBillingPage(); // Navigate to BillingPage
// //               },
// //             ),
// //           ],
// //         ),
// //       );
// //       print("Invoice saved successfully!");
// //     } catch (e) {
// //       print("Error saving invoice: $e");

// //       // Show error dialog
// //       showDialog(
// //         context: context,
// //         builder: (BuildContext context) => AlertDialog(
// //           title: const Text('Error'),
// //           content: Text('Failed to save invoice: $e'),
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

// //   void navigateToBillingPage() {
// //     var invoiced = {
// //       "customerName": '${widget.customerData["Salutation"] ?? ""} ${widget.customerData["First Name"] ?? ""} ${widget.customerData["Last Name"] ?? ""}',
// //       "customerAddress": widget.customerData["Address"] ?? "",
// //       "customerEmail": widget.customerData["Email"] ?? "",
// //       "customerID": widget.customerData["customerID"] ?? "",
// //       "workphone": widget.customerData["Work-phone"] ?? "",
// //       "mobile": widget.customerData["Mobile"] ?? "",
// //       "invoiceId": _invoiceId,
// //       "invoiceDate": Timestamp.now(),
// //       "paymentMethod": _paymentMethod,
  
// //       "dueDate": _selectedDate,
  
// //       "status": false,
// //     };

// //     Navigator.pushNamed(context, '/billingpage2', arguments: invoiced);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Invoice Details"),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 '${widget.customerData["Salutation"] ?? ""} ${widget.customerData["First Name"] ?? ""} ${widget.customerData["Last Name"] ?? ""}',
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 16),
// //               const Text(
// //                 "Invoice ID and Date:",
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 8),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     flex: 1,
// //                     child: Card(
// //                       elevation: 0,
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(12.0),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             const Text(
// //                               "Invoice ID:",
// //                               style: TextStyle(fontSize: 18),
// //                             ),
// //                             const SizedBox(height: 4),
// //                             Text(
// //                               _invoiceId,
// //                               style: const TextStyle(fontSize: 20),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 16),
// //                   Expanded(
// //                     flex: 1,
// //                     child: Card(
// //                       elevation: 0,
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(12.0),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             const Text(
// //                               "Invoice Date:",
// //                               style: TextStyle(fontSize: 18),
// //                             ),
// //                             const SizedBox(height: 4),
// //                             Text(
// //                               formattedDate,
// //                               style: const TextStyle(fontSize: 20),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 16),
// //               const Text(
// //                 "Due Date:",
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 8),
// //               Card(
// //                 elevation: 4,
// //                 child: InkWell(
// //                   onTap: () => _selectDueDate(),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(12.0),
// //                     child: Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Text(
// //                           _selectedDate == null
// //                               ? 'Select Due Date'
// //                               : '${_selectedDate!.toLocal()}'.split(' ')[0],
// //                           style: const TextStyle(fontSize: 20),
// //                         ),
// //                         const Icon(Icons.calendar_today),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               const Text(
// //                 "Payment Method:",
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 8),
// //               DropdownButtonFormField<String>(
// //                 value: _paymentMethod,
// //                 onChanged: (value) {
// //                   setState(() {
// //                     _paymentMethod = value;
// //                   });
// //                 },
// //                 decoration: const InputDecoration(
// //                   border: OutlineInputBorder(),
// //                   hintText: 'Select payment method',
// //                 ),
// //                 items: _paymentMethods.map((String method) {
// //                   return DropdownMenuItem<String>(
// //                     value: method,
// //                     child: Text(method),
// //                   );
// //                 }).toList(),
// //               ),
// //               const SizedBox(height: 24),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   ElevatedButton(
// //                     onPressed: () {
// //                       saveInvoice();
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.blue,
// //                       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(4),
// //                       ),
// //                     ),
// //                     child: const Text('Save', style: TextStyle(fontSize: 18, color: Colors.white)),
// //                   ),
// //                   const SizedBox(width: 16),
// //                   ElevatedButton(
// //                     onPressed: () {
// //                       Navigator.of(context).pop();
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.red,
// //                       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(4),
// //                       ),
// //                     ),
// //                     child: const Text('Cancel', style: TextStyle(fontSize: 18, color: Colors.white)),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class Invoicedetails extends StatefulWidget {
//   final Map<String, dynamic> customerData;

//   const Invoicedetails({Key? key, required this.customerData}) : super(key: key);

//   @override
//   State<Invoicedetails> createState() => _InvoicedetailsState();
// }

// class _InvoicedetailsState extends State<Invoicedetails> {
//   String _invoiceId = '';
//   String formattedDate = '';
//   DateTime? _selectedDate;
//   String? _paymentMethod;

//   final currentuser = FirebaseAuth.instance.currentUser;
//   final List<String> _paymentMethods = ['Cash', 'Cheque', 'Online'];

//   @override
//   void initState() {
//     super.initState();
//     _generateInvoiceId();
//     _formatDate();
//   }

//   void _generateInvoiceId() {
//     const length = 5;
//     const chars = 'ABC1234';
//     final random = Random();
//     setState(() {
//       _invoiceId = String.fromCharCodes(
//           Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
//     });
//   }

//   void _formatDate() {
//     formattedDate = DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
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

//   Future<void> saveInvoice() async {
//     try {
//       if (widget.customerData.isEmpty) {
//         throw "Customer data is empty";
//       }

//       if (currentuser == null) {
//         throw "User not logged in";
//       }

//       Timestamp now = Timestamp.now();

//       await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("invoices")
//           .doc(_invoiceId)
//           .set({
//         "customerName": '${widget.customerData["Salutation"] ?? ""} ${widget.customerData["First Name"] ?? ""} ${widget.customerData["Last Name"] ?? ""}',
//         "customerAddress": widget.customerData["Address"] ?? "",
//         "customerEmail": widget.customerData["Email"] ?? "",
//         "customerID": widget.customerData["customerID"] ?? "",
//         "workphone": widget.customerData["Work-phone"] ?? "",
//         "mobile": widget.customerData["Mobile"] ?? "",
//         "invoiceId": _invoiceId,
//         "invoiceDate": now,
//         "paymentMethod": _paymentMethod ?? "",
//         "dueDate": _selectedDate,
//         "status": false,
//       });

//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Success'),
//           content: const Text('Invoice saved successfully. Proceed to Billing Page'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 navigateToBillingPage(); // Navigate to BillingPage
//               },
//             ),
//           ],
//         ),
//       );
//       print("Invoice saved successfully!");
//     } catch (e) {
//       print("Error saving invoice: $e");

//       // Show error dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Error'),
//           content: Text('Failed to save invoice: $e'),
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

//   void navigateToBillingPage() {
//     if (widget.customerData.isEmpty) {
//       print("Error: customerData is empty");
//       return;
//     }

//     var invoiced = {
//       "customerName": '${widget.customerData["Salutation"] ?? ""} ${widget.customerData["First Name"] ?? ""} ${widget.customerData["Last Name"] ?? ""}',
//       "customerAddress": widget.customerData["Address"] ?? "",
//       "customerEmail": widget.customerData["Email"] ?? "",
//       "customerID": widget.customerData["customerID"] ?? "",
//       "workphone": widget.customerData["Work-phone"] ?? "",
//       "mobile": widget.customerData["Mobile"] ?? "",
//       "invoiceId": _invoiceId,
//       "invoiceDate": Timestamp.now(),
//       "paymentMethod": _paymentMethod,
//       "dueDate": _selectedDate,
//       "status": false,
//     };

//     Navigator.pushNamed(context, '/billingpage2', arguments: invoiced);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Invoice Details"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '${widget.customerData["Salutation"] ?? ""} ${widget.customerData["First Name"] ?? ""} ${widget.customerData["Last Name"] ?? ""}',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "Invoice ID and Date:",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Card(
//                       elevation: 0,
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Invoice ID:",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               _invoiceId,
//                               style: const TextStyle(fontSize: 20),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     flex: 1,
//                     child: Card(
//                       elevation: 0,
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Invoice Date:",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               formattedDate,
//                               style: const TextStyle(fontSize: 20),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "Due Date:",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Card(
//                 elevation: 4,
//                 child: InkWell(
//                   onTap: () => _selectDueDate(),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           _selectedDate == null
//                               ? 'Select Due Date'
//                               : '${_selectedDate!.toLocal()}'.split(' ')[0],
//                           style: const TextStyle(fontSize: 20),
//                         ),
//                         const Icon(Icons.calendar_today),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "Payment Method:",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: _paymentMethod,
//                 onChanged: (value) {
//                   setState(() {
//                     _paymentMethod = value;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Select payment method',
//                 ),
//                 items: _paymentMethods.map((String method) {
//                   return DropdownMenuItem<String>(
//                     value: method,
//                     child: Text(method),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       saveInvoice();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     child: const Text('Save', style: TextStyle(fontSize: 18, color: Colors.white)),
//                   ),
//                   const SizedBox(width: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     child: const Text('Cancel', style: TextStyle(fontSize: 18, color: Colors.white)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:cloneapp/pages/subpages/settings/recover.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Invoicedetails extends StatefulWidget {
  final Map<String, dynamic> customerData;

  const Invoicedetails({Key? key, required this.customerData}) : super(key: key);

  @override
  State<Invoicedetails> createState() => _InvoicedetailsState();
}

class _InvoicedetailsState extends State<Invoicedetails> {
  String _invoiceId = '';
  String formattedDate = '';
  DateTime? _selectedDate;
  String? _paymentMethod;

  final currentuser = FirebaseAuth.instance.currentUser;
  final List<String> _paymentMethods = ['Cash', 'Cheque', 'Online'];

  @override
  void initState() {
    super.initState();
    _generateInvoiceId();
    _formatDate();
  }

  void _generateInvoiceId() {
    const length = 5;
    const chars = 'ABC1234';
    final random = Random();
    setState(() {
      _invoiceId = String.fromCharCodes(
          Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    });
  }

  void _formatDate() {
    formattedDate = DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
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

  Future<void> saveInvoice() async {
    try {
      if (widget.customerData.isEmpty) {
        throw "Customer data is empty";
      }

      if (currentuser == null) {
        throw "User not logged in";
      }

      Timestamp now = Timestamp.now();

      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("invoices")
          .doc(_invoiceId)
          .set({
        "customerName": '${widget.customerData["Salutation"] ?? ""} ${widget.customerData["First Name"] ?? ""} ${widget.customerData["Last Name"] ?? ""}',
        "customerAddress": widget.customerData["Address"] ?? "",
        "customerEmail": widget.customerData["Email"] ?? "",
        "customerID": widget.customerData["customerID"] ?? "",
        "workphone": widget.customerData["Work-phone"] ?? "",
        "mobile": widget.customerData["Mobile"] ?? "",
        
        "invoiceId": _invoiceId,
        "invoiceDate": now,
        "paymentMethod": _paymentMethod ?? "",
        "dueDate": _selectedDate,
        "status": false,
      });

      var invoicedData = {
        "customerName": '${widget.customerData["Salutation"] ?? ""} ${widget.customerData["First Name"] ?? ""} ${widget.customerData["Last Name"] ?? ""}',
        "customerAddress": widget.customerData["Address"] ?? "",
        "customerEmail": widget.customerData["Email"] ?? "",
        "customerID": widget.customerData["customerID"] ?? "",
        "workphone": widget.customerData["Work-Phone"] ?? "",
        "mobile": widget.customerData["Mobile"] ?? "",
        "invoiceId": _invoiceId,
        "invoiceDate": now,
        "paymentMethod": _paymentMethod,
        "dueDate": _selectedDate,
        "status": false,
      };

      navigateToBillingPage(invoicedData);
    } catch (e) {
      print("Error saving invoice: $e");

      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to save invoice: $e'),
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

  void navigateToBillingPage(Map<String, dynamic> invoicedData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillingPage2(invoicedData: invoicedData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.customerData["Salutation"] ?? ""} ${widget.customerData["First Name"] ?? ""} ${widget.customerData["Last Name"] ?? ""}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "Invoice ID and Date:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Invoice ID:",
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _invoiceId,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Invoice Date:",
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formattedDate,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Due Date:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 4,
                child: InkWell(
                  onTap: () => _selectDueDate(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'Select Due Date'
                              : '${_selectedDate!.toLocal()}'.split(' ')[0],
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Payment Method:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select payment method',
                ),
                items: _paymentMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      saveInvoice();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text('Save', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text('Cancel', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
