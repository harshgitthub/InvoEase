import 'package:cloneapp/pages/items.dart';
import 'package:cloneapp/pages/subpages/settings/invoicedetails.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class CustomerDetails extends StatefulWidget {
  final Map<String, dynamic> customerData;

  const CustomerDetails({Key? key, required this.customerData}) : super(key: key);

  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  late TextEditingController paymentReceivedController;
  late TextEditingController paymentTotalController;

  @override
  void initState() {
    super.initState();
    paymentReceivedController = TextEditingController(text: widget.customerData["PaymentReceived"]?.toString() ?? "");
    paymentTotalController = TextEditingController(text: widget.customerData["PaymentTotal"]?.toString() ?? "");
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
                    builder: (context) => Invoicedetails(customerData: widget.customerData),
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
        body: SingleChildScrollView(
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
                  Tab(text: 'Other'),
                ],
              ),
              Container(
                height: 400, // Adjust the height as needed
                child: TabBarView(
                  children: [
                    _buildPaymentDetails(),
                    _buildRemarks(),
                    _buildOther(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      labelText: 'Payment Received',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      labelText: 'Payment Total',
                      border: OutlineInputBorder(),
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

  Widget _buildOther() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Other Information:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Customer ID: ${widget.customerData["customerID"]}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}


class Customeredit extends StatefulWidget {
  final Map<String, dynamic> customerData;

  const Customeredit({Key? key, required this.customerData}) : super(key: key);

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
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    const SizedBox(width: 45,),
    Text(
  'Date: ${DateFormat('dd-MM-yyyy').format(widget.customerData["timestamp"].toDate())}',
  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
