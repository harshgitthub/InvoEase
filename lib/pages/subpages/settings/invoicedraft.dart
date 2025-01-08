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


// class Invoicedraft extends StatefulWidget {
//   final String invoiceId;

//   const Invoicedraft({Key? key, required this.invoiceId}) : super(key: key);

//   @override
//   State<Invoicedraft> createState() => _InvoicedraftState();
// }

// class _InvoicedraftState extends State<Invoicedraft> {
//    bool _showDetails = false;
//   final currentuser = FirebaseAuth.instance.currentUser;
//   Map<String, dynamic>? invoiceData;
//   final TextEditingController paymentReceivedController = TextEditingController();
//   final TextEditingController paymentDueController = TextEditingController();

//   List<Map<String, dynamic>> paymentHistory = [];
//   double totalReceived = 0;
//   String? _paymentMethod;
//   String? errorMessage;
//   final List<String> _paymentMethods = [
//     'Cash',
//     'Online',
//     'Cheque',
//     'Debit/Credit Card'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     fetchInvoiceData();
//     paymentReceivedController.addListener(_updatePaymentDue);
//   }

//   @override
//   void dispose() {
//     paymentReceivedController.dispose();
//     paymentDueController.dispose();
//     super.dispose();
//   }

//   void _updatePaymentDue() {
//     if (invoiceData != null && invoiceData!['totalBill'] != null) {
//       double totalBill = invoiceData!['totalBill'];
//       double received = double.tryParse(paymentReceivedController.text) ?? 0.0;
//       double paymentDue = invoiceData!['totalBill'];
// setState(() {
//       paymentDue = totalBill - received; // Example logic
//       isreadonly = paymentDue == 0 ;
//     });
//       // Ensure received payment does not exceed the total bill
      // if (received > totalBill) {
      //   setState(() {
      //     errorMessage = "Payment received cannot exceed the total bill.";
      //   });
      //   received = totalBill;
      //   paymentReceivedController.text = received.toStringAsFixed(2);
      // } else {
      //   setState(() {
      //     errorMessage = null;
      //   });
      // }

      // double totalReceived = paymentHistory.fold(0, (sum, payment) => sum + payment['amount']);
      // double dues = totalBill - (totalReceived + received);

      // // Ensure payment due is always positive
      // if (dues < 0) dues = 0;

//       paymentDueController.text = dues.toStringAsFixed(2);
//     }
//   }

//   void redue() {
//     paymentReceivedController.clear();
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
//           paymentHistory = List<Map<String, dynamic>>.from(invoiceData!['paymentHistory'] ?? []);
//           _updatePaymentDue(); // Update due when fetching data
//           updatePaymentDetails();
//           if (invoiceData != null && invoiceData!['paymentDue'] == 0) {
//             updateInvoiceStatus(true);
//           }
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error fetching invoice data: $e";
//       });
//     }
//   }
// bool isreadonly = false; // Initial condition

  
//   void updateInvoiceStatus(bool status) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("invoices")
//           .doc(widget.invoiceId)
//           .update({'status': status});
//       setState(() {
//         invoiceData!['status'] = status;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error updating invoice status: $e";
//       });
//     }
//   }

//   void updatePaymentDetails() async {
//     double paymentReceived = double.tryParse(paymentReceivedController.text) ?? 0.0;
//     double paymentDues = double.tryParse(paymentDueController.text) ?? 0.0;

//     // Ensure payments are positive
//     if (paymentReceived < 0) paymentReceived = 0;
//     if (paymentDues < 0) paymentDues = 0;

//     // Add the new payment to the payment history
//     Map<String, dynamic> newPayment = {
//       'amount': paymentReceived,
//       'date': Timestamp.now(),
//       'due': paymentDues,
//     };
//     paymentHistory.add(newPayment);

//     // Recalculate total received and due amounts
//     totalReceived = paymentHistory.fold(0, (sum, payment) => sum + payment['amount']);
//     double totalBill = invoiceData!['totalBill'];
//     double paymentDue = totalBill - totalReceived;

//     // Ensure payment due is always positive
//     if (paymentDue < 0) paymentDue = 0;

//     try {
//       // Reference to the user's collection of invoices
//       DocumentReference invoiceRef = FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentuser!.uid)
//           .collection('invoices')
//           .doc(widget.invoiceId);

//       // Update the document
//       await invoiceRef.update({
//         'paymentReceived': totalReceived,
//         'paymentDue': paymentDue,
//         'paymentHistory': paymentHistory,
//       });

//       setState(() {
//         paymentDueController.text = paymentDue.toStringAsFixed(2);
//       });

//       print('Payment details updated successfully!');
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error updating payment details: $e";
//       });
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     bool isInvoicePaid = invoiceData?['status'] ?? false;
//     String statusText = isInvoicePaid ? 'PAID' : 'UNPAID';
//     Color statusColor = isInvoicePaid ? Colors.green : Colors.red;
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Invoice Draft"),
//         actions: [
//          StreamBuilder<DocumentSnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection("USERS")
//                 .doc(currentuser!.uid)
//                 .collection("customers")
//                 .doc(invoiceData!["customerID"]) // Replace with actual customer document ID
//                 .snapshots(),
//         builder: (context, snapshot) {
           
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (snapshot.hasError) {
//                 return const Center(child: Text("Error fetching data"));
//               }

//               if (!snapshot.hasData || !snapshot.data!.exists) {
//                 return const Center(child: Text("No customers found"));
//               }

//               DocumentSnapshot customerData = snapshot.data!;

//         return Row(
//                 children: [
        
//           IconButton(
//             onPressed: fetchInvoiceData,
//             icon: const Icon(Icons.refresh),
//           ),
//           IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: () async {
//                 // Perform delete operation
//                 await FirebaseFirestore.instance
//                     .collection("USERS")
//                     .doc(currentuser!.uid)
//                     .collection("invoices")
//                     .doc(widget.invoiceId)
//                     .delete();
//                 Navigator.of(context).pop(); // Close dialog
//                 // Optionally show a confirmation Snackbar or Toast
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     backgroundColor: Colors.green,
//                     content: Text("Invoice deleted successfully"),
//                   ),
//                 );
//               },
//             ),
//           PopupMenuButton<String>(
//             icon: const Icon(Icons.more_vert, color: Colors.black),
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//               const PopupMenuItem<String>(
//                 value: 'customer',
//                 child: ListTile(
//                   leading: Icon(Icons.person_add),
//                   title: Text('New Customer'),
//                 ),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'invoice',
//                 child: ListTile(
//                   leading: Icon(Icons.add),
//                   title: Text('New Invoice'),
//                 ),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'proceed_payment',
//                 child: ListTile(
//                   leading: Icon(Icons.payment),
//                   title: Text('Preview'),
//                 ),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'edit',
//                 child: ListTile(
//                   leading: Icon(Icons.edit),
//                   title: Text('edit invoice'),
//                 ),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'edit_customer',
//                 child: ListTile(
//                   leading: Icon(Icons.edit_document),
//                   title: Text('Edit Customer'),
//                 ),
//               ),
//             ],
//             onSelected: (String value) {
//               switch (value) {
//                 case 'customer':
//                   Navigator.pushNamed(context, '/customer');
//                   break;
//                 case 'invoice':
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => InvoiceAdd(
//                         customerID: invoiceData!['customerID'],
//                       ),
//                     ),
//                   );
//                   break;
//                 case 'edit':
//               //      Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) => InvoiceEdit(
//               //       invoiceId: widget.invoiceId,
//               //       customerID: invoiceData!['customerID'],
//               //     ),
//               //   ),
//               // );
//                   break;
//                 case 'edit_customer':
//                   Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Customeredit(customerData: customerData))
//               );
//                   break;
//                 case 'proceed_payment':
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PreviewBill(
//                         invoiceId: widget.invoiceId,
//                       ),
//                     ),
//                   );
//                   break;
//                 default:
//               }
//             },
//           )
//                 ]);
//         }
//           ),
//         ],
//       ),
//       drawer: drawer(context),
//       body: invoiceData == null
//           ? const Center(child: CircularProgressIndicator())
//           : DefaultTabController(
//               length: 3,
//               child: 
//               Scaffold(
//                 body: 
//                  Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Invoice ID: ${widget.invoiceId}',
//                             style: const TextStyle(
//                                 fontSize: 21, fontWeight: FontWeight.bold),
//                           ),
                           
//                           Text(
//                             DateFormat('dd-MM-yyyy').format(
//                                 (invoiceData!['invoiceDate'] as Timestamp)
//                                     .toDate()),
//                           ),
//                           Text(
//                             invoiceData!['customerName'],
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           const SizedBox(height: 25),
//                           Text(
//                             'Balance : ${invoiceData?['paymentDue']}',
//                             style: const TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             statusText,
//                             style: TextStyle(
//                                 color: statusColor,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 30),
                    // Container(
                  
                    //   margin: const EdgeInsets.only(left: 0),
                    //   decoration: const BoxDecoration(
                    //     color: Colors.blue,
                    //   ),
                    
                    //     child: const TabBar(
                          
                        
                    //       tabs: [
                    //         Tab(
                    //           child: Text(
                    //             'Invoice',
                    //             style: TextStyle(
                    //                 fontSize: 20,
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //         ),
                    //         Tab(
                    //           child: Text(
                    //             'Payment',
                    //             style: TextStyle(
                    //                 fontSize: 20,
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //         ),
                    //         Tab(
                    //           child: Text(
                    //             'History',
                    //             style: TextStyle(
                    //                 fontSize: 20,
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //         ),
                           
                    //       ],
                    //     ),
                    //   ),
                    
//                     Expanded(
//                       child: TabBarView(
//                         children: [
//                           SingleChildScrollView(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     _buildDetailItem('Customer Name',
//                                         invoiceData!['customerName'] ?? ''),
//                                     const SizedBox(width: 10),
//                                     IconButton(
//                                       icon: Icon(_showDetails
//                                           ? Icons.arrow_drop_up
//                                           : Icons.arrow_drop_down),
//                                       onPressed: () {
//                                         setState(() {
//                                           _showDetails =
//                                               !_showDetails;
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                                 Visibility(
//                                   visible: _showDetails,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       _buildDetailItem('Customer Address',
//                                           invoiceData!['customerAddress'] ?? ''),
//                                       _buildDetailItem('Customer Email',
//                                           invoiceData!['customerEmail'] ?? ''),
//                                       _buildDetailItem('Work Phone',
//                                           invoiceData!['workphone'] ?? ''),
//                                       _buildDetailItem('Mobile',
//                                           invoiceData!['mobile'] ?? ''),
//                                     ],
//                                   ),
//                                 ),
//                                 const Divider(thickness: 1, color: Colors.grey),
//                                 const Text(
//                                   'Items:',
//                                   style: TextStyle(
//                                       fontSize: 20, fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 ListView.builder(
//                                   shrinkWrap: true,
//                                   physics:
//                                       const NeverScrollableScrollPhysics(),
//                                   itemCount: (invoiceData!['items'] as List)
//                                       .length,
//                                   itemBuilder: (context, index) {
//                                     Map<String, dynamic> item =
//                                         (invoiceData!['items'] as List)[index];
//                                     return ListTile(
//                                       title: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           Expanded(
//                                             flex: 1,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   item['itemName'],
//                                                   style: const TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       fontSize: 15),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.end,
//                                               children: [
//                                                 Text(
//                                                   '${item['quantity']} X ${item['rate']}',
//                                                   style: const TextStyle(
//                                                       fontSize: 15),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.end,
//                                               children: [
//                                                 Text(
//                                                   '${item['price']}',
//                                                   style: const TextStyle(
//                                                       fontSize: 15),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 const Divider(thickness: 1, color: Colors.grey),
//              _buildDetailItemForDouble('SubTotal', invoiceData?['total amount'] ?? 0.0),
//             _buildDetailItemFor('Discount %', invoiceData?['discount'] ?? 0.0),
//             _buildDetailItemFor('Tax %', invoiceData?['tax'] ?? 0.0),
//             _buildDetailItemForDouble('Total', invoiceData?['totalBill'] ?? 0.0),
// // Text('Due  ${invoiceData?['paymentDue']} '),
// const SizedBox(height: 20),
//                               ],
//                             ),
//                           ),

//  SingleChildScrollView(

//     child: Column(
   
//       children: [
//         const SizedBox(height: 50,),
        
// const Text("Payment Due"),
//  TextField(
//   controller: paymentDueController,
//   readOnly: true,
//   showCursor: false,
//   keyboardType: TextInputType.none,
//   decoration: InputDecoration(
//     hintText: 'Payment Due',
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.blue,
//         width: 2.0,
//       ),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.grey,
//         width: 1.0,
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.blue,
//         width: 2.0,
//       ),
//     ),
//     filled: true,
//     fillColor: Colors.white,
//     contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
//   ),
// ),
// const Text("Payment Received"),

// TextFormField(
  
//   readOnly: isreadonly,
//   controller: paymentReceivedController,
//   keyboardType: TextInputType.number,
//   decoration: InputDecoration(
//     hintText: 'Amount',
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.blue,
//         width: 2.0,
//       ),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.grey,
//         width: 1.0,
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.blue,
//         width: 2.0,
//       ),
//     ),
//     filled: true,
//     fillColor: Colors.white,
//     contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
//   ),
//   onChanged: (value) {
//     setState(() {
//       _updatePaymentDue();
//     });
//   },
// ),const SizedBox(height: 10,),
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     const Padding(padding: EdgeInsets.only(left: 10)),
//   const Expanded(flex: 2,
  
//     child: Text("Payment Mode"))
//   ,
//   Expanded(flex: 3,
//     child: 
  
// DropdownButton<String>(
//           value: _paymentMethod,
//           onChanged: (String? newValue) {
//             setState(() {
//               _paymentMethod = newValue!;
//             });
//           },
//           items: _paymentMethods.map<DropdownMenuItem<String>>((String value) {
//             return 
//              DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//   )
  
// ]
// ),

//   const SizedBox(height: 10,),
//   Row(
//     children: [
//       Expanded(flex: 1,
//         child: ElevatedButton(
//                     onPressed: () {
//                 if (paymentReceivedController.text.isEmpty) {
//                   setState(() {
//                     errorMessage = "Please enter a payment received amount.";
//                   });
//                 } else {
//                   updatePaymentDetails();
//                 }
//               },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10 ),
                        
//                       ),
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Text(
//                       'Save',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ), ),
                  
//                  Expanded(flex: 1,
//         child: ElevatedButton(
//                      onPressed: redue,
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
                        
//                       ),
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Text(
//                       'Clear',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ), )
//     ],
//   )

                                
//                               ],
    
//   ),
// ),
//                           SingleChildScrollView(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
                                
//                                 const SizedBox(height: 10),
//                                 ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: paymentHistory.length,
//                                   itemBuilder: (context, index) {
//                                     final payment = paymentHistory[index];
//                                     return ListTile(
//                                        leading: Transform.rotate(
//                                        angle: 2.25, // Adjust this value to get the slanted angle you want
//                                         child: const Icon(Icons.arrow_forward),
//                                   ),
//                                       title: Text(
//                                           'Amount: ${payment['amount']}'),
//                                       subtitle: Text(
//                                           'Date: ${DateFormat('dd-MM-yyyy').format((payment['date'] as Timestamp).toDate())}\nDue: ${payment['due']}'),
//                                     );
//                                   },
                                
//                                 ),
//                                 const Divider(thickness: 2,)
//                               ],
//                             ),
//                           ),
//                           // Center(
//                           //   child: Text("terms"),
//                           // )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget _buildDetailItem(String title, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 17),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: const TextStyle(fontSize: 16),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
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
//   final TextEditingController _taxController = TextEditingController();
//   final TextEditingController _discountController = TextEditingController();
//   double _tax = 0;
//   double _discount = 0;
//   double _totalBill = 0.0;
//   double _totalAmount = 0.0;

//   @override
//   void initState() {
//     _fetchCustomerDetails();
//     super.initState();
//     _fetchInvoiceDetails();
//     _calculateTotalAmount();
//     _calculateTotalBill(); // Initial calculation

//     // Add listener to tax controller
//     _taxController.addListener(_calculateTotalBill);
//     // Add listener to discount controller
//     _discountController.addListener(_calculateTotalBill);
//     _taxController.text = _tax.toString();
//     _discountController.text = _discount.toString();
//   }

//   void _fetchCustomerDetails() async {
//     try {
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentuser!.uid)
//           .collection('customers')
//           .doc(widget.customerID)
//           .get();

//       if (customerSnapshot.exists) {
//         setState(() {
//           String salutation = customerSnapshot['Salutation'] ?? ''; // Fetching salutation
//           String firstName = customerSnapshot['First Name'] ?? '';
//           String lastName = customerSnapshot['Last Name'] ?? '';
//           _customerName = '$salutation $firstName $lastName';
//           _customerAddress = customerSnapshot['Address'];
//           _customerEmail = customerSnapshot['Email'];
//           _customerWorkPhone = customerSnapshot['Work-phone'];
//           _customerMobile = customerSnapshot['Mobile'];
//           _customerid = customerSnapshot["customerID"];
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
//       MaterialPageRoute(builder: (context) => const AddItems()), // Replace with your AddItems page
//     );
//     if (result != null) {
//       setState(() {
//         _selectedItems.add(result);
//         _calculateTotalAmount();
//         _calculateTotalBill();
//       });
//     }
//   }

  

//   void _calculateTotalBill() {
//     _tax = double.tryParse(_taxController.text) ?? 0.0;
//     _discount = double.tryParse(_discountController.text) ?? 0.0;
//     double totalAmount = _totalAmount;

//     double taxAmount = totalAmount * (_tax / 100);
//     double discountAmount = totalAmount * (_discount / 100);

//     double totalBill = totalAmount + taxAmount - discountAmount;

//     setState(() {
//       _totalBill = totalBill;
//     });
//   }

//   @override
//   void dispose() {
//     _taxController.dispose();
//     _discountController.dispose();
//     super.dispose();
//   }

//   Future<void> _saveInvoice() async {
//     try {
//       Map<String, dynamic> invoice = {
//         "customerName": _customerName,
//         "customerAddress": _customerAddress,
//         "customerEmail": _customerEmail,
//         "customerID": widget.customerID,
//         "workphone": _customerWorkPhone,
//         "mobile": _customerMobile,
//         "invoiceId": _invoiceId,
//         "invoiceDate": Timestamp.fromDate(DateTime.now()),
//         "paymentMethod": _paymentMethod,
//         "dueDate": _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
//         "items": _selectedItems,
//         "total amount": _totalAmount,
//         "tax": _tax,
//         "discount": _discount,
//         "totalBill": _totalBill,
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

//   Future<void> _fetchInvoiceDetails() async {
//   try {
//     DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
//         .collection('USERS')
//         .doc(currentuser!.uid)
//         .collection('invoices')
//         .doc(widget.invoiceId)
//         .get();

//     if (invoiceSnapshot.exists) {
//       setState(() {
//         _invoiceId = widget.invoiceId;
//         _invoiceDate = invoiceSnapshot['invoiceDate'] != null
//             ? (invoiceSnapshot['invoiceDate'] as Timestamp).toDate()
//             : null;
//         _selectedDate = invoiceSnapshot['dueDate'] != null
//             ? (invoiceSnapshot['dueDate'] as Timestamp).toDate()
//             : null;
//         _paymentMethod = invoiceSnapshot['paymentMethod'];
//         _selectedItems = List<Map<String, dynamic>>.from(invoiceSnapshot['items']);
//         _customerName = invoiceSnapshot['customerName'];
//         _customerAddress = invoiceSnapshot['customerAddress'];
//         _customerEmail = invoiceSnapshot['customerEmail'];
//         _customerWorkPhone = invoiceSnapshot['workphone'];
//         _customerMobile = invoiceSnapshot['mobile'];
//         _customerid = invoiceSnapshot['customerID'];
//         _taxController.text = invoiceSnapshot['tax'].toString();
//         _discountController.text = invoiceSnapshot['discount'].toString();
//       });

//       // Calculate the total amount and total bill
//       _calculateTotalAmount();
//       _calculateTotalBill();
//     }
//   } catch (e) {
//     print("Error fetching invoice details: $e");
//   }
// }

// void _calculateTotalAmount() {
//   double total = 0.0;
//   for (var item in _selectedItems) {
//     double price = item['price'].toDouble();
//     total += price;
//   }
//   setState(() {
//     _totalAmount = total;
//     _calculateTotalBill(); // Ensure total bill is recalculated whenever total amount changes
//   });
// }


  
//   Future<void> _saveChanges() async {
//     try {
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
//         "dueDate": _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
//         "items": _selectedItems,
//         "total amount": _totalAmount,
//         "tax": _tax,
//         "discount": _discount,
//         "totalBill": _totalBill,
//         "status": false,
//       };

//       await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("invoices")
//           .doc(_invoiceId)
//           .update(updatedInvoice);

//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Success'),
//           content: const Text('Changes saved successfully'),
//           actions: <Widget>[
//            TextButton(
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
//         title: const Text('Edit Invoice'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//           Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Invoice ID: $_invoiceId',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Text('${_invoiceDate != null ? DateFormat.yMd().format(_invoiceDate!) : 'N/A'}',
//                 style: const TextStyle(fontSize: 16)),
//             const SizedBox(height: 16),
//           ],
//         ),
           
//             const SizedBox(height: 16),
//              Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade400, width: 1.5),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                   child: TextField(
//                     controller: _taxController,
//                     keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                      onChanged: (value) {
//                 _calculateTotalBill();
//               },
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Enter the tax amount',
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 40.0,
//                 width: 1.5,
//                 color: Colors.grey.shade400,
//               ),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                   child: TextField(
//                     controller: _discountController,
//                     keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                        onChanged: (value) {
//                 _calculateTotalBill();
//               },
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Enter the discount amount',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               value: _paymentMethod,
//               items: _paymentMethods.map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _paymentMethod = newValue;
//                 });
//               },
//               decoration: const InputDecoration(labelText: 'Payment Method'),
//             ),
//             const SizedBox(height: 16),
//             // ElevatedButton(
//             //   onPressed: _selectDueDate,
//             //   child: Text(
//             //     _selectedDate != null
//             //         ? 'Selected Due Date: ${DateFormat.yMd().format(_selectedDate!)}'
//             //         : 'Select Due Date',
//             //   ),
//             // ),
//             const SizedBox(height: 16),
//             Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.blue, width: 2),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: ElevatedButton(
//             onPressed: _addItems,
//             style: ElevatedButton.styleFrom(
//               elevation: 0,

//             ),
//             child: const Text(
//               '+ Add inline items',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.blue),
//             ),
//           ),
//         ),
//         if (_selectedItems.isNotEmpty) ...[
//           const SizedBox(height: 16),
//           const Text(
//             'Selected Items:',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           ListView.builder(
          
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: _selectedItems.length,
//             itemBuilder: (context, index) {
//               return ListTile(
               
//                 title: Text(_selectedItems[index]['itemName']),
//                 subtitle: Text('${_selectedItems[index]['quantity']} X ${_selectedItems[index]['rate']}'),
//                 trailing: Column(
//                   children: [Text('Price: ₹${_selectedItems[index]['price'].toStringAsFixed(2)}', style: const TextStyle(fontSize: 15)),
//         IconButton(
//                     icon: const Icon(Icons.delete ),
//                     onPressed: () {
//                       setState(() {
//                         _selectedItems.removeAt(index);
//                         _calculateTotalAmount();
//                       });
//                     },
//                   ),
//         ])
//         );
//             },
//           ),
//           const Divider(),
          
//           Row(
//             children: [
//               Text(
//                 'Sub Total: ₹${_totalAmount.toStringAsFixed(2)}',
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 'Total: ₹${_totalBill.toStringAsFixed(2)}',
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),
//           Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.blue, width: 2),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child:    
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               elevation: 0,

//             ),
//             onPressed: _saveChanges,
//             child: const Text('Save Invoice' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.blue),),
//           ),
//            ),
//             ElevatedButton(
//               onPressed: _saveInvoice,
//               child: const Text('Save Invoice'),
//             ),
//             // const SizedBox(height: 16),
//             // ElevatedButton(
//             //   onPressed: _saveChanges,
//             //   child: const Text('Save Changes'),
//             // ),
//           ],
//         ]),
//       ),
//     );
//   }
// }


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloneapp/pages/customerpage.dart';
import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/invoiceadd.dart';
import 'package:cloneapp/pages/subpages/settings/applock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Invoicedraft extends StatefulWidget {
  final String invoiceId;

  const Invoicedraft({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<Invoicedraft> createState() => _InvoicedraftState();
}

class _InvoicedraftState extends State<Invoicedraft> {
  bool _showDetails = false;
  final currentuser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? invoiceData;
  final TextEditingController paymentReceivedController = TextEditingController();
  final TextEditingController paymentDueController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
 double totalBill = 0;
  double totalReceived = 0;
  double paymentDue = 0;
  String? _paymentMethod;
  String? errorMessage;
  final List<String> _paymentMethods = [
    'Cash',
    'Online',
    'Cheque',
    'Debit/Credit Card'
  ];

  @override
  void initState() {
    super.initState();
    fetchInvoiceData();
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
          invoiceData = invoiceSnapshot.data() as Map<String, dynamic>?;
          totalBill = invoiceData?['totalBill']?.toDouble() ?? 0;
          totalReceived = invoiceData?['totalReceived']?.toDouble() ?? 0;
          paymentDue = totalBill - totalReceived;
          paymentDueController.text = paymentDue.toStringAsFixed(2);
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching invoice data: $e";
      });
    }
  }

 void updatePaymentDue(double paymentReceived) {
  setState(() {
    totalReceived += paymentReceived;
    paymentDue = totalBill - totalReceived;
    paymentDue = paymentDue < 0 ? 0 : paymentDue; // Ensure paymentDue is not negative
    paymentDueController.text = paymentDue.toStringAsFixed(2);
  });
}


  void savePayment() async {
  double paymentReceived = double.tryParse(paymentReceivedController.text) ?? 0;

  if (paymentReceived < 0) {
    setState(() {
      errorMessage = "Payment amount must be greater than zero.";
    });
    return;
  }

  if (paymentReceived > totalBill) {
    setState(() {
      errorMessage = "Payment received cannot be greater than payment due.";
    });
    return;
  }

  var payment = {
    'amount': paymentReceived,
    'date': Timestamp.fromDate(DateTime.parse(dateController.text)),
    'paymentMethod': _paymentMethod ?? '',
  };

  try {
    await FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentuser!.uid)
        .collection('invoices')
        .doc(widget.invoiceId)
        .update({
          'totalReceived': totalReceived + paymentReceived,
          'paymentHistory': FieldValue.arrayUnion([payment]),
        });

    // Update payment due
    updatePaymentDue(paymentReceived);

    // Clear input fields
    paymentReceivedController.clear();
    dateController.clear();
    _paymentMethod = null;

    // Refresh data
    fetchInvoiceData();
  } catch (e) {
    setState(() {
      errorMessage = "Error saving payment: $e";
    });
  }
}

  bool isReadonly = false; // Initial condition

  void updateInvoiceStatus(bool status) async {
    try {
      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("invoices")
          .doc(widget.invoiceId)
          .update({'status': status});
      setState(() {
        invoiceData!['status'] = status;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error updating invoice status: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isInvoicePaid = invoiceData?['status'] ?? false;
    String statusText = isInvoicePaid ? 'PAID' : 'UNPAID';
    Color statusColor = isInvoicePaid ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Draft"),
        actions: [
          if (invoiceData != null)
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("USERS")
                    .doc(currentuser!.uid)
                    .collection("customers")
                    .doc(invoiceData!["customerID"]) // Replace with actual customer document ID
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Error fetching data"));
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(child: Text("No customers found"));
                  }

                  DocumentSnapshot customerData = snapshot.data!;

                  return Row(children: [
                    IconButton(
                      onPressed: fetchInvoiceData,
                      icon: const Icon(Icons.refresh),
                    ),
                    IconButton(
  icon: const Icon(Icons.delete),
  onPressed: () {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Delete Invoice',
      desc: 'Are you sure you want to delete this invoice?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        try {
          await FirebaseFirestore.instance
              .collection("USERS")
              .doc(currentuser!.uid)
              .collection("invoices")
              .doc(widget.invoiceId)
              .delete();
          Navigator.of(context).pop(); // Close dialog
          // Optionally show a confirmation Snackbar or Toast
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Invoice deleted successfully"),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text("Failed to delete invoice: $e"),
            ),
          );
        }
      },
    ).show();
  },
)
,
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
                            title: Text('Preview'),
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
                            //      Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => InvoiceEdit(
                            //       invoiceId: widget.invoiceId,
                            //       customerID: invoiceData!['customerID'],
                            //     ),
                            //   ),
                            // );
                            break;
                          case 'edit_customer':
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Customeredit(customerData: customerData)));
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
                    )
                  ]);
                }),
        ],
      ),
      drawer: drawer(context),
      body: invoiceData == null
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 3,
              child: Scaffold(
                body: Column(
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
                                (invoiceData!['invoiceDate'] as Timestamp).toDate()),
                          ),
                          Text(
                            invoiceData!['customerName'],
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'Balance: $paymentDue',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Payment Due: $paymentDue',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 25),
                          if (!isInvoicePaid)
                            ElevatedButton(
                              onPressed: () {
                                // Set invoice status to PAID
                                updateInvoiceStatus(true);
                              },
                              child: const Text('Mark as PAID'),
                            ),
                          if (isInvoicePaid)
                            ElevatedButton(
                              onPressed: () {
                                // Set invoice status to UNPAID
                                updateInvoiceStatus(false);
                              },
                              child: const Text('Mark as UNPAID'),
                            ),
                          Text(
                            'Status: $statusText',
                            style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                   Container(
                  
                      margin: const EdgeInsets.only(left: 0),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                      ),
                    
                        child: const TabBar(
                          tabs: [
                            Tab(
                              child: Text(
                                'Invoice',
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
                                                  '${item['price']}',
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
// Text('Due  ${invoiceData?['paymentDue']} '),
const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                TextField(
                                  controller: paymentReceivedController,
                                  decoration: const InputDecoration(
                                    labelText: 'Payment Received',
                                    errorText: null,
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
    double paymentReceived = double.tryParse(value) ?? 0;
    if (paymentReceived < 0) {
      paymentReceivedController.text = '0';
    }
    updatePaymentDue(paymentReceived);
  },
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: paymentDueController,
                                  decoration: const InputDecoration(
                                    labelText: 'Payment Due',
                                  ),
                                  keyboardType: TextInputType.number,
                                  readOnly: true,
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: _paymentMethod,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _paymentMethod = newValue;
                                    });
                                  },
                                  items: _paymentMethods.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  decoration: const InputDecoration(
                                    labelText: 'Payment Method',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    labelText: 'Payment Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                        );

                                        if (pickedDate != null) {
                                          setState(() {
                                            dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  readOnly: true,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        savePayment();
                                      },
                                      child: const Text('Save Payment'),
                                    ),
                                  ],
                                ),
                                if (errorMessage != null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      errorMessage!,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'History:',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: invoiceData?['paymentHistory']?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    var payment = invoiceData!['paymentHistory'][index];
                                    return ListTile(
                                      title: Text(payment['paymentMethod']),
                                      subtitle: Text(
                                          'Amount: ${payment['amount']} \nDate: ${DateFormat('dd-MM-yyyy').format((payment['date'] as Timestamp).toDate())}'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
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


// class Invoicedraft extends StatefulWidget {
//   final String invoiceId;

//   const Invoicedraft({Key? key, required this.invoiceId}) : super(key: key);

//   @override
//   State<Invoicedraft> createState() => _InvoicedraftState();
// }

// class _InvoicedraftState extends State<Invoicedraft> {
//    bool _showDetails = false;
//   final currentuser = FirebaseAuth.instance.currentUser;
//   Map<String, dynamic>? invoiceData;
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController paymentReceivedController = TextEditingController();
//   final TextEditingController paymentDueController = TextEditingController();

//   List<Map<String, dynamic>> paymentHistory = [];
//   double totalReceived = 0;
//   String? _paymentMethod;
//   String? errorMessage;
//   final List<String> _paymentMethods = [
//     'Cash',
//     'Online',
//     'Cheque',
//     'Debit/Credit Card'
//   ];

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
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error fetching invoice data: $e";
//       });
//     }
//   }
// bool isreadonly = false; // Initial condition

  
//   void updateInvoiceStatus(bool status) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("invoices")
//           .doc(widget.invoiceId)
//           .update({'status': status});
//       setState(() {
//         invoiceData!['status'] = status;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error updating invoice status: $e";
//       });
//     }
//   }


   


//   @override
//   Widget build(BuildContext context) {
//     bool isInvoicePaid = invoiceData?['status'] ?? false;
//     String statusText = isInvoicePaid ? 'PAID' : 'UNPAID';
//     Color statusColor = isInvoicePaid ? Colors.green : Colors.red;
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Invoice Draft"),
//         actions: [
//          StreamBuilder<DocumentSnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection("USERS")
//                 .doc(currentuser!.uid)
//                 .collection("customers")
//                 .doc(invoiceData!["customerID"]) // Replace with actual customer document ID
//                 .snapshots(),
//         builder: (context, snapshot) {
           
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (snapshot.hasError) {
//                 return const Center(child: Text("Error fetching data"));
//               }

//               if (!snapshot.hasData || !snapshot.data!.exists) {
//                 return const Center(child: Text("No customers found"));
//               }

//               DocumentSnapshot customerData = snapshot.data!;

//         return Row(
//                 children: [
        
//           IconButton(
//             onPressed: fetchInvoiceData,
//             icon: const Icon(Icons.refresh),
//           ),
//           IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: () async {
//                 // Perform delete operation
//                 await FirebaseFirestore.instance
//                     .collection("USERS")
//                     .doc(currentuser!.uid)
//                     .collection("invoices")
//                     .doc(widget.invoiceId)
//                     .delete();
//                 Navigator.of(context).pop(); // Close dialog
//                 // Optionally show a confirmation Snackbar or Toast
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     backgroundColor: Colors.green,
//                     content: Text("Invoice deleted successfully"),
//                   ),
//                 );
//               },
//             ),
//           PopupMenuButton<String>(
//             icon: const Icon(Icons.more_vert, color: Colors.black),
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//               const PopupMenuItem<String>(
//                 value: 'customer',
//                 child: ListTile(
//                   leading: Icon(Icons.person_add),
//                   title: Text('New Customer'),
//                 ),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'invoice',
//                 child: ListTile(
//                   leading: Icon(Icons.add),
//                   title: Text('New Invoice'),
//                 ),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'proceed_payment',
//                 child: ListTile(
//                   leading: Icon(Icons.payment),
//                   title: Text('Preview'),
//                 ),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'edit',
//                 child: ListTile(
//                   leading: Icon(Icons.edit),
//                   title: Text('edit invoice'),
//                 ),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'edit_customer',
//                 child: ListTile(
//                   leading: Icon(Icons.edit_document),
//                   title: Text('Edit Customer'),
//                 ),
//               ),
//             ],
//             onSelected: (String value) {
//               switch (value) {
//                 case 'customer':
//                   Navigator.pushNamed(context, '/customer');
//                   break;
//                 case 'invoice':
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => InvoiceAdd(
//                         customerID: invoiceData!['customerID'],
//                       ),
//                     ),
//                   );
//                   break;
//                 case 'edit':
//               //      Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) => InvoiceEdit(
//               //       invoiceId: widget.invoiceId,
//               //       customerID: invoiceData!['customerID'],
//               //     ),
//               //   ),
//               // );
//                   break;
//                 case 'edit_customer':
//                   Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Customeredit(customerData: customerData))
//               );
//                   break;
//                 case 'proceed_payment':
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PreviewBill(
//                         invoiceId: widget.invoiceId,
//                       ),
//                     ),
//                   );
//                   break;
//                 default:
//               }
//             },
//           )
//                 ]);
//         }
//           ),
//         ],
//       ),
//       drawer: drawer(context),
//       body: invoiceData == null
//           ? const Center(child: CircularProgressIndicator())
//           : DefaultTabController(
//               length: 3,
//               child: 
//               Scaffold(
//                 body: 
//                  Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Invoice ID: ${widget.invoiceId}',
//                             style: const TextStyle(
//                                 fontSize: 21, fontWeight: FontWeight.bold),
//                           ),
                           
//                           Text(
//                             DateFormat('dd-MM-yyyy').format(
//                                 (invoiceData!['invoiceDate'] as Timestamp)
//                                     .toDate()),
//                           ),
//                           Text(
//                             invoiceData!['customerName'],
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           const SizedBox(height: 25),
//                           Text(
//                             'Balance : ${invoiceData?['paymentDue']}',
//                             style: const TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             statusText,
//                             style: TextStyle(
//                                 color: statusColor,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     Container(
                  
//                       margin: const EdgeInsets.only(left: 0),
//                       decoration: const BoxDecoration(
//                         color: Colors.blue,
//                       ),
                    
//                         child: const TabBar(
                          
                        
//                           tabs: [
//                             Tab(
//                               child: Text(
//                                 'Invoice',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Tab(
//                               child: Text(
//                                 'Payment',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Tab(
//                               child: Text(
//                                 'History',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
                           
//                           ],
//                         ),
//                       ),
                    
//                     Expanded(
//                       child: TabBarView(
//                         children: [
//                           SingleChildScrollView(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Items:',
//                                   style: TextStyle(
//                                       fontSize: 20, fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 ListView.builder(
//                                   shrinkWrap: true,
//                                   physics:
//                                       const NeverScrollableScrollPhysics(),
//                                   itemCount: (invoiceData!['items'] as List)
//                                       .length,
//                                   itemBuilder: (context, index) {
//                                     Map<String, dynamic> item =
//                                         (invoiceData!['items'] as List)[index];
//                                     return ListTile(
//                                       title: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           Expanded(
//                                             flex: 1,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   item['itemName'],
//                                                   style: const TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       fontSize: 15),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.end,
//                                               children: [
//                                                 Text(
//                                                   '${item['quantity']} X ${item['rate']}',
//                                                   style: const TextStyle(
//                                                       fontSize: 15),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.end,
//                                               children: [
//                                                 Text(
//                                                   '${item['price']}',
//                                                   style: const TextStyle(
//                                                       fontSize: 15),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 const Di'SubTotal', invoiceData?['total amount'] ?? 0.0),
//             _buildDetailItemFor('Discouvider(thickness: 1, color: Colors.grey),
//              _buildDetailItemForDouble(nt %', invoiceData?['discount'] ?? 0.0),
//             _buildDetailItemFor('Tax %', invoiceData?['tax'] ?? 0.0),
//             _buildDetailItemForDouble('Total', invoiceData?['totalBill'] ?? 0.0),
//  Text('Due  ${invoiceData?['paymentDue']} '),
// const SizedBox(height: 20),
//                               ],
//                             ),
//                           ),

//  SingleChildScrollView(

//     child: Column(
   
//       children: [
//         const SizedBox(height: 50,),
        
// const Text("Payment Due"),
//  TextField(
//   controller: paymentDueController,
//   readOnly: true,
//   showCursor: false,
//   keyboardType: TextInputType.none,
//   decoration: InputDecoration(
//     hintText: 'Payment Due',
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.blue,
//         width: 2.0,
//       ),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.grey,
//         width: 1.0,
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.blue,
//         width: 2.0,
//       ),
//     ),
//     filled: true,
//     fillColor: Colors.white,
//     contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
//   ),
// ),
// const Text("Payment Received"),

// TextFormField(
  
//   readOnly: isreadonly,
//   controller: paymentReceivedController,
//   keyboardType: TextInputType.number,
//   decoration: InputDecoration(
//     hintText: 'Amount',
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.blue,
//         width: 2.0,
//       ),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.grey,
//         width: 1.0,
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(
//         color: Colors.blue,
//         width: 2.0,
//       ),
//     ),
//     filled: true,
//     fillColor: Colors.white,
//     contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
//   ),
//   // onChanged: (value) {
//   //   setState(() {
//   //     _updatePaymentDue();
//   //   });
//   // },
// ),const SizedBox(height: 10,),
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     const Padding(padding: EdgeInsets.only(left: 10)),
//   const Expanded(flex: 2,
  
//     child: Text("Payment Mode"))
//   ,
   
//   Expanded(flex: 3,
//     child: 
  
// DropdownButton<String>(
//           value: _paymentMethod,
//           onChanged: (String? newValue) {
//             setState(() {
//               _paymentMethod = newValue!;
//             });
//           },
//           items: _paymentMethods.map<DropdownMenuItem<String>>((String value) {
//             return 
//              DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//   )
  
// ]
// ),
// TextField(
//                                   controller: dateController,
//                                   decoration: InputDecoration(
//                                     labelText: 'Payment Date',
//                                     suffixIcon: IconButton(
//                                       icon: const Icon(Icons.calendar_today),
//                                       onPressed: () async {
//                                         DateTime? pickedDate = await showDatePicker(
//                                           context: context,
//                                           initialDate: DateTime.now(),
//                                           firstDate: DateTime(2000),
//                                           lastDate: DateTime(2101),
//                                         );

//                                         if (pickedDate != null) {
//                                           setState(() {
//                                             dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                                           });
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                   readOnly: true,
//                                 ),
//   const SizedBox(height: 10,),
//   Row(
//     children: [
//       Expanded(flex: 1,
//         child: ElevatedButton(
//                     onPressed: () {
//                 if (paymentReceivedController.text.isEmpty) {
//                   setState(() {
//                     errorMessage = "Please enter a payment received amount.";
//                   });
//                 } else {
//                   // updatePaymentDetails();
//                 }
//               },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10 ),
                        
//                       ),
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Text(
//                       'Save',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ), ),
                  
//                  Expanded(flex: 1,
//         child: ElevatedButton(
//                     //  onPressed: redue,
//                         onPressed: (){},
//                         style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
                        
//                       ),
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Text(
//                       'Clear',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ), )
//     ],
//   )

                                
//                               ],
    
//   ),
// ),
//                  const          SingleChildScrollView(
                          
//                             child: Text("terms"),
// ),
//                           // Center(
//                           //   child: Text("terms"),
//                           // )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
}