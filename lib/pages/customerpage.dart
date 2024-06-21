import 'dart:async';
import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/subpages/settings/customerdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Customerpage extends StatefulWidget {
  const Customerpage({Key? key}) : super(key: key);

  @override
  State<Customerpage> createState() => _CustomerpageState();
}

class _CustomerpageState extends State<Customerpage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
   String selectedSort = 'Entry Time';

  Future<void> _makePhoneCall(String docId) async {
    try {
      if (currentUser == null) {
        throw 'User not logged in';
      }

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("customers")
          .doc(docId)
          .get();

      if (customerSnapshot.exists) {
        Map<String, dynamic>? customerData =
            customerSnapshot.data() as Map<String, dynamic>?;

        if (customerData != null) {
          dynamic mobile = customerData['Mobile'];

          if (mobile is int) {
            String phoneNumber = mobile.toString();
            String url = 'tel:$phoneNumber';
            await _launchURL(url);
          } else {
            throw 'Phone number not available';
          }
        } else {
          throw 'Customer data not available';
        }
      } else {
        throw 'Customer not found';
      }
    } catch (e) {
      print('Error in _makePhoneCall: $e');
    }
  }

  Future<void> _sendWhatsApp(String docId) async {
    try {
      if (currentUser == null) {
        throw 'User not logged in';
      }

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("customers")
          .doc(docId)
          .get();

      if (customerSnapshot.exists) {
        Map<String, dynamic>? customerData =
            customerSnapshot.data() as Map<String, dynamic>?;

        if (customerData != null) {
          dynamic mobile = customerData['Mobile'];

          if (mobile is int) {
            String phoneNumber = mobile.toString();
            String url = 'https://wa.me/$phoneNumber';
            await _launchURL(url);
          } else {
            throw 'Phone number not available';
          }
        } else {
          throw 'Customer data not available';
        }
      } else {
        throw 'Customer not found';
      }
    } catch (e) {
      print('Error in _sendWhatsApp: $e');
    }
  }

  Future<void> _sendMessage(String docId) async {
    try {
      if (currentUser == null) {
        throw 'User not logged in';
      }

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("customers")
          .doc(docId)
          .get();

      if (customerSnapshot.exists) {
        Map<String, dynamic>? customerData =
            customerSnapshot.data() as Map<String, dynamic>?;

        if (customerData != null) {
          dynamic mobile = customerData['Mobile'];

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
        } else {
          throw 'Customer data not available';
        }
      } else {
        throw 'Customer not found';
      }
    } catch (e) {
      print('Error in _sendMessage: $e');
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

  Future<void> _deleteCustomer(String docId, BuildContext context) async {
  // Show warning dialog and wait for user confirmation
  bool shouldDelete = await showWarning(context);

  // If the user confirmed the deletion, proceed with deleting the customer document
  if (shouldDelete) {
    await FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentUser!.uid)
        .collection("customers")
        .doc(docId)
        .delete();
  }
}

Future<bool> showWarning(BuildContext context) async {
  // Completer to signal the result of the dialog
  Completer<bool> completer = Completer<bool>();

  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            completer.complete(false); // Signal that the deletion should not proceed
          },
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            completer.complete(true); // Signal that the deletion should proceed
          },
        ),
      ],
    ),
  );

  // Wait for the dialog to be closed and the result to be returned
  return completer.future;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.pushNamed(context, '/customer');
            },
            tooltip: "Add customer",
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              _showSortOptions();
            },
          ),
        ],
      ),
      drawer: drawer(context), // Use your drawer widget here
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("USERS")
            .doc(currentUser!.uid)
            .collection("customers")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching data"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No customers found"));
          }
           List<DocumentSnapshot> documents = snapshot.data!.docs;

          switch (selectedSort) {
            case 'Customer Name':
              documents.sort((a, b) =>
                  (a['First Name'] ?? '').compareTo(b['First Name'] ?? ''));
              break;
            case 'Entry Time':
              documents.sort((a, b) =>
                  (a['timestamp'] as Timestamp).compareTo(b['timestamp'] as Timestamp));
              break;
            default:
              // Default sorting
               documents.sort((a, b) =>
                  (a['timestamp'] as Timestamp).compareTo(b['timestamp'] as Timestamp));
          }

       return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var doc = documents[index];
               Map<String, dynamic>? customerData = doc.data() as Map<String, dynamic>?;
     return InkWell(
      onTap: () {
        // Handle the tap event here
       Navigator.push(
  context,
   MaterialPageRoute(
              builder: (context) => CustomerDetails(customerData: customerData!),
  ),
);
      },
    

    child:  ListTile(
  contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
  subtitle: Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${doc["Salutation"] ?? ''} ${doc["First Name"] ?? ''} ${doc["Last Name"] ?? ''}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            Text(
              ""  " ${doc["customerID"] ?? ''}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              ""  " ${DateFormat.yMMMd().format((doc["timestamp"] as Timestamp).toDate())}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            Text(
              ""  " ${doc["Mobile"] ?? ''}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            Text(
              ""  " ${doc["Email"] ?? ''}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.blue, size: 22),
            onPressed: () => _makePhoneCall(doc.id),
          ),
          IconButton(
            icon: const Icon(Icons.message, color: Colors.blue, size: 22),
            onPressed: () => _sendMessage(doc.id),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Customeredit(customerData: doc),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Color.fromARGB(255, 17, 14, 14), size: 22),
            onPressed: () => _deleteCustomer(doc.id, context),
          ),
        ],
      ),
    ],
  ),
)
    );
  },
);
},
      ),
    );
  }

 void _showSortOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sort Options'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                RadioListTile<String>(
                  title: const Text('Customer Name'),
                  value: 'Customer Name',
                  groupValue: selectedSort,
                  onChanged: (value) {
                    setState(() {
                      selectedSort = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Date'),
                  value: 'Entry Time',
                  groupValue: selectedSort,
                  onChanged: (value) {
                    setState(() {
                      selectedSort = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Customeredit extends StatelessWidget {
  final DocumentSnapshot customerData;

  Customeredit({required this.customerData});

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
  Widget build(BuildContext context) {
    salutationController.text = customerData["Salutation"];
    firstNameController.text = customerData["First Name"];
    lastNameController.text = customerData["Last Name"];
    emailController.text = customerData["Email"];
    mobileController.text = customerData["Mobile"].toString();
    workphoneController.text = customerData["Work-phone"].toString();
    addressController.text = customerData["Address"];
    remarksController.text = customerData["Remarks"];
    salespersonController.text = customerData["Salesperson"];

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
      'CustomerID: ${customerData["customerID"]}', // Display customer ID
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    const SizedBox(width: 45,),
   Text(
  'Date: ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
),
  ]),
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
                    .doc(customerData.id)
                    .update({
                  "Salutation":salutationController.text,
                  "First Name": firstNameController.text,
                  "Last Name": lastNameController.text,
                  "Email": emailController.text,
                  "Work-phone":int.tryParse(workphoneController.text) ?? workphoneController.text,
                  "Mobile": int.tryParse(mobileController.text) ?? mobileController.text,
                  "Address":addressController.text,
                  "Remarks":remarksController.text,
                  "Salesperson":salespersonController.text,  
                                } );

                Navigator.pop(context);
                 ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Updated the details"),
        ),
      );
                Navigator.pushNamed(context,'/customeradd');
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
            ]
      ),
      )
      )
    );
  }
}


    // return ListView.builder(
          //   padding: EdgeInsets.all(10.0),
          //   itemCount: filteredDocs.length,
          //   itemBuilder: (context, index) {
          //     var doc = filteredDocs[index];

          //     return Card(
          //       margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
          //       elevation: 5,
          //       child: ListTile(
          //         contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          //         title: Text(
          //           "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
          //           style: const TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black,
          //             fontSize: 20,
          //           ),
          //         ),
          //         subtitle: Padding(
          //           padding: const EdgeInsets.only(top: 5.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "${doc["Email"]}",
          //                 style: const TextStyle(
          //                   color: Colors.blue,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               const SizedBox(height: 5),
          //               Text(
          //                 "Work-phone: ${doc["Work-phone"]}",
          //                 style: const TextStyle(
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               const SizedBox(height: 2),
          //               Text(
          //                 "Other Number: ${doc["Mobile"]}",
          //                 style: const TextStyle(
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         trailing: Wrap(
          //           spacing: 8.0,
          //           direction: Axis.vertical,
          //           children: [
          //             IconButton(
          //               icon: const Icon(Icons.phone, color: Colors.green, size: 25),
          //               onPressed: () => _makePhoneCall(doc.id),
          //             ),
          //             IconButton(
          //               icon: const Icon(Icons.message, color: Colors.blue, size: 25),
          //               onPressed: () => _sendMessage(doc.id),
          //             ),
          //             IconButton(
          //               icon: const Icon(Icons.edit, color: Colors.blue, size: 25),
          //               onPressed: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) => Customeredit(customerData: doc),
          //                   ),
          //                 );
          //               },
          //             ),
          //             IconButton(
          //               icon: const Icon(Icons.delete, color: Colors.red, size: 25),
          //               onPressed: () => _deleteCustomer(doc.id),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // );

