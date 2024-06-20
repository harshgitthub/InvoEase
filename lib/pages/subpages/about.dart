
// // THIS IS CODE FOR PDF ON COMPUTER 


// // import 'package:cloneapp/pages/home.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:pdf/pdf.dart';
// // import 'package:pdf/widgets.dart' as pw;
// // import 'dart:typed_data';
// // import 'dart:html' as html;
// // import 'package:intl/intl.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class Invoice {
// //   final String id;
// //   final String customerName;
// //   final String customerAddress;
// //   final String customerEmail;
// //   final DateTime invoiceDate;
// //   final DateTime dueDate;
// //   final List<Map<String, dynamic>> procedures;
// //   final double totalBill;

// //   Invoice({
// //     required this.id,
// //     required this.customerName,
// //     required this.customerAddress,
// //     required this.customerEmail,
// //     required this.invoiceDate,
// //     required this.dueDate,
// //     required this.procedures,
// //     required this.totalBill,
// //   });
// // }

// // class InvoiceListPage extends StatefulWidget {
// //   @override
// //   _InvoiceListPageState createState() => _InvoiceListPageState();
// // }

// // class _InvoiceListPageState extends State<InvoiceListPage> {
// //   late List<String> _invoiceIds = []; // List to hold invoice IDs
// //   late Map<String, Invoice> _invoices = {}; // Map to cache invoice data
// //   late Map<String, Map<String, dynamic>> _organizationData = {}; // Map to cache organization data

// //   final currentUser = FirebaseAuth.instance.currentUser;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchInvoiceIds();
// //     _fetchOrganizationData();
// //   }

// //   void _fetchInvoiceIds() async {
// //     try {
// //       // Fetch all invoice IDs from Firestore
// //       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
// //           .collection('USERS')
// //           .doc(currentUser!.uid)
// //           .collection('bills')
// //           .get();

// //       List<String> invoiceIds = querySnapshot.docs.map((doc) => doc.id).toList();

// //       setState(() {
// //         _invoiceIds = invoiceIds;
// //       });
// //     } catch (e) {
// //       print('Error fetching invoice IDs: $e');
// //       // Handle error
// //     }
// //   }

//   // void _fetchOrganizationData() async {
//   //   try {
//   //     // Fetch organization details from Firestore and cache them
//   //     DocumentSnapshot organizationSnapshot = await FirebaseFirestore.instance
//   //         .collection('USERS')
//   //         .doc(currentUser!.uid) 
//   //         .collection('details')
//   //         .doc(currentUser!.uid) 
//   //         .get();

// //       setState(() {
// //         _organizationData = {
// //           'organization': organizationSnapshot.data() as Map<String, dynamic>,
// //         };
// //       });
// //     } catch (e) {
// //       print('Error fetching organization details: $e');
// //       // Handle error
// //     }
// //   }

// //   Future<Uint8List> createPdf(Invoice invoice, Map<String, dynamic> organizationData) async {
// //     final pdf = pw.Document();

// //     pdf.addPage(
// //       pw.Page(
// //     build: (pw.Context context) {
// //       return pw.Column(
// //     crossAxisAlignment: pw.CrossAxisAlignment.start,
// //     children: [
// //      pw.Text(
// //             organizationData['Organisation'] ?? '',
// //             style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
// //           ),
// //           pw.Text(
// //             organizationData['State'] ?? '',
// //             style: const pw.TextStyle(fontSize: 14),
// //           ),
// //           pw.SizedBox(height: 0),
// //           pw.Row(children: [
// //  pw.Column(
// //         crossAxisAlignment: pw.CrossAxisAlignment.start,
// //         children: [
// //           pw.Text('Customer Name: ${invoice.customerName}', style: const pw.TextStyle(fontSize: 16)),
// //           pw.Text('Customer Address: ${invoice.customerAddress}', style: const pw.TextStyle(fontSize: 14)),
// //           pw.Text('Customer Email: ${invoice.customerEmail}', style: const pw.TextStyle(fontSize: 14)),
         
// //         ],
// //       ),
// //        pw.SizedBox(width: 20),
// //       // Right Column: Invoice details
// //       pw.Column(
// //         crossAxisAlignment: pw.CrossAxisAlignment.start,
// //         children: [
// //           pw.SizedBox(height: 5),
// //           pw.Text('Invoice ID: ${invoice.id}', style: const pw.TextStyle(fontSize: 16)),
// //           pw.Text(
// //             'Invoice Date: ${DateFormat('yyyy-MM-dd HH:mm').format(invoice.invoiceDate)}',
// //             style: const pw.TextStyle(fontSize: 14),
// //           ),
// //           pw.Text(
// //             'Due Date: ${DateFormat('yyyy-MM-dd HH:mm').format(invoice.dueDate)}',
// //             style: const pw.TextStyle(fontSize: 14),
// //           ),
// //           pw.SizedBox(height: 10),
// //         ],
// //       ),
// //           ])
// //      ,
// //   pw.SizedBox(height: 30),
// //           // Table with Procedures
// //           pw.Table(
// //             border: pw.TableBorder.all(),
// //             children: [
// //               pw.TableRow(
// //                 children: [
// //                   pw.Container(
// //                     padding: const pw.EdgeInsets.all(5),
// //                     alignment: pw.Alignment.center,
// //                     child: pw.Text('Description', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //                   ),
// //                   pw.Container(
// //                     padding: const pw.EdgeInsets.all(5),
// //                     alignment: pw.Alignment.center,
// //                     child: pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //                   ),
// //                   pw.Container(
// //                     padding: const pw.EdgeInsets.all(5),
// //                     alignment: pw.Alignment.center,
// //                     child: pw.Text('Quantity', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //                   ),
// //                   pw.Container(
// //                     padding: const pw.EdgeInsets.all(5),
// //                     alignment: pw.Alignment.center,
// //                     child: pw.Text('Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //                   ),
// //                 ],
// //               ),
// //               for (var item in invoice.procedures)
// //                 pw.TableRow(
// //                   children: [
// //                     pw.Container(
// //                       padding: const pw.EdgeInsets.all(5),
// //                       alignment: pw.Alignment.centerLeft,
// //                       child: pw.Text(item['description'] ?? ''),
// //                     ),
// //                     pw.Container(
// //                       padding: const pw.EdgeInsets.all(5),
// //                       alignment: pw.Alignment.center,
// //                       child: pw.Text('\$${item['price']?.toString() ?? ''}'),
// //                     ),
// //                     pw.Container(
// //                       padding: const pw.EdgeInsets.all(5),
// //                       alignment: pw.Alignment.center,
// //                       child: pw.Text('${item['quantity']?.toString() ?? ''}'),
// //                     ),
// //                     pw.Container(
// //                       padding: const pw.EdgeInsets.all(5),
// //                       alignment: pw.Alignment.center,
// //                       child: pw.Text('\$${(item['quantity'] ?? 1) * (item['price']?.toDouble() ?? 0)}'),
// //                     ),
// //                   ],
// //                 ),
// //             ],
// //           ),
// //           pw.SizedBox(height: 10),
// //           // Total Bill
// //           pw.Text(
// //             'Total Bill: \$${invoice.totalBill.toStringAsFixed(2)}',
// //             style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
// //           ),
// //           pw.SizedBox(height: 40),
// //           // Terms and Conditions
// //           pw.Container(
// //             alignment: pw.Alignment.centerLeft,
// //             child: pw.Column(
// //               crossAxisAlignment: pw.CrossAxisAlignment.start,
// //               children: [
// //                 pw.Text(
// //                   'Terms & Conditions',
// //                   style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
// //                 ),
// //                 pw.SizedBox(height: 5),
// //                 pw.Text(
// //                   '1. This is an estimate, actual amount may vary depending on the treatment undertaken.',
// //                   style: const pw.TextStyle(fontSize: 14),
// //                 ),
// //                 pw.SizedBox(height: 5),
// //                 pw.Text(
// //                   '2. All payments are to be paid in advance before completion of treatment',
// //                   style: const pw.TextStyle(fontSize: 14),
// //                 ),
// //                 pw.SizedBox(height: 5),
// //                 pw.Text(
// //                   '3. Advance given will not be refunded once the treatment started.',
// //                   style: const pw.TextStyle(fontSize: 14),
// //                 ),
// //                 pw.SizedBox(height: 5),
// //                 pw.Text(
// //                   '4. No warranties or guarantees can be provided for any dental procedures as they carry standard medical risk.',
// //                   style: const pw.TextStyle(fontSize: 14),
// //                 ),
// //                  pw.SizedBox(height: 5),
// //                 pw.Text(
// //                   '5. EMI facility available',
// //                   style: const pw.TextStyle(fontSize: 14),
// //                 ),
// //                  pw.SizedBox(height: 10),
// //                 pw.Text(
// //                   'This is a system generated document and does not required signature.',
// //                   style: const pw.TextStyle(fontSize: 20 ),
// //                 ),
                
// //                 // Add more pw.Text widgets as needed for additional terms and details.
// //               ],
// //             ),
// //           ),
// //         ],
// //       );
// //     },
// //       ));
// //       // pw.Page(
// //       //   build: (pw.Context context) {
// //       //     return pw.Column(
// //       //       crossAxisAlignment: pw.CrossAxisAlignment.start,
// //       //       children: [
// //       //         // Organization Name and Address
// //       //         pw.Text(organizationData['Organisation'] ?? '', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
// //       //         pw.Text(organizationData['State'] ?? '', style: const pw.TextStyle(fontSize: 14)),
// //       //         pw.SizedBox(height: 20),
// //       //         // Invoice details
// //       //         pw.Text('Invoice ID: ${invoice.id}', style: const pw.TextStyle(fontSize: 16)),
// //       //         pw.Text('Customer Name: ${invoice.customerName}', style: const pw.TextStyle(fontSize: 16)),
// //       //         pw.Text('Customer Address: ${invoice.customerAddress}', style: const pw.TextStyle(fontSize: 14)),
// //       //         pw.Text('Customer Email: ${invoice.customerEmail}', style: const pw.TextStyle(fontSize: 14)),
// //       //         pw.Text('Invoice Date: ${DateFormat('yyyy-MM-dd HH:mm').format(invoice.invoiceDate)}', style: const pw.TextStyle(fontSize: 14)),
// //       //         pw.Text('Due Date: ${DateFormat('yyyy-MM-dd HH:mm').format(invoice.dueDate)}', style: const pw.TextStyle(fontSize: 14)),
// //       //         pw.SizedBox(height: 10),
// //       //         // Table with Procedures
// //       //         pw.Table(
// //       //           border: pw.TableBorder.all(),
// //       //           children: [
// //       //             pw.TableRow(
// //       //               children: [
// //       //                 pw.Container(
// //       //                   padding: const pw.EdgeInsets.all(5),
// //       //                   alignment: pw.Alignment.center,
// //       //                   child: pw.Text('Description', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //       //                 ),
// //       //                 pw.Container(
// //       //                   padding: const pw.EdgeInsets.all(5),
// //       //                   alignment: pw.Alignment.center,
// //       //                   child: pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //       //                 ),
// //       //                 pw.Container(
// //       //                   padding: const pw.EdgeInsets.all(5),
// //       //                   alignment: pw.Alignment.center,
// //       //                   child: pw.Text('Quantity', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //       //                 ),
// //       //                 pw.Container(
// //       //                   padding: const pw.EdgeInsets.all(5),
// //       //                   alignment: pw.Alignment.center,
// //       //                   child: pw.Text('Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //       //                 ),
// //       //               ],
// //       //             ),
// //       //             for (var item in invoice.procedures)
// //       //               pw.TableRow(
// //       //                 children: [
// //       //                   pw.Container(
// //       //                     padding: const pw.EdgeInsets.all(5),
// //       //                     alignment: pw.Alignment.centerLeft,
// //       //                     child: pw.Text(item['description'] ?? ''),
// //       //                   ),
// //       //                   pw.Container(
// //       //                     padding: const pw.EdgeInsets.all(5),
// //       //                     alignment: pw.Alignment.center,
// //       //                     child: pw.Text('\$${item['price']?.toString() ?? ''}'),
// //       //                   ),
// //       //                   pw.Container(
// //       //                     padding: const pw.EdgeInsets.all(5),
// //       //                     alignment: pw.Alignment.center,
// //       //                     child: pw.Text('${item['quantity']?.toString() ?? ''}'),
// //       //                   ),
// //       //                   pw.Container(
// //       //                     padding: const pw.EdgeInsets.all(5),
// //       //                     alignment: pw.Alignment.center,
// //       //                     child: pw.Text('\$${(item['quantity'] ?? 1) * (item['price']?.toDouble() ?? 0)}'),
// //       //                   ),
// //       //                 ],
// //       //               ),
// //       //           ],
// //       //         ),
// //       //         pw.SizedBox(height: 10),
// //       //         // Total Bill
// //       //         pw.Text('Total Bill: \$${invoice.totalBill.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
// //       //       ],
// //       //     );
// //       //   },
// //       // ),
    

// //     return pdf.save();
// //   }

// //   void downloadPdf(Uint8List pdfData, String invoiceId) {
// //     final blob = html.Blob([pdfData], 'application/pdf');
// //     final url = html.Url.createObjectUrlFromBlob(blob);
// //     final anchor = html.AnchorElement(href: url)
// //       ..setAttribute('download', 'invoice_$invoiceId.pdf')
// //       ..click();
// //     html.Url.revokeObjectUrl(url);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Invoice List'),
// //       ),
// //       drawer: drawer(context),
// //       body: _invoiceIds.isEmpty
// //           ? const Center(child: CircularProgressIndicator())
// //           : ListView.builder(
// //               itemCount: _invoiceIds.length,
// //               itemBuilder: (context, index) {
// //                 String invoiceId = _invoiceIds[index];
// //                 Invoice? invoice = _invoices[invoiceId];

// //                 return FutureBuilder(
// //                   future: _fetchInvoiceData(invoiceId),
// //                   builder: (context, snapshot) {
// //                     if (snapshot.connectionState == ConnectionState.waiting) {
// //                       return const ListTile(
// //                         title: Text('Loading...'),
// //                       );
// //                     }

// //                     if (snapshot.hasError) {
// //                       return ListTile(
// //                         title: Text('Error: ${snapshot.error}'),
// //                       );
// //                     }

// //                     if (!snapshot.hasData || snapshot.data == null) {
// //                       return const ListTile(
// //                         title: const Text('No data found'),
// //                       );
// //                     }

// //                     Invoice invoice = snapshot.data as Invoice;
// //                     _invoices[invoiceId] = invoice;

// //                     return ListTile(
// //                       title:  Text('Customer: ${invoice.customerName}' , style: const TextStyle( fontSize: 18),),
// //                       subtitle: Text('Invoice ID: ${invoice.id}, Date: ${DateFormat('yyyy-MM-dd HH:mm').format(invoice.invoiceDate)}'),
// //                       trailing: ElevatedButton(
// //                         onPressed: () async {
// //                           try {
// //                             final pdfData = await createPdf(invoice, _organizationData['organization'] ?? {});
// //                             downloadPdf(pdfData, invoice.id);
// //                           } catch (e) {
// //                             print('Error creating PDF: $e');
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               const SnackBar(
// //                                 content: Text('Failed to create PDF'),
// //                                 duration: Duration(seconds: 3),
// //                               ),
// //                             );
// //                           }
// //                         },
// //                         child: const Text('Download PDF'),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //     );
// //   }

// //   Future<Invoice> _fetchInvoiceData(String invoiceId) async {
// //     try {
// //       // Fetch invoice data from Firestore for a specific invoice ID
// //       DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
// //           .collection('USERS')
// //           .doc(currentUser!.uid)
// //           .collection('bills')
// //           .doc(invoiceId)
// //           .get();

// //       // Extract invoice data from the snapshot
//       // String customerName = invoiceSnapshot['Customer Name'] ?? '';
//       // String customerAddress = invoiceSnapshot['Customer Address'] ?? '';
//       // String customerEmail = invoiceSnapshot['Customer Email'] ?? '';
//       // DateTime invoiceDate = (invoiceSnapshot['Invoice Date'] as Timestamp).toDate();
//       // DateTime dueDate = (invoiceSnapshot['Due Date'] as Timestamp).toDate();
//       // double totalBill = invoiceSnapshot['Total Bill'].toDouble();

// //       // Extract procedures array
// //             // Extract procedures array
// //       List<Map<String, dynamic>> procedures = List<Map<String, dynamic>>.from(invoiceSnapshot['Procedures']);

// //       // Create Invoice object
// //       Invoice invoice = Invoice(
// //         id: invoiceId,
// //         customerName: customerName,
// //         customerAddress: customerAddress,
// //         customerEmail: customerEmail,
// //         invoiceDate: invoiceDate,
// //         dueDate: dueDate,
// //         procedures: procedures,
// //         totalBill: totalBill,
// //       );

// //       return invoice;
// //     } catch (e) {
// //       print('Error fetching invoice data: $e');
// //       throw e; // Rethrow the error to be caught by the caller
// //     }
// //   }
// // }

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Invoice App',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: InvoiceListPage(),
// //     );
// //   }
// // // }


import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/subpages/invoicedata.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  User? currentUser;
  Map<String, dynamic> _organizationData = {};
  late String selectedTemplate;
  List<Term> termsAndConditions = []; 

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    _loadSelectedTemplate();
    _fetchTermsInOrder();
  }

  Future<void> _loadSelectedTemplate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTemplate = prefs.getString('selected_template') ?? 'Spreadsheet';
    });
  }

  Future<void> _saveSelectedTemplate(String template) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_template', template);
    setState(() {
      selectedTemplate = template;
    });
  }

  void _showTemplateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Template'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Standard Template'),
                trailing: selectedTemplate == 'Standard' ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  setState(() {
                    _saveSelectedTemplate('Standard');
                  });
                  Navigator.pop(context); // Close the dialog
                },
              ),
              ListTile(
                title: const Text('Spreadsheet Template'),
                trailing: selectedTemplate == 'Spreadsheet' ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  setState(() {
                    _saveSelectedTemplate('Spreadsheet');
                  });
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _fetchCurrentUser() async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _fetchOrganizationData();
    }
  }

  void _fetchOrganizationData() async {
    try {
      // Fetch organization details from Firestore and cache them
      DocumentSnapshot organizationSnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.uid)
          .collection('details')
          .doc(currentUser!.uid)
          .get();

      setState(() {
        _organizationData = organizationSnapshot.data() as Map<String, dynamic>;
      });
    } catch (e) {
      print('Error fetching organization data: $e');
    }
  }

  // This method fetches terms and conditions from Firestore
  void _fetchTermsInOrder() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.uid)
          .collection('terms')
          .orderBy('index') // Order terms by the 'index' field
          .get();

      List<Term> tempList = [];

      querySnapshot.docs.forEach((doc) {
        tempList.add(Term(
          id: doc.id,
          text: doc['text'],
        ));
      });

      setState(() {
        termsAndConditions = tempList; // Update terms and conditions list
      });
    } catch (e) {
      print('Error fetching terms and conditions: $e');
    }
  }

  // This method fetches invoice data from Firestore based on invoiceId
  Future<Invoice> _fetchInvoiceData(String invoiceId) async {
    try {
      // Fetch invoice data from Firestore for a specific invoice ID
      DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.uid)
          .collection('bills')
          .doc(invoiceId)
          .get();

      // Extract invoice data from the snapshot
      String customerName = invoiceSnapshot["Customer Name"] ?? '';
      String customerAddress = invoiceSnapshot['Customer Address'] ?? '';
      String customerEmail = invoiceSnapshot['Customer Email'] ?? '';
      DateTime invoiceDate = (invoiceSnapshot['Invoice Date'] as Timestamp?)?.toDate() ?? DateTime.now();
      DateTime dueDate = (invoiceSnapshot['Due Date'] as Timestamp?)?.toDate() ?? DateTime.now();
      double totalBill = invoiceSnapshot['Total Bill'].toDouble();

      // Extract procedures array
      List<Map<String, dynamic>> procedures = List<Map<String, dynamic>>.from(invoiceSnapshot['Procedures'] ?? []);

      // Create Invoice object
      Invoice invoice = Invoice(
        id: invoiceId,
        customerName: customerName,
        customerAddress: customerAddress,
        customerEmail: customerEmail,
        invoiceDate: invoiceDate,
        dueDate: dueDate,
        procedures: procedures,
        totalBill: totalBill,
      );

      return invoice;
    } catch (e) {
      print('Error fetching invoice data: $e');
      throw e; // Rethrow the error to be caught by the caller
    }
  }

  // This method generates a PDF invoice using the provided template
  Future<void> _createAndSavePdf(Invoice invoice, Map<String, dynamic> organizationData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  organizationData['Organisation Name'] ?? '',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  organizationData['Address'] ?? '',
                  style: const pw.TextStyle(fontSize: 14 , ),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Customer Name: ${invoice.customerName}', style: const pw.TextStyle(fontSize: 16)),
                        // pw.Text('Customer Address: ${invoice.customerAddress}', style: const pw.TextStyle(fontSize: 14)),
                        // pw.Text('Customer Email: ${invoice.customerEmail}', style: const pw.TextStyle(fontSize: 14)),
                      ],
                    ),
                    pw.SizedBox(width: 20),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Invoice ID: ${invoice.id}', style: const pw.TextStyle(fontSize: 16)),
                        pw.Text(
                          'Invoice Date: ${DateFormat('yyyy-MM-dd HH:mm').format(invoice.invoiceDate)}',
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          'Due Date: ${DateFormat('yyyy-MM-dd HH').format(invoice.dueDate)}',
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 30),
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          child: pw.Text('Description', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          child: pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          child: pw.Text('Quantity', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          child: pw.Text('Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                      ],
                    ),
                    for (var item in invoice.procedures)
                      pw.TableRow(
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(item['description'] ?? ''),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.center,
                            child: pw.Text('₹${item['price']?.toString() ?? ''}'),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.center,
                            child: pw.Text('${item['quantity']?.toString() ?? ''}'),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.center,
                            child: pw.Text('₹${(item['quantity'] ?? 1) * (item['price']?.toDouble() ?? 0)}'),
                          ),
                        ],
                      ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Total Bill: ₹${invoice.totalBill.toStringAsFixed(2)}',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
               pw.SizedBox(height: 40),
                pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Terms & Conditions',
                        style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                      ),
                      ...termsAndConditions.map((term) => pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(height: 5),
                              pw.Text(
                                term.text,
                                style: const pw.TextStyle(fontSize: 14),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/${invoice.id}_invoice.pdf');
    await file.writeAsBytes(await pdf.save());

    // Open the generated PDF file
    OpenFile.open(file.path);
  }


  Future<void> _createAndSaveSpreadsheetPdf(Invoice invoice, Map<String, dynamic> organizationData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                organizationData['Organisation Name'] ?? '',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                organizationData['Address'] ?? '',
                style: const pw.TextStyle(fontSize: 14),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Customer Name: ${invoice.customerName}', style: const pw.TextStyle(fontSize: 16)),
                      pw.Text('Customer Address: ${invoice.customerAddress}', style: const pw.TextStyle(fontSize: 14)),
                      pw.Text('Customer Email: ${invoice.customerEmail}', style: const pw.TextStyle(fontSize: 14)),
                    ],
                  ),
                  pw.SizedBox(width: 20),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Invoice ID: ${invoice.id}', style: const pw.TextStyle(fontSize: 16)),
                      pw.Text(
                        'Invoice Date: ${DateFormat('yyyy-MM-dd HH:mm').format(invoice.invoiceDate)}',
                        style: const pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        'Due Date: ${DateFormat('yyyy-MM-dd HH').format(invoice.dueDate)}',
                        style: const pw.TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(5),
                        alignment: pw.Alignment.center,
                        child: pw.Text('Description', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(5),
                        alignment: pw.Alignment.center,
                        child: pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(5),
                        alignment: pw.Alignment.center,
                        child: pw.Text('Quantity', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(5),
                        alignment: pw.Alignment.center,
                        child: pw.Text('Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  for (var item in invoice.procedures)
                    pw.TableRow(
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(item['description'] ?? ''),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          child: pw.Text('₹${item['price']?.toString() ?? ''}'),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          child: pw.Text('${item['quantity']?.toString() ?? ''}'),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          child: pw.Text('₹${(item['quantity'] ?? 1) * (item['price']?.toDouble() ?? 0)}'),
                        ),
                      ],
                    ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Total Bill: ₹${invoice.totalBill.toStringAsFixed(2)}',
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 40),
              
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/${invoice.id}_spreadsheet_invoice.pdf');
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_left_sharp),
            onPressed: () {
              _showTemplateDialog(context);
            },
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: drawer(context),
      body: selectedTemplate == 'Spreadsheet' ? _createAndSaveSpreadsheetPd() : _createAndSavePd(),
    );
  }

  StreamBuilder<QuerySnapshot> _createAndSaveSpreadsheetPd() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser?.uid)
          .collection('bills')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final invoices = snapshot.data!.docs.map((doc) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            title: Text('${doc['Customer Name']}', style: const TextStyle(fontSize: 21)),
            subtitle: Text('Invoice ID: ${doc.id}', style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 32, 155, 255))),
            trailing: ElevatedButton(
              onPressed: () async {
                try {
                  Invoice invoice = await _fetchInvoiceData(doc.id);
                  await _createAndSaveSpreadsheetPdf(invoice, _organizationData['organization'] ?? {});
                } catch (e) {
                  print('Error creating PDF: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to create PDF'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text('Download PDF'),
            ),
          );
        }).toList();

        return ListView(children: invoices);
      },
    );
  }

  
  StreamBuilder<QuerySnapshot> _createAndSavePd() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser?.uid)
          .collection('bills')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final invoices = snapshot.data!.docs.map((doc) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            title: Text('${doc['Customer Name']}', style: const TextStyle(fontSize: 21)),
            subtitle: Text('Invoice ID: ${doc.id}', style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 32, 155, 255))),
            trailing: ElevatedButton(
              onPressed: () async {
                try {
                  Invoice invoice = await _fetchInvoiceData(doc.id);
                  await _createAndSavePdf(invoice, _organizationData['organization'] ?? {});
                } catch (e) {
                  print('Error creating PDF: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to create PDF'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text('Download PDF'),
            ),
          );
        }).toList();

        return ListView(children: invoices);
      },
    );
  }

}

class Invoice {
  final String id;
  final String customerName;
  final String customerAddress;
  final String customerEmail;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final List<Map<String, dynamic>> procedures;
  final double totalBill;

  Invoice({
    required this.id,
    required this.customerName,
    required this.customerAddress,
    required this.customerEmail,
    required this.invoiceDate,
    required this.dueDate,
    required this.procedures,
    required this.totalBill,
  });
}

