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
  TextEditingController _paymentdue = TextEditingController();
  TextEditingController _paymentreceived  = TextEditingController();

  Map<String, dynamic>? invoiceData;

  @override
  void initState() {
    super.initState();
    fetchInvoiceData();
    _updatePaymentDue();
    _paymentreceived.addListener(_updatePaymentDue);
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
        _paymentreceived.text = invoiceData!['paymentReceived']?? '';
        _paymentdue.text = invoiceData!['paymentDue']?? '';
        _updatePaymentDue();
        });
      }
    } catch (e) {
      print("Error fetching invoice data: $e");
    }
  }
  void _updatePaymentDue() {
  if (invoiceData != null && invoiceData!['totalBill'] != null) {
    double total = invoiceData!['totalBill'];
    double received = double.tryParse(_paymentreceived.text) ?? 0.0;
    double dues = total - received;
    _paymentdue.text = dues.toStringAsFixed(2);
  }
}

Future<void> savePaymentDetails() async {
  try {
    double received = double.parse(_paymentreceived.text);
    double due = double.parse(_paymentdue.text);

    await FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentuser!.uid)
        .collection('invoices')
        .doc(widget.invoiceId)
        .update({
          'paymentReceived': received,
          'paymentDue': due,
        });

  
        showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Invoice saved successfully'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
             onPressed: () {
    fetchInvoiceData().then((_) {
      Navigator.pop(context); // This will pop the current screen off the stack
    }).catchError((error) {
      print("Error fetching invoice data: $error");
    });
  },
            ),
          ],
        ),
      );
        print("success");
  }
  catch(e){
    print(" ERROR ");
  }
}

  Future<void> _makePhoneCall() async {
    dynamic mobile = invoiceData!['mobile'];

    if (mobile is int) {
      String phoneNumber = mobile.toString();
      String url = 'tel:$phoneNumber';
      await _launchURL(url);
    } else {
      throw 'Phone number not available';
    }
  }

  Future<void> _sendMessage() async {
    dynamic mobile = invoiceData!['Work-Phone'];

    if (mobile is int) {
      String phoneNumber = mobile.toString();
      String url = 'sms:$phoneNumber';
      await _launchURL(url);
    } else if (mobile is String) {
      String url = 'sms:$mobile';
      await _launchURL(url);
    } else {
      throw 'Mobile number is not available or not valid';
    }
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
     bool isPaid = invoiceData!['status'];
    String statusText = isPaid ? 'PAID' : 'UNPAID';
    Color statusColor = isPaid ? Colors.green : Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Draft"),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.edit),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => InvoiceEdit(
          //           invoiceId: widget.invoiceId,
          //           customerID: invoiceData!['customerID'],
          //         ),
          //       ),
          //     );
          //   },
          // ),
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
              // Menu items
          const    PopupMenuItem<String>(
                value: 'customer',
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('New Customer'),
                ),
              ),
         const    PopupMenuItem<String>(
                value: 'invoice',
                child: ListTile(
                  leading: Icon(Icons.add),
                  title: Text('New Invoice'),
                ),
              ),
              
           const    PopupMenuItem<String>(
                value: 'proceed_payment',
                child: ListTile(
                  leading: Icon(Icons.payment),
                  title: Text('Get Invoice'),
                ),
              ),
           const  PopupMenuItem<String>(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('edit invoice'),
                ),
              ),
                  
           const    PopupMenuItem<String>(
                value: 'edit_customer',
                child: ListTile(
                  leading: Icon(Icons.edit_document),
                  title: Text('Edit Customer'),
                ),
              ),
            ],
            onSelected: (String value) {
              // Handle menu item selection
              switch (value) {
                case 'customer':
                  // Navigate to customer screen or perform related action
                  Navigator.pushNamed(context, '/customer');
                  break;

                case 'invoice':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvoiceAdd(customerID: invoiceData!['customerID'],)
                  ),   
                  );
                  break;
                case 'edit':
                  // Add new invoice action
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
                 
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Customeredit( customerData: invoiceData, ),
              //     ),
              // );
                  break;
                case 'proceed_payment':
                  // Proceed to payment action
                   Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PreviewBill(invoiceId: widget.invoiceId,)
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
                    _buildDetailItem(
                      'Invoice Date',
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
                      'Balance : ${invoiceData!["paymentDue"]}',
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
                constraints: const BoxConstraints.expand(height: 50),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: const TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.white,
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
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Details Tab
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
                                        !_showDetails; // Toggle details visibility
                                  });
                                },
                              ),
                            ],
                          ),
                          Visibility(
                            visible: _showDetails,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                          if (invoiceData!['dueDate'] != null)
                            _buildDetailItem(
                              'Due Date',
                              DateFormat('dd-MM-yyyy').format(
                                  (invoiceData!['dueDate'] as Timestamp)
                                      .toDate()),
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: (invoiceData!['items'] as List).length,
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
                                                fontWeight: FontWeight.w500,
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
                                            '${item['price'].toStringAsFixed(2)}',
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
                          _buildDetailItemForDouble('SubTotal',
                              invoiceData!['total amount'] ?? 0.0),
                          _buildDetailItemFor('Discount %',
                              invoiceData!['discount'] ?? 0.0),
                          _buildDetailItemFor('Tax %',
                              invoiceData!['tax'] ?? 0.0),
                          _buildDetailItemForDouble('Total',
                              invoiceData!['totalBill'] ?? 0.0),
                          Text('Due ${ invoiceData!['paymentDue']}')
                              
                        ],
                      ),
                    ),
                    // Payments Tab
                    SingleChildScrollView(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildDetailItem('Payment Method', invoiceData!['paymentMethod'] ?? ''),
      const SizedBox(height: 20), // Adding space between items
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _paymentreceived,
              decoration: const InputDecoration(
                labelText: 'Payment Received',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _paymentdue,
              decoration: const InputDecoration(
                labelText: 'Payment Due',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              readOnly: true, // Make this field read-only
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await savePaymentDetails();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // Change to your preferred color
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
                    // History Tab
                    const SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'History tab content',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        )
    );
  }

Widget _buildDetailItem(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ],
  );
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
  }
  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text(value , style:  const TextStyle( fontSize: 20 , fontWeight: FontWeight.bold),)
      ],
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
                Navigator.of(context).pop(); // Pop InvoiceEdit screen
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
