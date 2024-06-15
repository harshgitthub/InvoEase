import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var currentuser = FirebaseAuth.instance.currentUser;
  final _organisation = TextEditingController();
  final _mobile = TextEditingController();
  final _address = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  String? imageUrl;

  Future<void> pickImage() async {
    try {
      XFile? res = await _imagePicker.pickImage(source: ImageSource.camera);
      if (res != null) {
        await uploadImageToFirebase(File(res.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text("Failed to upload image: $e"),
        ),
      );
    }
  }

  Future<void> uploadImageToFirebase(File image) async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("images/${DateTime.now().microsecondsSinceEpoch}.png");
      await reference.putFile(image);
      String downloadUrl = await reference.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text("Failed to upload image: $e"),
        ),
      );
    }
  }

  Future<void> customer(String organisation, String address, int mobile) async {
    try {
      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("details")
          .doc(currentuser!.uid)
          .set({
        "Organisation": organisation,
        "Address": address,
        "Phone Number": mobile,
      });
      print("Data entered successfully");
      _organisation.clear();
      _address.clear();
      _mobile.clear();
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    _mobile.dispose();
    _address.dispose();
    _organisation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.blue,
      appBar: AppBar
      (
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        
        padding:  const EdgeInsets.only(right: 700.0 ,left: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Feel free to share your details" , style: TextStyle(color: Colors.white, fontSize: 20 )),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _organisation,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.business),
                labelText: 'Organisation',
                 border: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(3),
                ),
                fillColor: Colors.white,
                filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your organisation';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _address,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_city),
                labelText: 'Address',
                border: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(3),
                ),
                fillColor: Colors.white,
                filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _mobile,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.phone),
              ),

            validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  // Add password validation if needed
                  return null;
                },
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,

                      child: imageUrl == null ? const Icon(Icons.person, size: 20) : null,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: pickImage,
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                
               
              ],
            ),
            const SizedBox(height: 20),
               ElevatedButton(
                    onPressed: () {
                      String organisation = _organisation.text;
                      String address = _address.text;
                      int? mobile = int.tryParse(_mobile.text);

                      if (organisation.isNotEmpty && address.isNotEmpty && mobile != null) {
                        customer(organisation, address, mobile);
                        Navigator.pushNamed(context, '/home');
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Validation Error'),
                              content: const Text('Please fill in all the fields before proceeding.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                       
                      shape: RoundedRectangleBorder(
                        
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      
                      backgroundColor: Colors.white,
                      iconColor: Colors.black,
                    ),
                    
                    child: const Text(
                      'Start managing your invoices',
                      style: TextStyle(color: Colors.black , fontSize: 18),
                    ),
                  
                ),
          ],
        ),
      ),
    );
  }
}
