import 'dart:ffi';
import 'dart:io';

import 'package:cloneapp/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';


class PreviewBill extends StatefulWidget {
  final String invoiceId;
  const PreviewBill({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<PreviewBill> createState() => _PreviewBillState();
}

class _PreviewBillState extends State<PreviewBill> {
  String _invoiceId = '';
  DateTime? _invoiceDate;
  DateTime? _selectedDate;
  String? _paymentMethod;
  String? _paymentdue ;
  String? _totalbill ;
  String? _discount ;
  String?  _tax ;
  String? _totalamount;
  String? _paymentreceived;

  String? _organisation;
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
  final currentUser = FirebaseAuth.instance.currentUser;
  String? _selectedProfession;
  String? _address;
  String? _mobile;
  String? _gst ;

  Map<String, dynamic>? invoiceData;
  String _selectedOption = 'simple';

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchInvoiceData();
  }

  Future<void> fetchData() async {
    try{
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentUser!.uid)
        .collection("details")
        .doc(currentUser!.uid)
        .get();
        if (userDoc.exists) {
       setState(() {
      _organisation = userDoc['Organisation Name'];
      // _propreitor.text = userDoc["Proprietor"];
      _address = userDoc['Address'];
      _mobile = userDoc['Phone Number'].toString();
      _gst = userDoc['gst'];
      _selectedProfession = userDoc['Profession'];
      // imageUrl = userDoc['Profile Image'];
    });
      
        }
    
  }
  catch(e){
    print("error");
  }
  }

  Future<void> fetchInvoiceData() async {
    try {
      DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.uid)
          .collection('invoices')
          .doc(widget.invoiceId)
          .get();
     if (invoiceSnapshot.exists) {
        setState(() {
          _invoiceId = widget.invoiceId;
          _invoiceDate = invoiceSnapshot['invoiceDate'] != null
              ? (invoiceSnapshot['invoiceDate'] as Timestamp).toDate()
              : null;
          _selectedDate = invoiceSnapshot['dueDate'] != null
              ? (invoiceSnapshot['dueDate'] as Timestamp).toDate()
              : null;
          _paymentMethod = invoiceSnapshot['paymentMethod'];
          _selectedItems = List<Map<String, dynamic>>.from(invoiceSnapshot['items']);
          _customerName = invoiceSnapshot['customerName'];
          _customerAddress = invoiceSnapshot['customerAddress'];
          _customerEmail = invoiceSnapshot['customerEmail'];
          _customerWorkPhone = invoiceSnapshot['workphone'];
          _customerMobile = invoiceSnapshot['mobile'];
          _customerid = invoiceSnapshot['customerID'];
         _paymentreceived = invoiceSnapshot["paymentReceived"].toString();
_paymentdue = invoiceSnapshot["paymentDue"].toString();
_tax = invoiceSnapshot['tax'].toString();
_discount = invoiceSnapshot["discount"].toString();
_totalamount = invoiceSnapshot["total amount"].toString();
_totalbill = invoiceSnapshot["totalBill"].toString();




        });
      }
    } catch (e) {
      print("Error fetching invoice details: $e");
    }
  }

Future<void> _downloadInvoice1() async {
    final pdf = pw.Document();

 const PdfColor primaryColor = PdfColors.blue;
const PdfColor accentColor = PdfColors.grey800;
const PdfColor textColor = PdfColors.black;

// Define styles
final pw.TextStyle titleStyle = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18, color: primaryColor);
const pw.TextStyle subtitleStyle = pw.TextStyle(fontSize: 18, color: textColor);
const pw.TextStyle itemStyle = pw.TextStyle(fontSize: 12, color: textColor);

// Function to create a section header
pw.Widget _sectionHeader(String title) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 8, top: 16),
    child: pw.Text(
      title,
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16, color: primaryColor),
    ),
  );
}

// Function to create an item row
pw.Container _itemRow(String itemName, String quantity, double price) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 8),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(itemName, style: itemStyle),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text('Quantity: $quantity', style: itemStyle, textAlign: pw.TextAlign.center),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text('Price: \₹${price.toStringAsFixed(2)}', style: itemStyle, textAlign: pw.TextAlign.center),
        ),
      ],
    ),
  );
}

pdf.addPage(
  pw.Page(
    build: (pw.Context context) => pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Invoice header
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 20),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24, color: primaryColor)),
              pw.Text('Invoice ID: $_invoiceId', style: subtitleStyle),
            ],
          ),
        ),
        pw.Divider(thickness: 2, color: primaryColor),
        pw.SizedBox(height: 12),

        // Organization details
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Organization: $_organisation', style: subtitleStyle),
            pw.Text('Invoice Date: ${DateFormat.yMMMd().format(_invoiceDate!)}', style: subtitleStyle),
          ],
        ),
        pw.SizedBox(height: 12),

        // Customer details
        _sectionHeader('Bill To'),
        pw.Text('Customer Name: $_customerName', style: subtitleStyle),
        pw.Text('Customer Address: $_customerAddress', style: subtitleStyle),
        pw.Text('Customer Email: $_customerEmail', style: subtitleStyle),
        pw.Text('Customer Mobile: $_customerMobile', style: subtitleStyle),
        pw.SizedBox(height: 12),

        // Items section
        _sectionHeader('Items'),
        pw.Table(
          border: pw.TableBorder.all(color: primaryColor),
          children: [
            pw.TableRow(
              children: [
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Item', style: titleStyle)),
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Quantity', style: titleStyle, textAlign: pw.TextAlign.center)),
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Price', style: titleStyle, textAlign: pw.TextAlign.center)),
              ],
            ),
            ..._selectedItems.map((item) {
              return pw.TableRow(
                children: [
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text(item['itemName'], style: itemStyle)),
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('${item['quantity']}', style: itemStyle, textAlign: pw.TextAlign.center)),
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('${item['price'].toStringAsFixed(2)}', style: itemStyle, textAlign: pw.TextAlign.center)),
                ],
              );
            }).toList(),
          ],
        ),
        pw.SizedBox(height: 12),

        // Financial summary
        _sectionHeader('Financial Summary'),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Tax: $_tax', style: subtitleStyle),
            pw.Text('Discount: $_discount', style: subtitleStyle),
          ],
        ),
         pw.SizedBox(height: 5,),
         pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Amount: $_totalamount', style: subtitleStyle),
        pw.Text('Total Bill: $_totalbill', style: subtitleStyle),
          ],
        ), pw.SizedBox(height: 5,),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
           pw.Text('Payment Received: $_paymentreceived', style: subtitleStyle),
        pw.Text('Payment Due: $_paymentdue', style: subtitleStyle),
          ],
        ),
        
        
      ],
    ),
  ),
);


    try {
             final directory = await getTemporaryDirectory();
     final file = File('${directory.path}/invoice_$_invoiceId.pdf');
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
      print("success");
    } catch (e) {
      print('Error generating PDF: $e');
    }
  }


Future<void> _downloadInvoice2() async {
    final pdf = pw.Document();

 const PdfColor primaryColor = PdfColors.blue;
const PdfColor accentColor = PdfColors.grey800;
const PdfColor textColor = PdfColors.black;

// Define styles
final pw.TextStyle titleStyle = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18, color: primaryColor);
const pw.TextStyle subtitleStyle = pw.TextStyle(fontSize: 18, color: textColor);
const pw.TextStyle itemStyle = pw.TextStyle(fontSize: 12, color: textColor);

// Function to create a section header
pw.Widget _sectionHeader(String title) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 8, top: 16),
    child: pw.Text(
      title,
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16, color: primaryColor),
    ),
  );
}

// Function to create an item row
pw.Container _itemRow(String itemName, String quantity, double price) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 8),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(itemName, style: itemStyle),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text('Quantity: $quantity', style: itemStyle, textAlign: pw.TextAlign.center),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text('Price: \₹${price.toStringAsFixed(2)}', style: itemStyle, textAlign: pw.TextAlign.center),
        ),
      ],
    ),
  );
}

pdf.addPage(
  pw.Page(
    build: (pw.Context context) => pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Invoice header
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 20),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24, color: primaryColor)),
              pw.Text('Invoice ID: $_invoiceId', style: subtitleStyle),
            ],
          ),
        ),
        pw.Divider(thickness: 2, color: primaryColor),
        pw.SizedBox(height: 12),

        // Organization details
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Organization: $_organisation', style: subtitleStyle),
            pw.Text('Invoice Date: ${DateFormat.yMMMd().format(_invoiceDate!)}', style: subtitleStyle),
          ],
        ),
        pw.SizedBox(height: 12),

        // Customer details
        _sectionHeader('Bill To'),
        pw.Text('Customer Name: $_customerName', style: subtitleStyle),
        pw.Text('Customer Address: $_customerAddress', style: subtitleStyle),
        pw.Text('Customer Email: $_customerEmail', style: subtitleStyle),
        pw.Text('Customer Mobile: $_customerMobile', style: subtitleStyle),
        pw.SizedBox(height: 12),

        // Items section
        _sectionHeader('Items'),
        pw.Table(
          border: pw.TableBorder.all(color: primaryColor),
          children: [
            pw.TableRow(
              children: [
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Item', style: titleStyle)),
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Quantity', style: titleStyle, textAlign: pw.TextAlign.center)),
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Price', style: titleStyle, textAlign: pw.TextAlign.center)),
              ],
            ),
            ..._selectedItems.map((item) {
              return pw.TableRow(
                children: [
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text(item['itemName'], style: itemStyle)),
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('${item['quantity']}', style: itemStyle, textAlign: pw.TextAlign.center)),
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('${item['price'].toStringAsFixed(2)}', style: itemStyle, textAlign: pw.TextAlign.center)),
                ],
              );
            }).toList(),
          ],
        ),
        pw.SizedBox(height: 12),

        // Financial summary
        _sectionHeader('Financial Summary'),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Tax: $_tax', style: subtitleStyle),
            pw.Text('Discount: $_discount', style: subtitleStyle),
          ],
        ),
         pw.SizedBox(height: 5,),
         pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Amount: $_totalamount', style: subtitleStyle),
        pw.Text('Total Bill: $_totalbill', style: subtitleStyle),
          ],
        ), pw.SizedBox(height: 5,),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
           pw.Text('Payment Received: $_paymentreceived', style: subtitleStyle),
        pw.Text('Payment Due: $_paymentdue', style: subtitleStyle),
          ],
        ),
        
        
      ],
    ),
  ),
);


    try {
             final directory = await getTemporaryDirectory();
     final file = File('${directory.path}/invoice_$_invoiceId.pdf');
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
      print("success");
    } catch (e) {
      print('Error generating PDF: $e');
    }
  }


Future<void> _downloadInvoice3() async {
    final pdf = pw.Document();

 const PdfColor primaryColor = PdfColors.blue;
const PdfColor accentColor = PdfColors.grey800;
const PdfColor textColor = PdfColors.black;

// Define styles
final pw.TextStyle titleStyle = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18, color: primaryColor);
const pw.TextStyle subtitleStyle = pw.TextStyle(fontSize: 18, color: textColor);
const pw.TextStyle itemStyle = pw.TextStyle(fontSize: 12, color: textColor);

// Function to create a section header
pw.Widget _sectionHeader(String title) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 8, top: 16),
    child: pw.Text(
      title,
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16, color: primaryColor),
    ),
  );
}

// Function to create an item row
pw.Container _itemRow(String itemName, String quantity, double price) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 8),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(itemName, style: itemStyle),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text('Quantity: $quantity', style: itemStyle, textAlign: pw.TextAlign.center),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text('Price: \₹${price.toStringAsFixed(2)}', style: itemStyle, textAlign: pw.TextAlign.center),
        ),
      ],
    ),
  );
}

pdf.addPage(
  pw.Page(
    build: (pw.Context context) => pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Invoice header
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 20),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24, color: primaryColor)),
              pw.Text('Invoice ID: $_invoiceId', style: subtitleStyle),
            ],
          ),
        ),
        pw.Divider(thickness: 2, color: primaryColor),
        pw.SizedBox(height: 12),

        // Organization details
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Organization: $_organisation', style: subtitleStyle),
            pw.Text('Invoice Date: ${DateFormat.yMMMd().format(_invoiceDate!)}', style: subtitleStyle),
          ],
        ),
        pw.SizedBox(height: 12),

        // Customer details
        _sectionHeader('Bill To'),
        pw.Text('Customer Name: $_customerName', style: subtitleStyle),
        pw.Text('Customer Address: $_customerAddress', style: subtitleStyle),
        pw.Text('Customer Email: $_customerEmail', style: subtitleStyle),
        pw.Text('Customer Mobile: $_customerMobile', style: subtitleStyle),
        pw.SizedBox(height: 12),

        // Items section
        _sectionHeader('Items'),
        pw.Table(
          border: pw.TableBorder.all(color: primaryColor),
          children: [
            pw.TableRow(
              children: [
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Item', style: titleStyle)),
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Quantity', style: titleStyle, textAlign: pw.TextAlign.center)),
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Price', style: titleStyle, textAlign: pw.TextAlign.center)),
              ],
            ),
            ..._selectedItems.map((item) {
              return pw.TableRow(
                children: [
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text(item['itemName'], style: itemStyle)),
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('${item['quantity']}', style: itemStyle, textAlign: pw.TextAlign.center)),
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('${item['price'].toStringAsFixed(2)}', style: itemStyle, textAlign: pw.TextAlign.center)),
                ],
              );
            }).toList(),
          ],
        ),
        pw.SizedBox(height: 12),

        // Financial summary
        _sectionHeader('Financial Summary'),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Tax: $_tax', style: subtitleStyle),
            pw.Text('Discount: $_discount', style: subtitleStyle),
          ],
        ),
         pw.SizedBox(height: 5,),
         pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Amount: $_totalamount', style: subtitleStyle),
        pw.Text('Total Bill: $_totalbill', style: subtitleStyle),
          ],
        ), pw.SizedBox(height: 5,),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
           pw.Text('Payment Received: $_paymentreceived', style: subtitleStyle),
        pw.Text('Payment Due: $_paymentdue', style: subtitleStyle),
          ],
        ),
        
        
      ],
    ),
  ),
);


    try {
             final directory = await getTemporaryDirectory();
     final file = File('${directory.path}/invoice_$_invoiceId.pdf');
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
      print("success");
    } catch (e) {
      print('Error generating PDF: $e');
    }
  }


Future<void> _downloadInvoice4() async {
    final pdf = pw.Document();

 const PdfColor primaryColor = PdfColors.blue;
const PdfColor accentColor = PdfColors.grey800;
const PdfColor textColor = PdfColors.black;

// Define styles
final pw.TextStyle titleStyle = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18, color: primaryColor);
const pw.TextStyle subtitleStyle = pw.TextStyle(fontSize: 18, color: textColor);
const pw.TextStyle itemStyle = pw.TextStyle(fontSize: 12, color: textColor);

// Function to create a section header
pw.Widget _sectionHeader(String title) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 8, top: 16),
    child: pw.Text(
      title,
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16, color: primaryColor),
    ),
  );
}

// Function to create an item row
pw.Container _itemRow(String itemName, String quantity, double price) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 8),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(itemName, style: itemStyle),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text('Quantity: $quantity', style: itemStyle, textAlign: pw.TextAlign.center),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text('Price: \₹${price.toStringAsFixed(2)}', style: itemStyle, textAlign: pw.TextAlign.center),
        ),
      ],
    ),
  );
}

pdf.addPage(
  pw.Page(
    build: (pw.Context context) => pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Invoice header
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 20),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24, color: primaryColor)),
              pw.Text('Invoice ID: $_invoiceId', style: subtitleStyle),
            ],
          ),
        ),
        pw.Divider(thickness: 2, color: primaryColor),
        pw.SizedBox(height: 12),

        // Organization details
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Organization: $_organisation', style: subtitleStyle),
            pw.Text('Invoice Date: ${DateFormat.yMMMd().format(_invoiceDate!)}', style: subtitleStyle),
          ],
        ),
        pw.SizedBox(height: 12),

        // Customer details
        _sectionHeader('Bill To'),
        pw.Text('Customer Name: $_customerName', style: subtitleStyle),
        pw.Text('Customer Address: $_customerAddress', style: subtitleStyle),
        pw.Text('Customer Email: $_customerEmail', style: subtitleStyle),
        pw.Text('Customer Mobile: $_customerMobile', style: subtitleStyle),
        pw.SizedBox(height: 12),

        // Items section
        _sectionHeader('Items'),
        pw.Table(
          border: pw.TableBorder.all(color: primaryColor),
          children: [
            pw.TableRow(
              children: [
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Item', style: titleStyle)),
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Quantity', style: titleStyle, textAlign: pw.TextAlign.center)),
                pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('Price', style: titleStyle, textAlign: pw.TextAlign.center)),
              ],
            ),
            ..._selectedItems.map((item) {
              return pw.TableRow(
                children: [
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text(item['itemName'], style: itemStyle)),
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('${item['quantity']}', style: itemStyle, textAlign: pw.TextAlign.center)),
                  pw.Container(padding: const pw.EdgeInsets.all(8), child: pw.Text('${item['price'].toStringAsFixed(2)}', style: itemStyle, textAlign: pw.TextAlign.center)),
                ],
              );
            }).toList(),
          ],
        ),
        pw.SizedBox(height: 12),

        // Financial summary
        _sectionHeader('Financial Summary'),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Tax: $_tax', style: subtitleStyle),
            pw.Text('Discount: $_discount', style: subtitleStyle),
          ],
        ),
         pw.SizedBox(height: 5,),
         pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Amount: $_totalamount', style: subtitleStyle),
        pw.Text('Total Bill: $_totalbill', style: subtitleStyle),
          ],
        ), pw.SizedBox(height: 5,),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
           pw.Text('Payment Received: $_paymentreceived', style: subtitleStyle),
        pw.Text('Payment Due: $_paymentdue', style: subtitleStyle),
          ],
        ),
        
        
      ],
    ),
  ),
);


    try {
             final directory = await getTemporaryDirectory();
     final file = File('${directory.path}/invoice_$_invoiceId.pdf');
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
      print("success");
    } catch (e) {
      print('Error generating PDF: $e');
    }
  }

 void _downloadInvoice() {
    switch (_selectedOption) {
      case 'simple':
        _downloadInvoice1();
        break;
      case 'classic':
        _downloadInvoice2();
        break;
      case 'modern':
        _downloadInvoice3();
        break;
      case 'professional':
        _downloadInvoice4();
        break;
      default:
        print('No valid option selected');
        break;
    }
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                 _selectedOption = result;
                // Perform actions based on selected option
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'simple',
                child: Text('Simple'),
              ),
              const PopupMenuItem<String>(
                value: 'classic',
                child: Text('classic'),
              ),
              const PopupMenuItem<String>(
                value: 'modern',
                child: Text('Modern'),
              ),
              const PopupMenuItem<String>(
                value: 'professional',
                child: Text('Professional'),
              ),
            ],
          ),
          const SizedBox(width: 20), // Add spacing between dropdown and other actions if needed
        ],
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
             Card(
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
      
      ),
    
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            '$_organisation',
            style: const TextStyle(
              // Make sure this font is added in your pubspec.yaml
              fontSize: 30.0, // Adjust the font size as per your requirement
              color: Colors.blue, // Choose a color that suits your design
              fontWeight: FontWeight.bold,
            
            ),
            textAlign: TextAlign.center,
            
          ),
        ),
      ),
    ),
    Card(
      
      shape: const RoundedRectangleBorder(
        
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _address ?? 'No Address Provided',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
               
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'GST No. ${_gst ?? 'No GST Provided'}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.phone, color: Colors.blue),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _mobile ?? 'No Mobile Provided',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
      Card(
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_customerName',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 8.0),
              IconButton(
                icon: const Icon(Icons.info_outline , size: 20,),
                color: Colors.black,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Customer Details'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const    Text(
                              'Name:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('$_customerName'),
                            const SizedBox(height: 8.0),
                       const       Text(
                              'Email:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('$_customerEmail'),
                        const      SizedBox(height: 8.0),
                          const    Text(
                              'Address:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('$_customerAddress'),
                            const SizedBox(height: 8.0),
                        const      Text(
                              'Phone:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('$_customerMobile'),
                          ],
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
            ],
          ),
        ),
      )
    ),
    
  
 ListTile(
    title: const Text('Amount Received'),
   subtitle: Text(
  '$_paymentreceived', 
  style: const TextStyle(fontSize: 16),
),

    trailing: Text('$_invoiceDate'),
  ),
  const Divider(thickness: 1, color: Colors.black,),
  Container(
       // Set the background color to gray
      child: ListTile(
        title: Text('InvoiceID : $_invoiceId'),
      ),
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
                  physics: const NeverScrollableScrollPhysics(),
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

    ], const Divider(thickness: 1, color:  Colors.black,)
    ,Container(    

          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              _buildBox(title: 'Tax', value: '$_tax'),
              _buildBox(title: 'Discount', value: '$_discount'),
              _buildBox(title: 'Total Amount', value: '$_totalamount'),
              _buildBox(title: 'Total Bill', value: '$_totalbill'),
              _buildBox(title: 'Payment Received', value: '$_paymentreceived'),
              _buildBox(title: 'Payment Due', value: '$_paymentdue'),
            ],
          ),
        ),
        const SizedBox(height: 16,),
        Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                  onPressed: _downloadInvoice,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  child: const Text(
                    'Download Invoice',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
   Widget _buildBox({required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}






// import 'dart:io';
// import 'package:cloneapp/pages/home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:open_file/open_file.dart';

// class PreviewBill extends StatefulWidget {
//   final String invoiceId;
//   const PreviewBill({Key? key, required this.invoiceId}) : super(key: key);

//   @override
//   State<PreviewBill> createState() => _PreviewBillState();
// }

// class _PreviewBillState extends State<PreviewBill> {
//   String _invoiceId = '';
//   DateTime? _invoiceDate;
//   DateTime? _selectedDate;
//   String? _paymentMethod;
//   String? _paymentdue;
//   String? _totalbill;
//   String? _discount;
//   String? _tax;
//   String? _totalamount;
//   String? _paymentreceived;

//   String? _organisation;
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
//   final currentUser = FirebaseAuth.instance.currentUser;
//   String? _selectedProfession;
//   String? _address;
//   String? _mobile;
//   String? _gst;

//   Map<String, dynamic>? invoiceData;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     fetchInvoiceData();
//   }

//   Future<void> fetchData() async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentUser!.uid)
//           .collection("details")
//           .doc(currentUser!.uid)
//           .get();
//       if (userDoc.exists) {
//         setState(() {
//           _organisation = userDoc['Organisation Name'];
//           _address = userDoc['Address'];
//           _mobile = userDoc['Phone Number'].toString();
//           _gst = userDoc['gst'];
//           _selectedProfession = userDoc['Profession'];
//         });
//       }
//     } catch (e) {
//       print("Error fetching user details: $e");
//     }
//   }

//   Future<void> fetchInvoiceData() async {
//     try {
//       DocumentSnapshot invoiceSnapshot = await FirebaseFirestore.instance
//           .collection('USERS')
//           .doc(currentUser!.uid)
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
//           _selectedItems =
//               List<Map<String, dynamic>>.from(invoiceSnapshot['items']);
//           _customerName = invoiceSnapshot['customerName'];
//           _customerAddress = invoiceSnapshot['customerAddress'];
//           _customerEmail = invoiceSnapshot['customerEmail'];
//           _customerWorkPhone = invoiceSnapshot['workphone'];
//           _customerMobile = invoiceSnapshot['mobile'];
//           _customerid = invoiceSnapshot['customerID'];
//           _paymentreceived = invoiceSnapshot["paymentReceived"].toString();
// _paymentdue = invoiceSnapshot["paymentDue"].toString();
// _tax = invoiceSnapshot['tax'].toString();
// _discount = invoiceSnapshot["discount"].toString();
// _totalamount = invoiceSnapshot["total amount"].toString();
// _totalbill = invoiceSnapshot["totalBill"].toString();
//         });
//       }
//     } catch (e) {
//       print("Error fetching invoice details: $e");
//     }
//   }

//   Future<void> _downloadInvoice() async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text('Invoice', style: pw.TextStyle(fontSize: 24)),
//             pw.SizedBox(height: 16),
//             pw.Text('Organisation: $_organisation'),
//             pw.Text('Invoice ID: $_invoiceId'),
//             pw.Text('Invoice Date: ${DateFormat.yMMMd().format(_invoiceDate!)}'),
//             // pw.Text('Due Date: ${DateFormat.yMMMd().format(_selectedDate!)}'),
//             pw.SizedBox(height: 16),
//             pw.Text('Customer Name: $_customerName'),
//             pw.Text('Customer Address: $_customerAddress'),
//             pw.Text('Customer Email: $_customerEmail'),
//             pw.Text('Customer Mobile: $_customerMobile'),
//             pw.SizedBox(height: 16),
//             pw.Text('Items:'),
//             ..._selectedItems.map((item) {
//               return pw.Text(
//                   'Name: ${item['itemName']}, Quantity: ${item['quantity']}, Price: ${item['price']}');
//             }).toList(),
//             pw.SizedBox(height: 16),
//             pw.Text('Tax: $_tax'),
//             pw.Text('Discount: $_discount'),
//             pw.Text('Total Amount: $_totalamount'),
//             pw.Text('Total Bill: $_totalbill'),
//             pw.Text('Payment Received: $_paymentreceived'),
//             pw.Text('Payment Due: $_paymentdue'),
//           ],
//         ),
//       ),
//     );

//     try {
//              final directory = await getTemporaryDirectory();
//      final file = File('${directory.path}/invoice_$_invoiceId.pdf');
//     await file.writeAsBytes(await pdf.save());
//     OpenFile.open(file.path);
//       print("success");
//     } catch (e) {
//       print('Error generating PDF: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Invoice"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Card(
//               elevation: 0.0,
//               shape: RoundedRectangleBorder(),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Center(
//                   child: Text(
//                     '$_organisation',
//                     style: const TextStyle(
//                       fontSize: 30.0,
//                       color: Colors.blue,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//             Card(
//               shape: RoundedRectangleBorder(),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.location_on, color: Colors.blue),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             _address ?? 'No Address Provided',
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             'GST No. ${_gst ?? 'No GST Provided'}',
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Icon(Icons.phone, color: Colors.blue),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             _mobile ?? 'No Mobile Provided',
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Card(
//               elevation: 0.0,
//               shape: RoundedRectangleBorder(),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Center(
//                   child: Row(
//                     children: [
//                       Text(
//                         ' $_customerName',
//                         style: const TextStyle(
//                           fontSize: 20.0,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(width: 8.0),
//                       IconButton(
//                         icon: Icon(Icons.info_outline, size: 20),
//                         color: Colors.black,
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: Text('Customer Details'),
//                                 content: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Name:',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text('$_customerName'),
//                                     SizedBox(height: 8.0),
//                                     const Text(
//                                       'Email:',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text('$_customerEmail'),
//                                     const SizedBox(height: 8.0),
//                                     const Text(
//                                       'Address:',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text('$_customerAddress'),
//                                     SizedBox(height: 8.0),
//                                     const Text(
//                                       'Phone:',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text('$_customerMobile'),
//                                   ],
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text('Close'),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text('Amount Received'),
//               subtitle: Text(
//                 '$_paymentreceived',
//                 style: TextStyle(fontSize: 16),
//               ),
//               trailing: Text('$_invoiceDate'),
//             ),
//             const Divider(thickness: 1, color: Colors.black),
//             Container(
//               child: ListTile(
//                 title: Text('InvoiceID : $_invoiceId'),
//               ),
//             ),
//             if (_selectedItems.isNotEmpty) ...[
//               const SizedBox(height: 16),
//               const Text(
//                 'Selected Items:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: _selectedItems.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(_selectedItems[index]['itemName']),
//                     subtitle: Text(
//                         'Quantity: ${_selectedItems[index]['quantity']}'),
//                     trailing: Text(
//                         'Price: ${_selectedItems[index]['price'].toStringAsFixed(2)}'),
//                   );
//                 },
//               ),
//             ],
//             const Divider(thickness: 1, color: Colors.black),
//             Container(
//               padding: EdgeInsets.all(18.0),
//               child: Column(
//             // children: [
//             //   _buildBox(title: 'Tax', value: '$_tax'),
//             //   _buildBox(title: 'Discount', value: '$_discount'),
//             //   _buildBox(title: 'Total Amount', value: '$_totalamount'),
//             //   _buildBox(title: 'Total Bill', value: '$_totalbill'),
//             //   _buildBox(title: 'Payment Received', value: '$_paymentreceived'),
//             //   _buildBox(title: 'Payment Due', value: '$_paymentdue'),
//             // ],
//           ),
//         ),
//             const SizedBox(height: 16),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.blue, width: 2),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: ElevatedButton(
//                 onPressed: _downloadInvoice,
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                 ),
//                 child: const Text(
//                   'Download Invoice',
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBox({required String title, required String value}) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 4.0),
//       padding: EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Text(value),
//         ],
//       ),
//     );
//   }
// }
