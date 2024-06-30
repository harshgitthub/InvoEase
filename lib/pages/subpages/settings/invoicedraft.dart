// // import 'dart:convert';
// // import 'dart:math';
// // import 'package:cloneapp/pages/customerpage.dart';
// // import 'package:cloneapp/pages/home.dart';
// // import 'package:cloneapp/pages/invoiceadd.dart';
// // import 'package:cloneapp/pages/subpages/settings/applock.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:intl/intl.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:url_launcher/url_launcher.dart';


// // class Invoicedraft extends StatefulWidget {
// //   final String invoiceId;
  

// //   const Invoicedraft({Key? key, required this.invoiceId}) : super(key: key);

// //   @override
// //   State<Invoicedraft> createState() => _InvoicedraftState();
// // }

// // class _InvoicedraftState extends State<Invoicedraft> {
// //   bool _showDetails = false; 
// //   final currentuser = FirebaseAuth.instance.currentUser;
// //   TextEditingController _paymentdue = TextEditingController();
// //   TextEditingController _paymentreceived  = TextEditingController();

// //   Map<String, dynamic>? invoiceData;
// //    List<Map<String, dynamic>> paymentHistory = [];
// //    double totalReceived = 0 ; 

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchInvoiceData();
// //     _updatePaymentDue();
// //     _paymentreceived.addListener(_updatePaymentDue);
// //     // _loadPaymentData();
// //   }

// //   Future<void> fetchInvoiceData() async {
// //     try {
// //       DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
// //           .collection('USERS')
// //           .doc(currentuser!.uid)
// //           .collection('invoices')
// //           .doc(widget.invoiceId)
// //           .get();

// //       if (invoiceSnapshot.exists) {
// //         setState(() {
// //           invoiceData = invoiceSnapshot.data() as Map<String, dynamic>;

//         // _paymentreceived.text = invoiceData!['paymentReceived']?? '';
//         // _paymentdue.text = invoiceData!['paymentDue']?? '';
//         // _updatePaymentDue();
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print("Error fetching invoice data: $e");
//   //   }
//   // }
  
//   void _updatePaymentDue() {
//   if (invoiceData != null && invoiceData!['totalBill'] != null) {
//     double total = invoiceData!['totalBill'];
//     double received = double.tryParse(_paymentreceived.text) ?? 0.0;
//     double dues = total - received;
//     _paymentdue.text = dues.toStringAsFixed(2);
//   }
// }

// // Future<void> savePaymentHistory() async {
// //   double paymentReceived = double.tryParse(_paymentreceived.text) ?? 0;
// //   double paymentDue = double.tryParse(_paymentdue.text) ?? 0;
// //   double totalReceived = 0;
// //   double totalDue = invoiceData!["totalBill"];

// //   if (paymentReceived > 0) {
// //     setState(() {
// //       // Update payment history
// //       paymentHistory.add({
// //         'type': 'Received',
// //         'amount': paymentReceived,
// //         'due': paymentDue,
// //         'dateTime': DateTime.now().toIso8601String(), // Save as ISO string
// //       });

// //       // Update total received and due
// //       totalReceived += paymentReceived;
// //       totalDue -= paymentReceived;
// //       _paymentdue.text = totalDue.toString();

// //       // Clear the received field
// //       _paymentreceived.clear();
// //     });

// //     // Save to shared preferences
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('paymentHistory', jsonEncode(paymentHistory));
// //     await prefs.setDouble('totalReceived', totalReceived);
// //     await prefs.setDouble('totalDue', totalDue);
// //   }
// // }


// // Future<void> _loadPaymentData() async {
// //   SharedPreferences prefs = await SharedPreferences.getInstance();
// //   String? paymentHistoryString = prefs.getString('paymentHistory');
// //   double? totalReceived = prefs.getDouble('totalReceived');
// //   double? totalDue = prefs.getDouble('totalDue');

// //   if (paymentHistoryString != null) {
// //     setState(() {
// //       paymentHistory = List<Map<String, dynamic>>.from(
// //         jsonDecode(paymentHistoryString)
// //       );
// //     });
// //   }

// //   if (totalReceived != null && totalDue != null) {
// //     setState(() {
// //       this.totalReceived = totalReceived;
// //       _paymentdue.text = totalDue.toString();
// //     });
// //   }
// // }
// //  bool _showRulesScreen = false;

// //   void _toggleRulesScreen() {
// //     setState(() {
// //       _showRulesScreen = !_showRulesScreen;
// //     });
// //   }

// Future<void> savePaymentDetails() async {
//   // try {
//   //   double received = double.parse(_paymentreceived.text);
//   //   double due = double.parse(_paymentdue.text);

//   //   await FirebaseFirestore.instance
//   //       .collection('USERS')
//   //       .doc(currentuser!.uid)
//   //       .collection('invoices')
//   //       .doc(widget.invoiceId)
//   //       .update({
//   //         'paymentReceived': received,
//   //         'paymentDue': due,
//   //       });

  
//   //       showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) => AlertDialog(
//   //         title: const Text('Success'),
//   //         content: const Text('Invoice saved successfully'),
//   //         actions: <Widget>[
//   //           TextButton(
//   //             child: const Text('OK'),
//   //            onPressed: () {
//   //   fetchInvoiceData().then((_) {
//   //     Navigator.pop(context); // This will pop the current screen off the stack
//   //   }).catchError((error) {
//   //     print("Error fetching invoice data: $error");
//   //   });
//   // },
//   //           ),
//   //         ],
//   //       ),
//   //     );
//   //       print("success");
//   // }
//   // catch(e){
//   //   print(" ERROR ");
//   // }
// }

  // Future<void> _makePhoneCall() async {
  //   // dynamic mobile = invoiceData!['mobile'];

  //   // if (mobile is int) {
  //   //   String phoneNumber = mobile.toString();
  //   //   String url = 'tel:$phoneNumber';
  //   //   await _launchURL(url);
  //   // } else {
  //   //   throw 'Phone number not available';
  //   // }
  // }

  // Future<void> _sendMessage() async {
  //   // dynamic mobile = invoiceData!['Mobile'];

  //   // if (mobile is int) {
  //   //   String phoneNumber = mobile.toString();
  //   //   String url = 'sms:$phoneNumber';
  //   //   await _launchURL(url);
  //   // } else if (mobile is String) {
  //   //   String url = 'sms:$mobile';
  //   //   await _launchURL(url);
  //   // } else {
  //   //   throw 'Mobile number is not available or not valid';
  //   // }
  // }

  // Future<void> _launchURL(String url) async {
  //   try {
  //     if (await canLaunch(url)) {
  //       await launch(url);
  //     } else {
  //       throw 'Could not launch $url';
  //     }
  //   } catch (e) {
  //     print('Error launching URL: $e');
  //   }
  // }

//   @override
//   Widget build(BuildContext context) {
//      bool isPaid = invoiceData!['status'];
//     String statusText = isPaid ? 'PAID' : 'UNPAID';
//     Color statusColor = isPaid ? Colors.green : Colors.red;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Invoice Draft"),
//         actions: [
//           // IconButton(
//           //   icon: const Icon(Icons.edit),
//           //   onPressed: () {
//           //     Navigator.push(
//           //       context,
//           //       MaterialPageRoute(
//           //         builder: (context) => InvoiceEdit(
//           //           invoiceId: widget.invoiceId,
//           //           customerID: invoiceData!['customerID'],
//           //         ),
//           //       ),
//           //     );
//           //   },
//           // ),
          // IconButton(
          //   icon: const Icon(Icons.phone),
          //   onPressed: () {
          //     _makePhoneCall();
          //   },
          // ),
          // IconButton(
          //   icon: const Icon(Icons.message),
          //   onPressed: () {
          //     _sendMessage();
          //   },
          // ),
//           IconButton(
//           onPressed: fetchInvoiceData,
//           icon: const Icon(Icons.refresh),
//         ),
//            PopupMenuButton<String>(
//             icon: const Icon(Icons.more_vert, color: Colors.black),
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//               // Menu items
//           const    PopupMenuItem<String>(
//                 value: 'customer',
//                 child: ListTile(
//                   leading: Icon(Icons.person_add),
//                   title: Text('New Customer'),
//                 ),
//               ),
//          const    PopupMenuItem<String>(
//                 value: 'invoice',
//                 child: ListTile(
//                   leading: Icon(Icons.add),
//                   title: Text('New Invoice'),
//                 ),
//               ),
              
//            const    PopupMenuItem<String>(
//                 value: 'proceed_payment',
//                 child: ListTile(
//                   leading: Icon(Icons.payment),
//                   title: Text('Get Invoice'),
//                 ),
//               ),
//            const  PopupMenuItem<String>(
//                 value: 'edit',
//                 child: ListTile(
//                   leading: Icon(Icons.edit),
//                   title: Text('edit invoice'),
//                 ),
//               ),
                  
//            const    PopupMenuItem<String>(
//                 value: 'edit_customer',
//                 child: ListTile(
//                   leading: Icon(Icons.edit_document),
//                   title: Text('Edit Customer'),
//                 ),
//               ),
//             ],
//             onSelected: (String value) {
//               // Handle menu item selection
//               switch (value) {
//                 case 'customer':
//                   // Navigate to customer screen or perform related action
//                   Navigator.pushNamed(context, '/customer');
//                   break;

//                 case 'invoice':
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => InvoiceAdd(customerID: invoiceData!['customerID'],)
//                   ),   
//                   );
//                   break;
//                 case 'edit':
//                   // Add new invoice action
              //     Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => InvoiceEdit(
              //       invoiceId: widget.invoiceId,
              //       customerID: invoiceData!['customerID'],
              //     ),
              //   ),
              // );
//                   break;
//                  case 'edit_customer':
//               // Add new invoice action
//               //   Navigator.push(
//               //     context,
//               //     MaterialPageRoute(
//               //       builder: (context) => Customeredit( customerData: invoiceData, ),
//               //     ),
//               // );
//                   break;
//                 case 'proceed_payment':
//                   // Proceed to payment action
//                    Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => PreviewBill(invoiceId: widget.invoiceId,)
//                   ), 
//               );
//                   break;
//                 default:
//               }
//             },
//           ),
//         ],
//       ),
//       drawer: drawer(context),
// body: 
// invoiceData == null
//     ? const Center(child: CircularProgressIndicator())
//     : DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Invoice ID: ${widget.invoiceId}',
//                       style: const TextStyle(
//                           fontSize: 21, fontWeight: FontWeight.bold),
//                     ),
//                     _buildDetailItem(
//                       'Invoice Date',
//                       DateFormat('dd-MM-yyyy').format(
//                           (invoiceData!['invoiceDate'] as Timestamp)
//                               .toDate()),
//                     ),
//                     Text(
//                       invoiceData!['customerName'],
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     const SizedBox(height: 25),
//                     Text(
//                       'Balance : ${invoiceData!["totalBill"]}',
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       statusText,
//                       style: TextStyle(
//                           color: statusColor,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Container(
//                 constraints: const BoxConstraints.expand(height: 50),
//                 decoration: const BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: const TabBar(
//                   labelColor: Colors.white,
//                   unselectedLabelColor: Colors.white,
//                   indicatorColor: Colors.white,
//                   tabs: [
//                     Tab(
//                       child: Text(
//                         'Details',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         'Payment',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         'History',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     // Details Tab
//                     SingleChildScrollView(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               _buildDetailItem('Customer Name',
//                                   invoiceData!['customerName'] ?? ''),
//                               const SizedBox(width: 10),
//                               IconButton(
//                                 icon: Icon(_showDetails
//                                     ? Icons.arrow_drop_up
//                                     : Icons.arrow_drop_down),
//                                 onPressed: () {
//                                   setState(() {
//                                     _showDetails =
//                                         !_showDetails; // Toggle details visibility
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                           Visibility(
//                             visible: _showDetails,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 _buildDetailItem('Customer Address',
//                                     invoiceData!['customerAddress'] ?? ''),
//                                 _buildDetailItem('Customer Email',
//                                     invoiceData!['customerEmail'] ?? ''),
//                                 // _buildDetailItem('Work Phone',
//                                 //     invoiceData!['workphone'] ?? ''),
//                                 // _buildDetailItem('Mobile',
//                                 //     invoiceData!['mobile'] ?? ''),
//                               ],
//                             ),
//                           ),
//                           // if (invoiceData!['dueDate'] != null)
//                           //   _buildDetailItem(
//                           //     'Due Date',
//                           //     DateFormat('dd-MM-yyyy').format(
//                           //         (invoiceData!['dueDate'] as Timestamp)
//                           //             .toDate()),
//                           //   ),
//                           const Divider(thickness: 1, color: Colors.grey),
//                           const Text(
//                             'Items:',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 8),
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: (invoiceData!['items'] as List).length,
//                             itemBuilder: (context, index) {
//                               Map<String, dynamic> item =
//                                   (invoiceData!['items'] as List)[index];
//                               return ListTile(
//                                 title: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       flex: 1,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             item['itemName'],
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 15),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             '${item['quantity']} X ${item['rate']}',
//                                             style: const TextStyle(
//                                                 fontSize: 15),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             '${item['price'].toStringAsFixed(2)}',
//                                             style: const TextStyle(
//                                                 fontSize: 15),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                           const Divider(thickness: 1, color: Colors.grey),
//                           _buildDetailItemForDouble('SubTotal',
//                               invoiceData!['total amount'] ?? 0.0),
//                           _buildDetailItemFor('Discount %',
//                               invoiceData!['discount'] ?? 0.0),
//                           _buildDetailItemFor('Tax %',
//                               invoiceData!['tax'] ?? 0.0),
//                           _buildDetailItemForDouble('Total',
//                               invoiceData!['totalBill'] ?? 0.0),
//                          _buildDetailItemFor('Due' , invoiceData!['total amount'])
//                               ,
//                               const SizedBox(height: 20,)

//                             , 
//           //                   Container(
//           //                     height: double.infinity ,
//           //                     width: double.infinity,
//           //                     child: 
//           //                   Column(
                              
//           //                     children: [ Container(
//           //   width: double.infinity,
//           //   child: TextButton(
//           //     child: Text("Terms and Conditions +" , style: TextStyle(fontSize: 25),),
//           //     onPressed: _toggleRulesScreen,
//           //   ),
//           // ),
//           // if (_showRulesScreen)
//           //   Expanded(child: RulesInputScreen()),
  
//           //                     ]
//           //                   )
//           //                   )
//                         ],
//                       ),
//                     ),
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Text("data")
//                         ],
//                       ),
//                     ),
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Text("data")
//                         ],
//                       ),
//                     )
//                     // Payments Tab
// //                     SingleChildScrollView(
// //   padding: const EdgeInsets.all(16.0),
// //   child: Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //       _buildDetailItem('Payment Method', invoiceData!['paymentMethod'] ?? ''),
// //       const SizedBox(height: 20), // Adding space between items
// //       Container(
// //         padding: const EdgeInsets.all(16.0),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(8.0),
// //           boxShadow: [
// //             const BoxShadow(
// //               color: Colors.black12,
// //               blurRadius: 8.0,
// //               offset: Offset(0, 2),
// //             ),
// //           ],
// //           border: Border.all(
// //             color: Colors.grey.shade300,
// //           ),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             TextFormField(
// //               controller: _paymentreceived,
// //               decoration: const InputDecoration(
// //                 labelText: 'Payment Received',
// //                 border: OutlineInputBorder(),
// //               ),
// //               keyboardType: TextInputType.number,
// //             ),
// //             const SizedBox(height: 10),
// //             TextFormField(
// //               controller: _paymentdue,
// //               decoration: const InputDecoration(
// //                 labelText: 'Payment Due',
// //                 border: OutlineInputBorder(),
// //               ),
// //               keyboardType: TextInputType.none,
// //               readOnly: true, // Make this field read-only
// //             ),
// //             const SizedBox(height: 20),
// //             Center(
// //               child: ElevatedButton(
// //                 onPressed: () async {
// //                   await savePaymentHistory();
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
// //                   textStyle: const TextStyle(fontSize: 16.0),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(8.0),
// //                   ),
// //                   // Change to your preferred color
// //                 ),
// //                 child: const Text('Save'),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     ],
// //   ),
// // ),
// //                     // History Tab
// //                      SingleChildScrollView(
// //                       padding: EdgeInsets.all(16.0),
// //                       child: Container(
// //               padding: const EdgeInsets.all(16.0),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(8.0),
// //                 boxShadow: [
// //                   const BoxShadow(
// //                     color: Colors.black12,
// //                     blurRadius: 8.0,
// //                     offset: Offset(0, 2),
// //                   ),
// //                 ],
// //                 border: Border.all(
// //                   color: Colors.grey.shade300,
// //                 ),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const SizedBox(height: 10),
// //                   ListView.builder(
// //                     shrinkWrap: true,
// //                     itemCount: paymentHistory.length,
// //                     itemBuilder: (context, index) {
// //                       final historyItem = paymentHistory[index];
// //                       return ListTile(
// //                         title: Text('${historyItem['type']} - \$${historyItem['amount']}'),
// //                         subtitle: Text('Date: ${historyItem['dateTime'].toString()}'),
// //                         trailing: Text('${historyItem['due']} '),
// //                       );
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),
// //         ),
// //                ]   ),
// //               )
          
// //                   ],
// //                 ),
// //               ),
// //           ),
// //         );
// //   }

// // Widget _buildDetailItem(String label, String value) {
// //   return Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //       Text(
// //         value,
// //         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //       ),
// //     ],
// //   );
// // }

// // Widget _buildDetailItemForDouble(String title, double value) {
// //   return Padding(
// //     padding: const EdgeInsets.only(top: 2),
// //     child: Row(
// //       crossAxisAlignment: CrossAxisAlignment.end,
// //       children: [
// //         Expanded(
// //           flex: 2,
// //           child: Text(
// //             title,
// //             style: const TextStyle(
// //                 fontWeight: FontWeight.bold, fontSize: 15),
// //           ),
// //         ),
// //         Expanded(
// //           flex: 2,
// //           child: Text(
// //             value.toStringAsFixed(2),
// //             style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }

// // Widget _buildDetailItemFor(String title, double value) {
// //   return Padding(
// //     padding: const EdgeInsets.only(top: 2),
// //     child: Row(
// //       crossAxisAlignment: CrossAxisAlignment.end,
// //       children: [
// //         Expanded(
// //           flex: 2,
// //           child: Text(
// //             title,
// //             style: const TextStyle(fontSize: 15),
// //           ),
// //         ),
// //         Expanded(
// //           flex: 2,
// //           child: Text(
// //             value.toStringAsFixed(2),
// //             style: const TextStyle(
// //               fontSize: 15,
// //             ),
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }
// //   }
// //   Widget _buildDetailItem(String label, String value) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //        Text(value , style:  const TextStyle( fontSize: 20 , fontWeight: FontWeight.bold),)
// //       ],
// //     );
// //   }



// class InvoiceEdit extends StatefulWidget {
//   final String invoiceId;
//   final String customerID;

//   const InvoiceEdit({Key? key, required this.invoiceId, required this.customerID}) : super(key: key);

//   @override
//   _InvoiceEditState createState() => _InvoiceEditState();
// }

// class _InvoiceEditState extends State<InvoiceEdit> {
//   String _invoiceId = '';
//   DateTime? _invoiceDate;
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
//   String? _customerid;
//   final currentuser = FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//     super.initState();
//     _fetchInvoiceDetails();
//   }

//   Future<void> _fetchInvoiceDetails() async {
//     try {
//       DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentuser!.uid)
//           .collection('invoices')
//           .doc(widget.invoiceId)
//           .get();

//       if (invoiceSnapshot.exists) {
//         setState(() {
//           _invoiceId = widget.invoiceId;
//           _invoiceDate = invoiceSnapshot['invoiceDate'] != null
//               ? (invoiceSnapshot['invoiceDate'] as Timestamp).toDate()
//               : null;
//           // _selectedDate = invoiceSnapshot['dueDate'] != null
//           //     ? (invoiceSnapshot['dueDate'] as Timestamp).toDate()
//           //     : null;
//           _paymentMethod = invoiceSnapshot['paymentMethod'];
//           _selectedItems = List<Map<String, dynamic>>.from(invoiceSnapshot['items']);
//           _customerName = invoiceSnapshot['customerName'];
//           _customerAddress = invoiceSnapshot['customerAddress'];
//           _customerEmail = invoiceSnapshot['customerEmail'];
//           _customerWorkPhone = invoiceSnapshot['workphone'];
//           _customerMobile = invoiceSnapshot['mobile'];
//           _customerid = invoiceSnapshot['customerID'];
//         });
//       }
//     } catch (e) {
//       print("Error fetching invoice details: $e");
//     }
//   }

//   // Future<void> _selectDueDate() async {
//   //   final DateTime? picked = await showDatePicker(
//   //     context: context,
//   //     initialDate: _selectedDate ?? DateTime.now(),
//   //     firstDate: DateTime(2000),
//   //     lastDate: DateTime(2101),
//   //   );
//   //   if (picked != null && picked != _selectedDate) {
//   //     setState(() {
//   //       _selectedDate = picked;
//   //     });
//   //   }
//   // }

//   void _addItems() async {
//     final Map<String, dynamic>? result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const AddItems()), // Replace with your AddItems page
//     );
//     if (result != null) {
//       setState(() {
//         _selectedItems.add(result);
//       });
//     }
//   }

//   Future<void> _saveChanges() async {
//     try {
//       // Construct updated invoice data
//       Map<String, dynamic> updatedInvoice = {
//         "customerName": _customerName,
//         "customerAddress": _customerAddress,
//         "customerEmail": _customerEmail,
//         "customerID": _customerid,
//         "workphone": _customerWorkPhone,
//         "mobile": _customerMobile,
//         "invoiceId": _invoiceId,
//         "invoiceDate": _invoiceDate != null ? Timestamp.fromDate(_invoiceDate!) : null,
//         "paymentMethod": _paymentMethod,
//         // "dueDate": _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
//         "items": _selectedItems,
//         "status": false, // Example status, update as needed
//       };

//       // Update invoice data in Firestore
//       await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("invoices")
//           .doc(_invoiceId)
//           .update(updatedInvoice);

//       // Show success dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Success'),
//           content: const Text('Invoice updated successfully'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//                  // Pop InvoiceEdit screen
//               },
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       print("Error saving changes: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Invoice"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Invoice ID: $_invoiceId'),
//               const SizedBox(height: 16),
//               Text('Invoice Date: ${_invoiceDate != null ? DateFormat('dd-MM-yyyy').format(_invoiceDate!) : ''}'),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   const Text('Due Date:'),
//                   const SizedBox(width: 16),
//                   GestureDetector(
//                     // onTap: _selectDueDate,
//                     child: Text(
//                       _selectedDate == null
//                           ? 'Select Due Date'
//                           : DateFormat('dd-MM-yyyy').format(_selectedDate!),
//                       style: const TextStyle(fontWeight: FontWeight.bold),
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
//                   labelText: 'Select Payment Method',
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
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _addItems,
//                 child: const Text('Add Items'),
//               ),
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
//                       trailing: Text('Price: ${_selectedItems[index]['price'].toStringAsFixed(2)}'
//                                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _saveChanges,
//                   child: const Text('Save Changes'),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void successdialog(){
//     showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Success'),
//           content: const Text('Invoice saved successfully'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
               
//               },
//             ),
//           ],
//         ),
//       );
//   }
// }


// // class RulesInputScreen extends StatefulWidget {
// //   @override
// //   _RulesInputScreenState createState() => _RulesInputScreenState();
// // }

// // class _RulesInputScreenState extends State<RulesInputScreen> {
// //   List<String> rules = [];
// //   List<TextEditingController> controllers = [];
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadRules();
// //   }

// //   @override
// //   void dispose() {
// //     for (var controller in controllers) {
// //       controller.dispose();
// //     }
// //     super.dispose();
// //   }

// //   Future<void> _loadRules() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     setState(() {
// //       rules = prefs.getStringList('rules') ?? [];
// //       controllers = List.generate(rules.length, (index) => TextEditingController(text: rules[index]));
// //     });
// //   }

// //   Future<void> _saveRules() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setStringList('rules', rules);
// //   }

// //   void _addRule() {
// //     setState(() {
// //       rules.add('');
// //       controllers.add(TextEditingController());
// //     });
// //   }

// //   void _removeRule(int index) {
// //     setState(() {
// //       rules.removeAt(index);
// //       controllers[index].dispose();
// //       controllers.removeAt(index);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
      
// //       body: Form(
// //         key: _formKey,
// //         child: ListView.builder(
// //           itemCount: rules.length,
// //           itemBuilder: (context, index) {
// //             return ListTile(
// //               leading: Text((index + 1).toString()),
// //               title: TextFormField(
// //                 controller: controllers[index],
// //                 decoration: InputDecoration(
// //                   labelText: 'Enter rule',
// //                   suffixIcon: IconButton(
// //                     icon: Icon(Icons.delete),
// //                     onPressed: () => _removeRule(index),
// //                   ),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter a rule';
// //                   }
// //                   return null;
// //                 },
// //                 onChanged: (value) {
// //                   rules[index] = value;
// //                 },
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           if (_formKey.currentState?.validate() ?? false) {
// //             _saveRules();
// //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Rules saved')));
// //           }
// //         },
// //         child: Icon(Icons.save),
// //       ),
// //       persistentFooterButtons: [
// //         TextButton(
// //           onPressed: _addRule,
// //           child: Text('Add Rule'),
// //         ),
// //       ],
// //     );
// //   }
// // }








































// import 'dart:convert';
// import 'dart:math';
// import 'package:cloneapp/pages/customerpage.dart';
// import 'package:cloneapp/pages/home.dart';
// import 'package:cloneapp/pages/invoiceadd.dart';
// import 'package:cloneapp/pages/subpages/settings/applock.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';



// class Invoicedraft extends StatefulWidget {
//   final String invoiceId;
  

//   const Invoicedraft({Key? key, required this.invoiceId}) : super(key: key);

//   @override
//   State<Invoicedraft> createState() => _InvoicedraftState();
// }

// class _InvoicedraftState extends State<Invoicedraft> {
//   bool _showDetails = false; 
//   final currentuser = FirebaseAuth.instance.currentUser;
  

//   Map<String, dynamic>? invoiceData;
//    List<Map<String, dynamic>> paymentHistory = [];
//    double totalReceived = 0 ; 

//   @override
//   void initState() {
//     super.initState();
//     fetchInvoiceData();
//   }

//   Future<void> fetchInvoiceData() async {
//     try {
//       DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentuser!.uid)
//           .collection('invoices')
//           .doc(widget.invoiceId)
//           .get();

//       if (invoiceSnapshot.exists) {
//         setState(() {
//           invoiceData = invoiceSnapshot.data() as Map<String, dynamic>;
//            });
//       }
//     } catch (e) {
//       print("Error fetching invoice data: $e");
//     }
//   }
  
//   @override
//   Widget build(BuildContext context) {
//      bool isPaid = invoiceData!['status'];
//     String statusText = isPaid ? 'PAID' : 'UNPAID';
//     Color statusColor = isPaid ? Colors.green : Colors.red;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Invoice Draft"),
//         actions: [
//           IconButton(
//           onPressed: fetchInvoiceData,
//           icon: const Icon(Icons.refresh),
//         ),
//            PopupMenuButton<String>(
//             icon: const Icon(Icons.more_vert, color: Colors.black),
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//               // Menu items
//           const    PopupMenuItem<String>(
//                 value: 'customer',
//                 child: ListTile(
//                   leading: Icon(Icons.person_add),
//                   title: Text('New Customer'),
//                 ),
//               ),
//          const    PopupMenuItem<String>(
//                 value: 'invoice',
//                 child: ListTile(
//                   leading: Icon(Icons.add),
//                   title: Text('New Invoice'),
//                 ),
//               ),
              
//            const    PopupMenuItem<String>(
//                 value: 'proceed_payment',
//                 child: ListTile(
//                   leading: Icon(Icons.payment),
//                   title: Text('Get Invoice'),
//                 ),
//               ),
//            const  PopupMenuItem<String>(
//                 value: 'edit',
//                 child: ListTile(
//                   leading: Icon(Icons.edit),
//                   title: Text('edit invoice'),
//                 ),
//               ),
                  
//            const    PopupMenuItem<String>(
//                 value: 'edit_customer',
//                 child: ListTile(
//                   leading: Icon(Icons.edit_document),
//                   title: Text('Edit Customer'),
//                 ),
//               ),
//             ],
//             onSelected: (String value) {
//               // Handle menu item selection
//               switch (value) {
//                 case 'customer':
//                   // Navigate to customer screen or perform related action
//                   Navigator.pushNamed(context, '/customer');
//                   break;

//                 case 'invoice':
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => InvoiceAdd(customerID: invoiceData!['customerID'],)
//                   ),   
//                   );
//                   break;
//                 case 'edit':
//                   // Add new invoice action
//               //     Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) => InvoiceEdit(
//               //       invoiceId: widget.invoiceId,
//               //       customerID: invoiceData!['customerID'],
//               //     ),
//               //   ),
//               // );
//                   break;
//                  case 'edit_customer':
//               // Add new invoice action
//               //   Navigator.push(
//               //     context,
//               //     MaterialPageRoute(
//               //       builder: (context) => Customeredit( customerData: invoiceData, ),
//               //     ),
//               // );
//                   break;
//                 case 'proceed_payment':
//                   // Proceed to payment action
//                    Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => PreviewBill(invoiceId: widget.invoiceId,)
//                   ), 
//               );
//                   break;
//                 default:
//               }
//             },
//           ),
//         ],
//       ),
//       drawer: drawer(context),
// body: 
// invoiceData == null
//     ? const Center(child: CircularProgressIndicator())
//     : DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Invoice ID: ${widget.invoiceId}',
//                       style: const TextStyle(
//                           fontSize: 21, fontWeight: FontWeight.bold),
//                     ),
//                     _buildDetailItem(
//                       'Invoice Date',
//                       DateFormat('dd-MM-yyyy').format(
//                           (invoiceData!['invoiceDate'] as Timestamp)
//                               .toDate()),
//                     ),
//                     Text(
//                       invoiceData!['customerName'],
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     const SizedBox(height: 25),
//                     Text(
//                       'Balance : ${invoiceData!["totalBill"]}',
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       statusText,
//                       style: TextStyle(
//                           color: statusColor,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Container(
//                 constraints: const BoxConstraints.expand(height: 50),
//                 decoration: const BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: const TabBar(
//                   labelColor: Colors.white,
//                   unselectedLabelColor: Colors.white,
//                   indicatorColor: Colors.white,
//                   tabs: [
//                     Tab(
//                       child: Text(
//                         'Details',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         'Payment',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         'History',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     // Details Tab
//                     SingleChildScrollView(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               _buildDetailItem('Customer Name',
//                                   invoiceData!['customerName'] ?? ''),
//                               const SizedBox(width: 10),
//                               IconButton(
//                                 icon: Icon(_showDetails
//                                     ? Icons.arrow_drop_up
//                                     : Icons.arrow_drop_down),
//                                 onPressed: () {
//                                   setState(() {
//                                     _showDetails =
//                                         !_showDetails; // Toggle details visibility
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                           Visibility(
//                             visible: _showDetails,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 _buildDetailItem('Customer Address',
//                                     invoiceData!['customerAddress'] ?? ''),
//                                 _buildDetailItem('Customer Email',
//                                     invoiceData!['customerEmail'] ?? ''),
//                                     _buildDetailItem('Work Phone',
//                                     invoiceData!['workphone'] ?? ''),
//                                 _buildDetailItem('Mobile',
//                                     invoiceData!['mobile'] ?? ''),
//                               ],
//                             ),
//                           ),
//                           // if (invoiceData!['dueDate'] != null)
//                           //   _buildDetailItem(
//                           //     'Due Date',
//                           //     DateFormat('dd-MM-yyyy').format(
//                           //         (invoiceData!['dueDate'] as Timestamp)
//                           //             .toDate()),
//                           //   ),
//                           const Divider(thickness: 1, color: Colors.grey),
//                           const Text(
//                             'Items:',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 8),
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: (invoiceData!['items'] as List).length,
//                             itemBuilder: (context, index) {
//                               Map<String, dynamic> item =
//                                   (invoiceData!['items'] as List)[index];
//                               return ListTile(
//                                 title: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       flex: 1,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             item['itemName'],
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 15),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             '${item['quantity']} X ${item['rate']}',
//                                             style: const TextStyle(
//                                                 fontSize: 15),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             '${item['price'].toStringAsFixed(2)}',
//                                             style: const TextStyle(
//                                                 fontSize: 15),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                           const Divider(thickness: 1, color: Colors.grey),
//                           _buildDetailItemForDouble('SubTotal',
//                               invoiceData!['total amount'] ?? 0.0),
//                           _buildDetailItemFor('Discount %',
//                               invoiceData!['discount'] ?? 0.0),
//                           _buildDetailItemFor('Tax %',
//                               invoiceData!['tax'] ?? 0.0),
//                           _buildDetailItemForDouble('Total',
//                               invoiceData!['totalBill'] ?? 0.0),
//                          _buildDetailItemFor('Due' , invoiceData!['total amount'])
//                               ,
//                               const SizedBox(height: 20,)

//                             ,  ],
//                       ),
//                     ),
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Text("data")
//                         ],
//                       ),
//                     ),
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Text("data")
//                         ],
//                       ),
//                     )
//                      ]   ),
//               )
          
//                   ],
//                 ),
//               ),
//           ),
//         );
//   }

// Widget _buildDetailItem(String label, String value) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         value,
//         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//     ],
//   );
// }

// Widget _buildDetailItemForDouble(String title, double value) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 2),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Expanded(
//           flex: 2,
//           child: Text(
//             title,
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 15),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Text(
//             value.toStringAsFixed(2),
//             style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildDetailItemFor(String title, double value) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 2),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Expanded(
//           flex: 2,
//           child: Text(
//             title,
//             style: const TextStyle(fontSize: 15),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Text(
//             value.toStringAsFixed(2),
//             style: const TextStyle(
//               fontSize: 15,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//   }
//   Widget _buildDetailItem(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//        Text(value , style:  const TextStyle( fontSize: 20 , fontWeight: FontWeight.bold),)
//       ],
//     );
//   }
  


import 'dart:convert';
import 'dart:math';
import 'package:cloneapp/pages/customerpage.dart';
import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/invoiceadd.dart';
import 'package:cloneapp/pages/subpages/settings/applock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';



class Invoicedraft extends StatefulWidget {
  final String invoiceId;

  const Invoicedraft({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<Invoicedraft> createState() => _InvoicedraftState();
}

class _InvoicedraftState extends State<Invoicedraft> {
   bool _showDetails = false;
  final currentuser = FirebaseAuth.instance.currentUser;
  final TextEditingController paymentReceivedController = TextEditingController();
  final TextEditingController paymentDueController = TextEditingController();

  Map<String, dynamic>? invoiceData;
  List<Map<String, dynamic>> paymentHistory = [];
  double totalReceived = 0;

  @override
  void initState() {
    super.initState();
    fetchInvoiceData();
    paymentReceivedController.addListener(_updatePaymentDue); // Added listener
  }

  @override
  void dispose() {
    paymentReceivedController.dispose();
    paymentDueController.dispose();
    super.dispose();
  }

  void _updatePaymentDue() {
    if (invoiceData != null && invoiceData!['totalBill'] != null) {
      double totalBill = invoiceData!['totalBill'];
      double received = double.tryParse(paymentReceivedController.text) ?? 0.0;
      double totalReceived = paymentHistory.fold(0, (sum, payment) => sum + payment['amount']);
      double dues = totalBill - (totalReceived + received);
      paymentDueController.text = dues.toStringAsFixed(2);
    }
  }

  Future<void> fetchInvoiceData() async {
    try {
      DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentuser!.uid)
          .collection('invoices')
          .doc(widget.invoiceId)
          .get();

      if (invoiceSnapshot.exists) {
        setState(() {
          invoiceData = invoiceSnapshot.data() as Map<String, dynamic>;
          paymentHistory = List<Map<String, dynamic>>.from(invoiceData!['paymentHistory'] ?? []);
          _updatePaymentDue(); // Update due when fetching data
        });
      }
    } catch (e) {
      print("Error fetching invoice data: $e");
    }
  }

  void updatePaymentDetails() async {
    double paymentReceived = double.tryParse(paymentReceivedController.text) ?? 0.0;
    double paymentDues = double.tryParse(paymentDueController.text) ?? 0.0;

    // Add the new payment to the payment history
    Map<String, dynamic> newPayment = {
      'amount': paymentReceived,
      'date': Timestamp.now(),
      'due':paymentDues
    };
    paymentHistory.add(newPayment);

    // Recalculate total received and due amounts
    totalReceived = paymentHistory.fold(0, (sum, payment) => sum + payment['amount']);
    double totalBill = invoiceData!['totalBill'];
    double paymentDue = totalBill - totalReceived;

    try {
      // Reference to the user's collection of invoices
      DocumentReference invoiceRef = FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentuser!.uid) // Replace with your current user ID logic
          .collection('invoices')
          .doc(widget.invoiceId);

      // Update the document
      await invoiceRef.update({
        'paymentReceived': totalReceived,
        'paymentDue': paymentDue,
        'paymentHistory': paymentHistory,
      });

      setState(() {
        paymentDueController.text = paymentDue.toStringAsFixed(2);
      });

      print('Payment details updated successfully!');
    } catch (e) {
      print('Error updating payment details: $e');
      // Handle error as needed
    }
  }
    Future<void> _makePhoneCall() async {
    // dynamic mobile = invoiceData!['mobile'];

    // if (mobile is int) {
    //   String phoneNumber = mobile.toString();
    //   String url = 'tel:$phoneNumber';
    //   await _launchURL(url);
    // }
    // if (mobile is String) {
      
    //   String url = 'tel:$mobile';
    //   await _launchURL(url);
    // }
    //  else {
    //   throw 'Phone number not available';
    // }
  }

  Future<void> _sendMessage() async {
    // dynamic mobile = invoiceData!['mobile'];

    // if (mobile is int) {
    //   String phoneNumber = mobile.toString();
    //   String url = 'sms:$phoneNumber';
    //   await _launchURL(url);
    // } else if (mobile is String) {
    //   String url = 'sms:$mobile';
    //   await _launchURL(url);
    // } else {
    //   throw 'Mobile number is not available or not valid';
    // }
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    bool isPaid = invoiceData?['status'] ?? false;
    String statusText = isPaid ? 'PAID' : 'UNPAID';
    Color statusColor = isPaid ? Colors.green : Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Draft"),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              _makePhoneCall();
            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              _sendMessage();
            },
          ),
          IconButton(
            onPressed: fetchInvoiceData,
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'customer',
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('New Customer'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'invoice',
                child: ListTile(
                  leading: Icon(Icons.add),
                  title: Text('New Invoice'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'proceed_payment',
                child: ListTile(
                  leading: Icon(Icons.payment),
                  title: Text('Get Invoice'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('edit invoice'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'edit_customer',
                child: ListTile(
                  leading: Icon(Icons.edit_document),
                  title: Text('Edit Customer'),
                ),
              ),
            ],
            onSelected: (String value) {
              switch (value) {
                case 'customer':
                  Navigator.pushNamed(context, '/customer');
                  break;
                case 'invoice':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoiceAdd(
                        customerID: invoiceData!['customerID'],
                      ),
                    ),
                  );
                  break;
                case 'edit':
                   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InvoiceEdit(
                    invoiceId: widget.invoiceId,
                    customerID: invoiceData!['customerID'],
                  ),
                ),
              );

                  break;
                case 'edit_customer':
                  // Add new invoice action
                  break;
                case 'proceed_payment':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewBill(
                        invoiceId: widget.invoiceId,
                      ),
                    ),
                  );
                  break;
                default:
              }
            },
          ),
        ],
      ),
      drawer: drawer(context),
      body: invoiceData == null
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 3,
              child: 
              Scaffold(
                body: 
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invoice ID: ${widget.invoiceId}',
                            style: const TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy').format(
                                (invoiceData!['invoiceDate'] as Timestamp)
                                    .toDate()),
                          ),
                          Text(
                            invoiceData!['customerName'],
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'Balance : ${invoiceData?['paymentDue']}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            statusText,
                            style: TextStyle(
                                color: statusColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      // constraints: const BoxConstraints.expand(height: 50),
                      margin: EdgeInsets.only(left: 0),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                      ),
                      // child: SingleChildScrollView(
                        
                      //   scrollDirection: Axis.horizontal,
                        child: const TabBar(
                          
                          // isScrollable: true,
                          // labelColor: Colors.white,
                          // unselectedLabelColor: Colors.white,
                          // indicatorColor: Colors.white,
                          tabs: [
                            Tab(
                              child: Text(
                                'Details',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Payment',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'History',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            // Tab(
                            //   child: Text(
                            //     'Terms',
                            //     style: TextStyle(
                            //         fontSize: 20,
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _buildDetailItem('Customer Name',
                                        invoiceData!['customerName'] ?? ''),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      icon: Icon(_showDetails
                                          ? Icons.arrow_drop_up
                                          : Icons.arrow_drop_down),
                                      onPressed: () {
                                        setState(() {
                                          _showDetails =
                                              !_showDetails;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: _showDetails,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildDetailItem('Customer Address',
                                          invoiceData!['customerAddress'] ?? ''),
                                      _buildDetailItem('Customer Email',
                                          invoiceData!['customerEmail'] ?? ''),
                                      _buildDetailItem('Work Phone',
                                          invoiceData!['workphone'] ?? ''),
                                      _buildDetailItem('Mobile',
                                          invoiceData!['mobile'] ?? ''),
                                    ],
                                  ),
                                ),
                                const Divider(thickness: 1, color: Colors.grey),
                                const Text(
                                  'Items:',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemCount: (invoiceData!['items'] as List)
                                      .length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> item =
                                        (invoiceData!['items'] as List)[index];
                                    return ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item['itemName'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${item['quantity']} X ${item['rate']}',
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${item['amount']}',
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const Divider(thickness: 1, color: Colors.grey),
             _buildDetailItemForDouble('SubTotal', invoiceData?['total amount'] ?? 0.0),
            _buildDetailItemFor('Discount %', invoiceData?['discount'] ?? 0.0),
            _buildDetailItemFor('Tax %', invoiceData?['tax'] ?? 0.0),
            _buildDetailItemForDouble('Total', invoiceData?['totalBill'] ?? 0.0),
Text('Due  ${invoiceData?['paymentDue']} '),
const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
                                TextFormField(
                                  controller: paymentReceivedController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Payment Received',
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _updatePaymentDue();
                                    });
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: paymentDueController,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Payment Due',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: updatePaymentDetails,
                                  child: const Text('Update Payment Details'),
                                ),
                              ],
    ),
  ),
),
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                const SizedBox(height: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: paymentHistory.length,
                                  itemBuilder: (context, index) {
                                    final payment = paymentHistory[index];
                                    return ListTile(
                                       leading: Transform.rotate(
                                       angle: 2.25, // Adjust this value to get the slanted angle you want
                                        child: Icon(Icons.arrow_forward),
                                  ),
                                      title: Text(
                                          'Amount: ${payment['amount']}'),
                                      subtitle: Text(
                                          'Date: ${DateFormat('dd-MM-yyyy').format((payment['date'] as Timestamp).toDate())}\nDue: ${payment['due']}'),
                                    );
                                  },
                                
                                ),
                                const Divider(thickness: 2,)
                              ],
                            ),
                          ),
                          // Center(
                          //   child: Text("terms"),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
Widget _buildDetailItemForDouble(String title, double value) {
  return Padding(
    padding: const EdgeInsets.only(top: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value.toStringAsFixed(2),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDetailItemFor(String title, double value) {
  return Padding(
    padding: const EdgeInsets.only(top: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
  );
}


class InvoiceEdit extends StatefulWidget {
  final String invoiceId;
  final String customerID;

  const InvoiceEdit({Key? key, required this.invoiceId, required this.customerID}) : super(key: key);

  @override
  _InvoiceEditState createState() => _InvoiceEditState();
}

class _InvoiceEditState extends State<InvoiceEdit> {
  String _invoiceId = '';
  DateTime? _invoiceDate;
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

  @override
  void initState() {
    super.initState();
    _fetchInvoiceDetails();
  }

  Future<void> _fetchInvoiceDetails() async {
    try {
      DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentuser!.uid)
          .collection('invoices')
          .doc(widget.invoiceId)
          .get();

      if (invoiceSnapshot.exists) {
        setState(() {
          _invoiceId = widget.invoiceId;
          _invoiceDate = invoiceSnapshot['invoiceDate'] != null
              ? (invoiceSnapshot['invoiceDate'] as Timestamp).toDate()
              : null;
          // _selectedDate = invoiceSnapshot['dueDate'] != null
          //     ? (invoiceSnapshot['dueDate'] as Timestamp).toDate()
          //     : null;
          _paymentMethod = invoiceSnapshot['paymentMethod'];
          _selectedItems = List<Map<String, dynamic>>.from(invoiceSnapshot['items']);
          _customerName = invoiceSnapshot['customerName'];
          _customerAddress = invoiceSnapshot['customerAddress'];
          _customerEmail = invoiceSnapshot['customerEmail'];
          _customerWorkPhone = invoiceSnapshot['workphone'];
          _customerMobile = invoiceSnapshot['mobile'];
          _customerid = invoiceSnapshot['customerID'];
        });
      }
    } catch (e) {
      print("Error fetching invoice details: $e");
    }
  }

  // Future<void> _selectDueDate() async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate ?? DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  //   }
  // }

  void _addItems() async {
    final Map<String, dynamic>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddItems()), // Replace with your AddItems page
    );
    if (result != null) {
      setState(() {
        _selectedItems.add(result);
      });
    }
  }

  Future<void> _saveChanges() async {
    try {
      // Construct updated invoice data
      Map<String, dynamic> updatedInvoice = {
        "customerName": _customerName,
        "customerAddress": _customerAddress,
        "customerEmail": _customerEmail,
        "customerID": _customerid,
        "workphone": _customerWorkPhone,
        "mobile": _customerMobile,
        "invoiceId": _invoiceId,
        "invoiceDate": _invoiceDate != null ? Timestamp.fromDate(_invoiceDate!) : null,
        "paymentMethod": _paymentMethod,
        // "dueDate": _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
        "items": _selectedItems,
        "status": false, // Example status, update as needed
      };

      // Update invoice data in Firestore
      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("invoices")
          .doc(_invoiceId)
          .update(updatedInvoice);

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Invoice updated successfully'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                 // Pop InvoiceEdit screen
              },
            ),
          ],
        ),
      );
    } catch (e) {
      print("Error saving changes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Invoice"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invoice ID: $_invoiceId'),
              const SizedBox(height: 16),
              Text('Invoice Date: ${_invoiceDate != null ? DateFormat('dd-MM-yyyy').format(_invoiceDate!) : ''}'),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Due Date:'),
                  const SizedBox(width: 16),
                  GestureDetector(
                    // onTap: _selectDueDate,
                    child: Text(
                      _selectedDate == null
                          ? 'Select Due Date'
                          : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select Payment Method',
                ),
                items: _paymentMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text('Customer Name: ${_customerName ?? ''}'),
              Text('Customer Address: ${_customerAddress ?? ''}'),
              Text('Customer Email: ${_customerEmail ?? ''}'),
              Text('Work Phone: ${_customerWorkPhone ?? ''}'),
              Text('Mobile: ${_customerMobile ?? ''}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addItems,
                child: const Text('Add Items'),
              ),
              if (_selectedItems.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Selected Items:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _selectedItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_selectedItems[index]['itemName']),
                      subtitle: Text('Quantity: ${_selectedItems[index]['quantity']}'),
                      trailing: Text('Price: ${_selectedItems[index]['price'].toStringAsFixed(2)}'
                                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text('Save Changes'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  void successdialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Invoice saved successfully'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
               
              },
            ),
          ],
        ),
      );
  }
}
