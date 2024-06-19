
// import 'package:cloneapp/pages/home.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:io';
// // Import from lecle_download_path_provider

// class InvoiceScreen extends StatefulWidget {
//   @override
//   _InvoiceScreenState createState() => _InvoiceScreenState();
// }

// class _InvoiceScreenState extends State<InvoiceScreen> {
//   User? currentUser;
//   Map<String, dynamic> _organizationData = {};

//   @override
//   void initState() {
//     super.initState();
//     _fetchCurrentUser();
//   }

//   Future<void> _fetchCurrentUser() async {
//     currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       _fetchOrganizationData();
//     }
//   }

//   void _fetchOrganizationData() async {
//     try {
//       // Fetch organization details from Firestore and cache them
//       DocumentSnapshot organizationSnapshot = await FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentUser!.uid)
//           .collection('details')
//           .doc(currentUser!.uid)
//           .get();

//       setState(() {
//         _organizationData = organizationSnapshot.data() as Map<String, dynamic>;
//       });
//     } catch (e) {
//       print('Error fetching organization data: $e');
//     }
//   }

//   Future<Invoice> _fetchInvoiceData(String invoiceId) async {
//     try {
//       // Fetch invoice data from Firestore for a specific invoice ID
//       DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentUser!.uid)
//           .collection('bills')
//           .doc(invoiceId)
//           .get();

//       // Extract invoice data from the snapshot
//       String customerName = invoiceSnapshot["Customer Name"] ?? '';
//       String customerAddress = invoiceSnapshot['Customer Address'] ?? '';
//       String customerEmail = invoiceSnapshot['Customer Email'] ?? '';
//       DateTime invoiceDate = (invoiceSnapshot['Invoice Date'] as Timestamp?)?.toDate() ?? DateTime.now();
//       DateTime dueDate = (invoiceSnapshot['Due Date'] as Timestamp?)?.toDate() ?? DateTime.now();
//       double totalBill = invoiceSnapshot['Total Bill'].toDouble();

//       // Extract procedures array
//       List<Map<String, dynamic>> procedures = List<Map<String, dynamic>>.from(invoiceSnapshot['Procedures'] ?? []);

//       // Create Invoice object
//       Invoice invoice = Invoice(
//         id: invoiceId,
//         customerName: customerName,
//         customerAddress: customerAddress,
//         customerEmail: customerEmail,
//         invoiceDate: invoiceDate,
//         dueDate: dueDate,
//         procedures: procedures,
//         totalBill: totalBill,
//       );

//       return invoice;
//     } catch (e) {
//       print('Error fetching invoice data: $e');
//       throw e; // Rethrow the error to be caught by the caller
//     }
//   }

//   Future<void> _createAndSavePdf2(Invoice invoice, Map<String, dynamic> organizationData) async {
//     final pdf = pw.Document();

//     pdf.addPage(  
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text(
//                 organizationData['Organisation Name'] ?? '',
//                 style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text(
//                 organizationData['Address'] ?? '',
//                 style: const pw.TextStyle(fontSize: 14),
//               ),
//               pw.SizedBox(height: 10),
//               pw.Row(
//                 children: [
//                   pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text('Customer Name: ${invoice.customerName}', style: const pw.TextStyle(fontSize: 16)),
//                       pw.Text('Customer Address: ${invoice.customerAddress}', style: const pw.TextStyle(fontSize: 14)),
//                       pw.Text('Customer Email: ${invoice.customerEmail}', style: const pw.TextStyle(fontSize: 14)),
//                     ],
//                   ),
//                   pw.SizedBox(width: 20),
//                   pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text('Invoice ID: ${invoice.id}', style: const pw.TextStyle(fontSize: 16)),
//                       pw.Text(
//                         'Invoice Date: ${DateFormat('yyyy-MM-dd HH:mm').format(invoice.invoiceDate)}',
//                         style: const pw.TextStyle(fontSize: 14),
//                       ),
//                       pw.Text(
//                         'Due Date: ${DateFormat('yyyy-MM-dd HH').format(invoice.dueDate)}',
//                         style: const pw.TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               pw.SizedBox(height: 30),
//               pw.Table(
//                 border: pw.TableBorder.all(),
//                 children: [
//                   pw.TableRow(
//                     children: [
//                       pw.Container(
//                         padding: const pw.EdgeInsets.all(5),
//                         alignment: pw.Alignment.center,
//                         child: pw.Text('Description', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Container(
//                         padding: const pw.EdgeInsets.all(5),
//                         alignment: pw.Alignment.center,
//                         child: pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Container(
//                         padding: const pw.EdgeInsets.all(5),
//                         alignment: pw.Alignment.center,
//                         child: pw.Text('Quantity', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Container(
//                         padding: const pw.EdgeInsets.all(5),
//                         alignment: pw.Alignment.center,
//                         child: pw.Text('Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                     ],
//                   ),
//                   for (var item in invoice.procedures)
//                     pw.TableRow(
//                       children: [
//                         pw.Container(
//                           padding: const pw.EdgeInsets.all(5),
//                           alignment: pw.Alignment.centerLeft,
//                           child: pw.Text(item['description'] ?? ''),
//                         ),
//                         pw.Container(
//                           padding: const pw.EdgeInsets.all(5),
//                           alignment: pw.Alignment.center,
//                           child: pw.Text('\$${item['price']?.toString() ?? ''}'),
//                         ),
//                         pw.Container(
//                           padding: const pw.EdgeInsets.all(5),
//                           alignment: pw.Alignment.center,
//                           child: pw.Text('${item['quantity']?.toString() ?? ''}'),
//                         ),
//                         pw.Container(
//                           padding: const pw.EdgeInsets.all(5),
//                           alignment: pw.Alignment.center,
//                           child: pw.Text('\$${(item['quantity'] ?? 1) * (item['price']?.toDouble() ?? 0)}'),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//               pw.SizedBox(height: 10),
//               pw.Text(
//                 'Total Bill: \$${invoice.totalBill.toStringAsFixed(2)}',
//                 style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.SizedBox(height: 40),
//             ],
//           );
//         },
//       ),
//     );

    
//    try {
//     final directory = await getDownloadsDirectory();
//     final file = File('${directory!.path}/invoice_${invoice.id}.pdf');
//     await file.writeAsBytes(await pdf.save());

//     print("File saved");
//     print('File path: ${file.path}');

//     // Show success dialog with option to open PDF
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('PDF Saved'),
//           content: const Text('Invoice PDF saved to Downloads folder.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Open'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 OpenFile.open(file.path); // Use a package like open_file to open the PDF
//               },
//             ),
//             TextButton(
//               child: const Text('Dismiss'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   } catch (e) {
//     print('Error saving PDF: $e');
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: Text('Failed to save PDF. Error: $e'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

  
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Invoice List"),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.menu),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//             );
//           },
//         ),
//       ),
//       drawer: drawer(context),
//       body: pdf2(),
//     );
//   }

//   StreamBuilder<QuerySnapshot<Object?>> pdf2() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentUser?.uid)
//           .collection('bills')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final invoices = snapshot.data!.docs.map((doc) {
//           return ListTile(
//             contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//             title: Text('${doc['Customer Name']}' , style: const TextStyle(fontSize: 21),),
//             subtitle: Text('Invoice ID: ${doc.id}' , style: const TextStyle(fontSize:  18 , color: Color.fromARGB(255, 32, 155, 255)), ),
//             trailing: ElevatedButton(
//               onPressed: () async {
//                 try {
//                   Invoice invoice = await _fetchInvoiceData(doc.id);
//                   await _createAndSavePdf2(invoice, _organizationData['organization'] ?? {});
//                 } catch (e) {
//                   print('Error creating PDF: $e');
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Failed to create PDF'),
//                       duration: Duration(seconds: 3),
//                     ),
//                   );
//                 }
//               },
//               child: const Text('Download PDF'), 
//             ),
//           );
//         }).toList();

//         return ListView(children: invoices);
//       },
//     );
//   }
// }
  

// class LecleDownloadPathProvider {
// }
//   class Invoice {
//   final String id;
//   final String customerName;
//   final String customerAddress;
//   final String customerEmail;
//   final DateTime invoiceDate;
//   final DateTime dueDate;
//   final List<Map<String, dynamic>> procedures;
//   final double totalBill;

//   Invoice({
//     required this.id,
//     required this.customerName,
//     required this.customerAddress,
//     required this.customerEmail,
//     required this.invoiceDate,
//     required this.dueDate,
//     required this.procedures,
//     required this.totalBill,
//   });
// }


import 'package:flutter/material.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}