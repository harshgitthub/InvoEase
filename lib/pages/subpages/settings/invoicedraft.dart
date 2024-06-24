

import 'dart:math';

import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/invoiceadd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Map<String, dynamic>? invoiceData;

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
          invoiceData = invoiceSnapshot.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error fetching invoice data: $e");
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
        title: Text("Invoice Draft"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InvoiceEdit(
                    invoiceId: widget.invoiceId,
                    customerID: invoiceData!['customerID'],
                  ),
                ),
              );
            },
          ),
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

           PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              // Menu items
              PopupMenuItem<String>(
                value: 'customer',
                child: ListTile(
                  leading: Icon(Icons.people),
                  title: Text('New Customer'),
                ),
              ),
              
              PopupMenuItem<String>(
                value: 'proceed_payment',
                child: ListTile(
                  leading: Icon(Icons.payment),
                  title: Text('Proceed to Payment'),
                ),
              ),
              PopupMenuItem<String>(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('edit invoice'),
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
                case 'proceed_payment':
                  // Proceed to payment action
                  print('Proceed to payment');
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
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
               _buildDetailItem(
              'Invoice Date',
              DateFormat('dd-MM-yyyy').format((invoiceData!['invoiceDate'] as Timestamp).toDate()),
            ),
              Text(
                invoiceData!['customerName'],
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 25),
              Text(
                'Balance : ${invoiceData!['totalBill'] ?? '00.00'}',
                style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),

              ),
              Text( statusText,
                          style:  TextStyle( color: statusColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Container(
          constraints: BoxConstraints.expand(height: 50),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child:const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(child:  Text('Details' ,style:TextStyle( fontSize: 20 , color:  Colors.white, fontWeight: FontWeight.bold) ,)),
              Tab(child: Text( 'Payment' ,style:TextStyle( fontSize: 20 ,color:  Colors.white,fontWeight: FontWeight.bold) ,)),
              Tab(child:Text( 'History',style:TextStyle( fontSize: 20 ,color:  Colors.white, fontWeight: FontWeight.bold) ,)),
          
            ],
          ),
        ),
        Expanded(
  child: TabBarView(
    children: [
      // Details Tab
      SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
_buildDetailItem('Customer Name', invoiceData!['customerName'] ?? ''),
const SizedBox(width: 10,),
     IconButton(
                icon: Icon(_showDetails ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                onPressed: () {
                  setState(() {
                    _showDetails = !_showDetails; // Toggle details visibility
                  });
                },
              ),
              ],
            ),
            // Details items like customer info, invoice details, items list, totals

            Visibility(// Initially hidden
            visible: _showDetails,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                _buildDetailItem('Customer Address', invoiceData!['customerAddress'] ?? ''),
            _buildDetailItem('Customer Email', invoiceData!['customerEmail'] ?? ''),
            _buildDetailItem('Work Phone', invoiceData!['workphone'] ?? ''),
            _buildDetailItem('Mobile', invoiceData!['mobile'] ?? ''),
            
                ],
              ),
            ),

            if (invoiceData!['dueDate'] != null)
              _buildDetailItem(
                'Due Date',
                DateFormat('dd-MM-yyyy').format((invoiceData!['dueDate'] as Timestamp).toDate()),
              ),
         
            
            const Divider(thickness: 1, color: Colors.grey),
            
            Text(
              'Items:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              child: 
            
            ListView.builder(
              shrinkWrap: true,
              itemCount: (invoiceData!['items'] as List).length,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = (invoiceData!['items'] as List)[index];
                return SingleChildScrollView(
                  child: 
                ListTile(

                  title:Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['itemName'],
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ],
      ),
    ),
    
    Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${item['quantity']} X ${item['rate']}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
    Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${item['price'].toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
  ],
)

                  ,
                  )
                );
              },
            ),
            ),
            
            const Divider(thickness: 1, color: Colors.grey),
           _buildDetailItemForDouble('SubTotal', invoiceData!['total amount'] ?? 0.0),
_buildDetailItemFor('Discount %', invoiceData!['discount'] ?? 0.0),
                SizedBox(width: 60),
                _buildDetailItemFor('Tax %', invoiceData!['tax'] ?? 0.0),
                
                SizedBox(width: 60),
                _buildDetailItemForDouble('Total', invoiceData!['totalBill'] ?? 0.0),
                 _buildDetailItemForDouble('Due', invoiceData!['totalBill'] ?? 0.0 ,),
        
                
        
          ]   
        )
        ),
      
      // Payments Tab (Placeholder)
      SingleChildScrollView(
        child: Column(
          children: [
            _buildDetailItem('Payment Method', invoiceData!['paymentMethod'] ?? ''),
          ],
        ),
      )
,      
      // History Tab (Placeholder)
      Center(
        child: Text('History tab content', style: TextStyle(fontSize: 20)),
      ),
    ],
  ),
)

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
       Text(value , style:  TextStyle( fontSize: 20 , fontWeight: FontWeight.bold),)
      ],
    );
  }
}

Widget _buildDetailItemForDouble(String title, double value) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 2 , right: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end
      ),
    ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 18),
            ),
          ),
         
          Expanded(
            flex: 1,
            child: Text(value.toStringAsFixed(2), style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w700),),
          ),
        ],
      ),
    );
  }
  
Widget _buildDetailItemFor(String title, double value) {
    return Padding(
      padding: const EdgeInsets.only(left: 20 , top: 2 , right: 25),
      child: Row(
       crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end
      ),
    ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle( fontSize: 18),
            ),
          ),
          
          Expanded(
            flex: 1,
            child: Text(value.toStringAsFixed(2), style: TextStyle(fontSize: 18 , ),),
          ),
        ],
      ),
    );
  }

// class DetailsDropdown extends StatefulWidget {
//   @override
//   _DetailsDropdownState createState() => _DetailsDropdownState();
// }

// class _DetailsDropdownState extends State<DetailsDropdown> {
//   // Start with details hidden
//   bool _showDetails =false;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(_showDetails ? Icons.arrow_drop_up : Icons.arrow_drop_down),
//       onPressed: () {
//         setState(() {
//         _showDetails = !_showDetails; // Toggle the visibility state
//         });
//       },
//     );
//   }
// }

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
        });
      }
    } catch (e) {
      print("Error fetching invoice details: $e");
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
        "dueDate": _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
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
                    onTap: _selectDueDate,
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
}
