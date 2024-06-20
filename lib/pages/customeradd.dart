import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  bool isEmail = false;
  bool isFocused = false;
  bool isPhoneValid = true;


  var currentUser = FirebaseAuth.instance.currentUser;
  String _customerID ='';
  

  @override
  void initState() {
    super.initState();
    _generateCustomerId();
     _email.addListener(_checkIsEmail);
      _workphone.addListener(_checkIsPhoneValid);
      _mobile.addListener(_checkIsPhoneValid2);
    // _saveCustomer();
    // _showErrorDialog("Some Error Occured");
  }

  @override 
  void dispose(){
    _email.dispose();
    _lastname.dispose();
    _firstname.dispose();
    _mobile.dispose();
    _workphone.dispose();
    _address.dispose();
    _salutation.dispose();
    super.dispose();
  }

  void _checkIsPhoneValid() {
    final value = _workphone.text.trim();
    setState(() {
      isPhoneValid = value.isEmpty || (value.length == 10 && int.tryParse(value) != null);
    });
  }
    void _checkIsPhoneValid2() {
    final value = _mobile.text.trim();
    setState(() {
      isPhoneValid = value.isEmpty || (value.length == 10 && int.tryParse(value) != null);
    });
  }
void _checkIsEmail() {
  final value = _email.text.trim();

  // Basic regex for email validation (matches most common cases)
         final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  // Advanced checks (can be expanded further)
  final bool isValid = emailRegExp.hasMatch(value) &&
      value.length <= 254 && // Ensure email length does not exceed maximum allowed (RFC 5321)
      !value.startsWith('.') && !value.endsWith('.') && // Email should not start or end with dot
      !value.contains('..') && // Email should not contain consecutive dots
      !value.contains('.@') && !value.contains('@.') && // Email should not have dot immediately before or after @
      !value.contains(' ') && // Email should not have spaces
      value.split('@').length == 2 && // Email should contain exactly one @ symbol
      !value.contains('._') && !value.contains('.-') && // Dot should not immediately precede or follow special characters
      !value.contains('_.');

  setState(() {
    isEmail = isValid;
  });

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
          _showErrorDialog(context, "An error has occured");
      return;
    }



  //   try {
  //     CollectionReference customersCollection = FirebaseFirestore.instance
  //         .collection("USERS")
  //         .doc(currentUser!.uid)
  //         .collection("customers");

      
  //       await customersCollection.add({
  //         "Salutation": salutation,
  //         "First Name": firstname,
  //         "Last Name": lastname,
  //         "Email": email,
  //         "Work-phone": workphone,
  //         "Mobile": mobile,
  //         "Address": address,
  //         "customerID":_customerID,
  //       });
  //     // } else {
  //     //   await customersCollection
  //     //       .doc(widget.customerData!.id)
  //     //       .update({
  //     //         "Salutation": salutation,
  //     //         "First Name": firstname,
  //     //         "Last Name": lastname,
  //     //         "Email": email,
  //     //         "Work-phone": workphone,
  //     //         "Mobile": mobile,
  //     //         "Address": address,
  //     //         "customer":_customerID,
  //     //       })
  //     //       .then((value) => print("Customer updated"))
  //     //       .catchError((error) => print("Failed to update customer: $error"));
  //     // }

  //     // Clear text fields after saving
  //     _salutation.clear();
  //     _firstname.clear();
  //     _lastname.clear();
  //     _email.clear();
  //     _workphone.clear();
  //     _mobile.clear();
  //     _address.clear();

  //     // Show success dialog
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //         title: const Text('Success'),
  //         content: const Text('Customer data saved successfully'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               Navigator.pushNamed(context, '/customeradd');
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   } catch (e) {
  //     print("Error: $e");
  //     // Handle error, show error dialog or snackbar
  //   }
  // }
  try {
    CollectionReference customersCollection = FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentUser!.uid)
        .collection("customers");
        

    Timestamp now = Timestamp.now(); // Get current timestamp

    await customersCollection.doc(_customerID).set({
      "Salutation": salutation,
      "First Name": firstname,
      "Last Name": lastname,
      "Email": email,
      "Work-phone": workphone,
      "Mobile": mobile,
      "Address": address,
      "customerID": _customerID,
      "timestamp": now, // Add timestamp field
    });

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
void _showErrorDialog(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: 'Error',
    desc: message,
    btnOkText: 'OK',
    btnOkColor: Colors.red,
    btnOkOnPress: () {
      // Optionally perform some action on button press
    },
  ).show();
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
                   onChanged: (value) {
              _checkIsEmail();
            },
            onTap: () {
              setState(() {
                isFocused = true;
              });
            },
            onEditingComplete: () {
              setState(() {
                isFocused = false;
              });
            },
          ),
        ),
        if (!isEmail && _email.text.isNotEmpty)
       const   Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              'Please enter a valid email address',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
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
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Work Phone',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                         onChanged: (value) {
            _checkIsPhoneValid();
          },
          onTap: () {
            setState(() {
              isFocused = true;
            });
          },
          onEditingComplete: () {
            setState(() {
              isFocused = false;
            });
          }
                    )  )),
             if (! isPhoneValid && _workphone.text.isNotEmpty)
         Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              'Please enter a valid mobile Number',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
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
                       
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mobile',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                         onChanged: (value) {
            _checkIsPhoneValid2();
          },
          onTap: () {
            setState(() {
              isFocused = true;
            });
          },
          onEditingComplete: () {
            setState(() {
              isFocused = false;
            });
          }                 ))),
           if (! isPhoneValid && _mobile.text.isNotEmpty)
         Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              'Please enter a valid mobile Number',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
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