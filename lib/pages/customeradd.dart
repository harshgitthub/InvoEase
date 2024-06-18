// import 'dart:math';

// import 'package:cloneapp/pages/home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// class Customeradd extends StatefulWidget {
//   const Customeradd({super.key});

//   @override
//   State<Customeradd> createState() => _CustomeraddState();
// }

// class _CustomeraddState extends State<Customeradd> {
//   final _salutation = TextEditingController();
//   final _firstname = TextEditingController();
//   final _lastname = TextEditingController();
//   final _email = TextEditingController();
//   final _workphone = TextEditingController();
//   final _mobile = TextEditingController();
//   final _address = TextEditingController();
//   String _customerId = ''; 

//   var currentuser = FirebaseAuth.instance.currentUser;

//   customer(String? salutation, String? firstname, String? lastname, String? email,String? address ,  int? workphone, int? mobile) async {
//     if (mobile == null || email == null || lastname == null || salutation == null || workphone == null) {
//       print("Please enter required fields");
//     } else {
//       try {
//         await FirebaseFirestore.instance
//   .collection("USERS")
//   .doc(currentuser!.uid)
//   .collection("customers")
  
//   .add({
//           "Salutation": salutation,
//           "First Name": firstname,
//           "Last Name": lastname,
//           "Email": email,
//           "Work-phone": workphone,
//           "Mobile": mobile,
//           "Address":address,
//           "customerID":_customerId
//         });
//         print("Data entered successfully");
//         _salutation.clear();
//         _firstname.clear();
//         _lastname.clear();
//         _email.clear();
//         _workphone.clear();
//         _mobile.clear();
//         _address.clear();

//      showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Success'),
//           content: const Text('Customer entered successfully'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.pushNamed(context, '/customeradd');
//               },
//             ),
//           ],
//         ),
//       );


//       } catch (e) {
//         print("Error: $e");
//       }
//     }
//   }

// @override
//   void initState() {
//    _generateCustomerId();
//     super.initState();
//   }


  // void _generateCustomerId() {
  //   const length = 6;
  //   const chars = 'ABC1234';
  //   final random = Random();
  //   setState(() {
  //     _customerId = String.fromCharCodes(Iterable.generate(
  //         length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  //   });
  // }

//   @override
//   void dispose() {
//     _email.dispose();
//     _firstname.dispose();
//     _lastname.dispose();
//     _workphone.dispose();
//     _mobile.dispose();
//     _address.dispose();
//     _salutation.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Customer"),
//       ),
//       drawer: drawer(context),
//       body: SingleChildScrollView(
//         child: 
//       Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Customer Name:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                     child: TextFormField(
//                       controller: _salutation,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Salutation',
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                     child: TextFormField(
//                       controller: _firstname,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'First Name',
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                     child: TextFormField(
//                       controller: _lastname,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Last Name',
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Customer Email:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: TextFormField(
//                 controller: _email,
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Email',
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Customer Address:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: TextFormField(
//                 controller: _address,
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Address',
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Customer Phone:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                     child: TextFormField(
//                       controller: _workphone,
//                       keyboardType: TextInputType.phone, // Set keyboard type to phone
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Work Phone',
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                     child: TextFormField(
//                       controller: _mobile,
//                       keyboardType: TextInputType.phone, // Set keyboard type to phone
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Mobile',
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     customer(
//                       _salutation.text,
//                       _firstname.text,
//                       _lastname.text,
//                       _email.text,
//                       _address.text,
//                       int.tryParse(_workphone.text),
//                       int.tryParse(_mobile.text),
//                     );
//                     Navigator.pushNamed(context, '/customeradd');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: const Text('Save', style: TextStyle(color: Colors.white)),
//                 ),
//                 const SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     _salutation.clear();
//                     _firstname.clear();
//                     _lastname.clear();
//                     _email.clear();
//                     _address.clear();
//                     _workphone.clear();
//                     _mobile.clear();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: const Text('Cancel', style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       )
//     );
//   }
// }




import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Customeradd extends StatefulWidget {
  final DocumentSnapshot? customerData;

  const Customeradd({super.key, this.customerData});

  @override
  State<Customeradd> createState() => _CustomeraddState();
}

class _CustomeraddState extends State<Customeradd> {
   final _formKey = GlobalKey<FormState>();
  final _salutation = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _email = TextEditingController();
  final _workphone = TextEditingController();
  final _mobile = TextEditingController();
  final _address = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser;
  String _customerID ='';
  

  @override
  void initState() {
    super.initState();
    _generateCustomerId();
    // _saveCustomer();
    // _showErrorDialog("Some Error Occured");
  }

  Future<void> _saveCustomer() async {
    String? salutation = _salutation.text.trim();
    String? firstname = _firstname.text.trim();
    String? lastname = _lastname.text.trim();
    String? email = _email.text.trim();
    String? address = _address.text.trim();
    int? workphone = int.tryParse(_workphone.text.trim());
    int? mobile = int.tryParse(_mobile.text.trim());

    if (
        firstname == "" ||
        lastname == "" ||
        mobile==null
         ) {
          _showErrorDialog("fill the first name , last name anf mobile fields");
      return;
    }

    try {
      CollectionReference customersCollection = FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("customers");

      
        await customersCollection.add({
          "Salutation": salutation,
          "First Name": firstname,
          "Last Name": lastname,
          "Email": email,
          "Work-phone": workphone,
          "Mobile": mobile,
          "Address": address,
          "customerID":_customerID,
        });
      // } else {
      //   await customersCollection
      //       .doc(widget.customerData!.id)
      //       .update({
      //         "Salutation": salutation,
      //         "First Name": firstname,
      //         "Last Name": lastname,
      //         "Email": email,
      //         "Work-phone": workphone,
      //         "Mobile": mobile,
      //         "Address": address,
      //         "customer":_customerID,
      //       })
      //       .then((value) => print("Customer updated"))
      //       .catchError((error) => print("Failed to update customer: $error"));
      // }

      // Clear text fields after saving
      _salutation.clear();
      _firstname.clear();
      _lastname.clear();
      _email.clear();
      _workphone.clear();
      _mobile.clear();
      _address.clear();

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Customer data saved successfully'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/customeradd');
              },
            ),
          ],
        ),
      );
    } catch (e) {
      print("Error: $e");
      // Handle error, show error dialog or snackbar
    }
  }
  
  
  
  void _generateCustomerId() {
    const length = 6;
    const chars = 'ABC1234';
    final random = Random();
    setState(() {
      _customerID = String.fromCharCodes(Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    });
  }

void _showErrorDialog(String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
        ],
      );
    },
  );
}

  @override
  void dispose() {
    _salutation.dispose();
    _firstname.dispose();
    _lastname.dispose();
    _email.dispose();
    _workphone.dispose();
    _mobile.dispose();
    _address.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add customer"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer ID : $_customerID ' ,  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5,),
              const Text(
                'Customer Name:',
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
                        controller: _salutation,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Salutation',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter salutation';
                          }
                          return null;
                        },
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
                        controller: _firstname,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First Name',
                          contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: _lastname,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Last Name',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
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
                  controller: _address,
                  keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Address',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Customer Phone:',
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
                        controller: _workphone,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Work Phone',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          } else if (value.length != 10) {
                            return 'Phone number must be 10 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: _mobile,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mobile',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          } else if (value.length != 10) {
                            return 'Phone number must be 10 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _saveCustomer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.white)),
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