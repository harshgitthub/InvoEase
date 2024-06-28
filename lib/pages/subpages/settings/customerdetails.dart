import 'package:cloneapp/pages/invoiceadd.dart';
import 'package:cloneapp/pages/items.dart';
import 'package:cloneapp/pages/subpages/settings/invoicedetails.dart';
import 'package:cloneapp/pages/subpages/settings/invoicedraft.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class CustomerDetails extends StatefulWidget {
  final Map<String, dynamic> customerData;

  const CustomerDetails({super.key, required this.customerData});

  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  late TextEditingController paymentReceivedController;
  late TextEditingController paymentTotalController;
  final FirestoreService _firestoreService = FirestoreService();
  List<Invoice> _invoices = [];

  @override
  void initState() {
    super.initState();
    paymentReceivedController = TextEditingController(text: widget.customerData["PaymentReceived"]?.toString() ?? "");
    paymentTotalController = TextEditingController(text: widget.customerData["PaymentTotal"]?.toString() ?? "");
    _fetchInvoices(); // Fetch invoices when the widget initializes
  }

  Future<void> _fetchInvoices() async {
    final List<Invoice> invoices = await _firestoreService.getInvoicesByCustomerId(widget.customerData['customerID']);
    setState(() {
      _invoices = invoices;
    });
  }

  @override
  void dispose() {
    paymentReceivedController.dispose();
    paymentTotalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Customer Details'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvoiceAdd(customerID: widget!.customerData["customerID"])
                  ),
                );
              },
              icon: const Icon(Icons.add_box),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Customeredit(customerData: widget.customerData),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _fetchInvoices,
          child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.customerData["Salutation"]} ${widget.customerData["First Name"]} ${widget.customerData["Last Name"]}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Phone: ${widget.customerData["Mobile"]}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Email: ${widget.customerData["Email"]}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Address: ${widget.customerData["Address"]}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 2),
              const TabBar(
                tabs: [
                  Tab(text: 'Payment Details'),
                  Tab(text: 'Remarks'),
                  Tab(text: 'Invoices'),  // Updated tab text
                ],
              ),
              Container(
                height: 400, // Adjust the height as needed
                child: TabBarView(
                  children: [
                    _buildPaymentDetails(),
                    _buildRemarks(),
                    _buildInvoices(),  // Updated to display invoices
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }

  Widget _buildPaymentDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Details:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Payment Received:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      
                      controller: paymentReceivedController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                      hintText: '00.00',
                      hintStyle: TextStyle(fontWeight: FontWeight.w800 , color: Colors.grey , fontSize: 26)
                       , border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.0, color: Colors.white),
            ), 
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Payment Total:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                   TextFormField(
                   controller: paymentTotalController,
                    keyboardType: TextInputType.number,
                   decoration: const InputDecoration(
                 hintText: '00.00',
               hintStyle: TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 26),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.0, color: Colors.white),
            ), 
            
          // Add a border to match the style of the other TextFormField
  ),
),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRemarks() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Remarks:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.customerData["Remarks"] ?? 'No remarks available.',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoices() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Invoices',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
         Expanded(
  child: ListView.builder(
    itemCount: _invoices.length,
    itemBuilder: (context, index) {
      final invoice = _invoices[index];
      return ListTile(
        title: Text('Invoice ID: ${invoice.id}'),
        subtitle: Text('Created At: ${invoice.invoiceDate}'),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            // Navigate to another screen or perform an action
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  Invoicedraft(invoiceId: invoice.id), // Replace with your screen
              ),
            );
          },
        ),
      );
    },
  ),
)

        ],
      ),
    );
  }
}

class Customeredit extends StatefulWidget {
  final Map<String, dynamic> customerData;

  const Customeredit({super.key, required this.customerData});

  @override
  _CustomereditState createState() => _CustomereditState();
}

class _CustomereditState extends State<Customeredit> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController salutationController = TextEditingController();
  final TextEditingController workphoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
    final TextEditingController salespersonController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();


  @override
  void initState() {
    super.initState();
    salutationController.text = widget.customerData["Salutation"];
    firstNameController.text = widget.customerData["First Name"];
    lastNameController.text = widget.customerData["Last Name"];
    emailController.text = widget.customerData["Email"];
    mobileController.text = widget.customerData["Mobile"].toString();
    workphoneController.text = widget.customerData["Work-phone"].toString();
    addressController.text = widget.customerData["Address"];
       remarksController.text =widget.customerData["Remarks"];
    salespersonController.text = widget.customerData["Salesperson"];
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    salutationController.dispose();
    workphoneController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Customer"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
  children: <Widget>[
    
               Text(
        'CustomerID:${widget.customerData["customerID"]}', // Display customer ID
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    const SizedBox(width: 45,),
    Text(
  '${DateFormat('dd-MM-yyyy').format(widget.customerData["timestamp"].toDate())}',
  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
),
  ]
               ),
             const SizedBox(height: 10,),
              const Text(
                'Customer Name: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: salutationController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Salutation',
                          contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First Name',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Last Name',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
               const Text(
                'Customer Contact:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                   Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mobile',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: workphoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Work Phone',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                 
                ],
              ),
              const Text(
                'Customer Email:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Customer Address:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Address',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
             
                  const SizedBox(height: 20),
               const Text(
                'Remarks:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: remarksController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'not to be printed',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
                
              const SizedBox(height: 20),
               const Text(
                'Sales Person:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller:salespersonController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Sales Person',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
              
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("USERS")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("customers")
                          .doc(widget.customerData["customerID"])
                          .update({
                        "Salutation": salutationController.text,
                        "First Name": firstNameController.text,
                        "Last Name": lastNameController.text,
                        "Email": emailController.text,
                        "Work-phone": int.tryParse(workphoneController.text) ?? workphoneController.text,
                        "Mobile": int.tryParse(mobileController.text) ?? mobileController.text,
                        "Address":addressController.text,
                  "Remarks":remarksController.text,
                  "Salesperson":salespersonController.text,  

                      });

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.black,
                          content: Text("Updated the details"),
                        ),
                      );
                      Navigator.pushNamed(context, '/customeradd');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Update', style: TextStyle(color: Colors.white)),
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



class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addInvoice(Invoice invoice) async {
       await _db.collection('USERS').doc(userId).collection('invoices').doc(invoice.id).set(invoice.toMap());
  }

  Future<List<Invoice>> getInvoicesByCustomerId(String customerID) async {
    QuerySnapshot querySnapshot = await _db
          .collection('USERS')
        .doc(userId)
        .collection('invoices')
        .where('customerID', isEqualTo: customerID)
        .get();
    return querySnapshot.docs.map((doc) {
      return Invoice.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}

class Invoice {
  final String id;
  final String customerID;
  final DateTime invoiceDate;
  // final double amount;

  Invoice({
    required this.id,
    required this.customerID,
    required this.invoiceDate,
    // required this.amount,
  });

  factory Invoice.fromMap(Map<String, dynamic> data, String documentId) {
    return Invoice(
      id: documentId,
      customerID: data['customerID'] ?? '',
      invoiceDate: (data['invoiceDate'] as Timestamp).toDate(),
      // amount: data['amount']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerID': customerID,
      'invoiceDate': invoiceDate,
      // 'amount': amount,
    };
  }
}



// class _CustomerDetailsState extends State<CustomerDetails> {
//   late TextEditingController paymentReceivedController;
//   late TextEditingController paymentTotalController;

//   @override
//   void initState() {
//     super.initState();
//     paymentReceivedController = TextEditingController(text: widget.customerData["PaymentReceived"]?.toString() ?? "");
//     paymentTotalController = TextEditingController(text: widget.customerData["PaymentTotal"]?.toString() ?? "");
//   }

//   @override
//   void dispose() {
//     paymentReceivedController.dispose();
//     paymentTotalController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Customer Details'),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Invoicedetails(customerData: widget.customerData),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.add_box),
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Customeredit(customerData: widget.customerData),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.edit),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${widget.customerData["Salutation"]} ${widget.customerData["First Name"]} ${widget.customerData["Last Name"]}',
//                       style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Phone: ${widget.customerData["Mobile"]}',
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Email: ${widget.customerData["Email"]}',
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Address: ${widget.customerData["Address"]}',
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(thickness: 2),
//               const TabBar(
//                 tabs: [
//                   Tab(text: 'Payment Details'),
//                   Tab(text: 'Remarks'),
//                   Tab(text: 'Other'),
//                 ],
//               ),
//               Container(
//                 height: 400, // Adjust the height as needed
//                 child: TabBarView(
//                   children: [
//                     _buildPaymentDetails(),
//                     _buildRemarks(),
//                     _buildOther(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// Widget _buildPaymentDetails() {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Payment Details:',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Payment Received:',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: paymentReceivedController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       labelText: 'Payment Received',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Payment Total:',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: paymentTotalController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       labelText: 'Payment Total',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }


//   Widget _buildRemarks() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Remarks:',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             widget.customerData["Remarks"] ?? 'No remarks available.',
//             style: const TextStyle(fontSize: 18),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOther() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Other Information:',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Customer ID: ${widget.customerData["customerID"]}',
//             style: const TextStyle(fontSize: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }