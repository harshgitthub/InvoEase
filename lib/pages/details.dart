// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class Details extends StatefulWidget {
//   const Details({Key? key}) : super(key: key);

//   @override
//   State<Details> createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   var currentuser = FirebaseAuth.instance.currentUser;
//   final _organisation = TextEditingController();
//   final _mobile = TextEditingController();
//   final _address = TextEditingController();

//   final ImagePicker _imagePicker = ImagePicker();
//   String? imageUrl;

//   final List<String> _professions = [
//     'Engineer',
//     'Doctor',
//     'Lawyer',
//     'Artist',
//     'Teacher',
//     'Other',
//   ];
//   String? _selectedProfession;

//   Future<void> pickImage() async {
//     try {
//       XFile? cameraImage = await _imagePicker.pickImage(source: ImageSource.camera);
//       XFile? galleryImage = await _imagePicker.pickImage(source: ImageSource.gallery);

//       XFile? pickedImage = cameraImage ?? galleryImage;

//       if (pickedImage != null) {
//         await uploadImageToFirebase(File(pickedImage.path));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.black,
//           content: Text("Failed to upload image: $e"),
//         ),
//       );
//     }
//   }

//   Future<void> uploadImageToFirebase(File image) async {
//     try {
//       Reference reference = FirebaseStorage.instance
//           .ref()
//           .child("images/${DateTime.now().microsecondsSinceEpoch}.png");
//       await reference.putFile(image);
//       String downloadUrl = await reference.getDownloadURL();
//       setState(() {
//         imageUrl = downloadUrl;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.black,
//           content: Text("Failed to upload image: $e"),
//         ),
//       );
//     }
//   }

//   Future<void> customer(String organisation, String address, int mobile, String profession) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("details")
//           .doc(currentuser!.uid)
//           .set({
//         "Organisation Name": organisation,
//         "Address": address,
//         "Phone Number": mobile,
//         "Profession": profession,
//         "Bank Details": null,
//         "Username": null,
//         "Profile Image": imageUrl,
//       });
//       print("Data entered successfully");
//       _organisation.clear();
//       _address.clear();
//       _mobile.clear();
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _mobile.dispose();
//     _address.dispose();
//     _organisation.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text("Feel free to share your details", style: TextStyle(color: Colors.white, fontSize: 20)),
//             const SizedBox(height: 10),
//             TextFormField(
//               controller: _organisation,
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.business),
//                 labelText: 'Organisation',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(3),
//                 ),
//                 fillColor: Colors.white,
//                 filled: true,
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your organisation';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               controller: _address,
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.location_city),
//                 labelText: 'Address',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(3),
//                 ),
//                 fillColor: Colors.white,
//                 filled: true,
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your address';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               controller: _mobile,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(3.0),
//                 ),
//                 fillColor: Colors.white,
//                 filled: true,
//                 prefixIcon: const Icon(Icons.phone),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your phone number';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.work),
//                 labelText: 'Profession',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(3),
//                 ),
//                 fillColor: Colors.white,
//                 filled: true,
//               ),
//               value: _selectedProfession,
//               items: _professions.map((String profession) {
//                 return DropdownMenuItem<String>(
//                   value: profession,
//                   child: Text(profession),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedProfession = newValue;
//                 });
//               },
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please select your profession';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
//                       child: imageUrl == null ? const Icon(Icons.person, size: 30) : null,
//                     ),
//                     Positioned(
//                       right: 0,
//                       bottom: 0,
//                       child: GestureDetector(
//                         onTap: pickImage,
//                         child: const Icon(
//                           Icons.camera_alt,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 String organisation = _organisation.text;
//                 String address = _address.text;
//                 int? mobile = int.tryParse(_mobile.text);
//                 String? profession = _selectedProfession;

//                 if (organisation.isNotEmpty && address.isNotEmpty && mobile != null && profession != null) {
//                   customer(organisation, address, mobile, profession);
//                   Navigator.pushNamed(context, '/home');
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text('Validation Error'),
//                         content: const Text('Please fill in all the fields before proceeding.'),
//                         actions: <Widget>[
//                           TextButton(
//                             child: const Text('OK'),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               style: OutlinedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(3.0),
//                 ),
//                 backgroundColor: Colors.white,
//                 iconColor: Colors.black,
//               ),
//               child: const Text(
//                 'Start managing your invoices',
//                 style: TextStyle(color: Colors.black, fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
  var currentUser = FirebaseAuth.instance.currentUser;
  final _organisation = TextEditingController();
  final _mobile = TextEditingController();
  final _address = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  String? imageUrl;

  final List<String> _professions = [
    'Engineer',
    'Doctor',
    'Lawyer',
    'Artist',
    'Teacher',
    'Other',
  ];
  String? _selectedProfession;

  Future<void> pickImage() async {
    try {
      XFile? cameraImage = await _imagePicker.pickImage(source: ImageSource.camera);
      XFile? galleryImage = await _imagePicker.pickImage(source: ImageSource.gallery);

      XFile? pickedImage = cameraImage ?? galleryImage;

      if (pickedImage != null) {
        await uploadImageToFirebase(File(pickedImage.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
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
          backgroundColor: Colors.red,
          content: Text("Failed to upload image: $e"),
        ),
      );
    }
  }

  Future<void> saveUserData(String organisation, String address, int mobile, String profession) async {
    try {
      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("details")
          .doc(currentUser!.uid)
          .set({
        "Organisation Name": organisation,
        "Address": address,
        "Phone Number": mobile,
        "Profession": profession,
        "Bank Details": null,
        "Username": null,
        "Profile Image": imageUrl,
      });
      print("Data entered successfully");
      _organisation.clear();
      _address.clear();
      _mobile.clear();
      setState(() {
        imageUrl = null; // Clear image after successful upload and save
      });
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to save data: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Enter Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: _organisation,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.business),
                labelText: 'Organisation',
                filled: true,
                fillColor: Colors.white,
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
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                labelText: 'Address',
                filled: true,
                fillColor: Colors.white,
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
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: 'Phone Number',
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedProfession,
              items: _professions.map((String profession) {
                return DropdownMenuItem<String>(
                  value: profession,
                  child: Text(profession),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProfession = newValue;
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.work),
                labelText: 'Profession',
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select your profession';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                      child: imageUrl == null ? const Icon(Icons.person, size: 30) : null,
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
                if (_organisation.text.isNotEmpty &&
                    _address.text.isNotEmpty &&
                    _mobile.text.isNotEmpty &&
                    _selectedProfession != null) {
                  int mobile = int.tryParse(_mobile.text) ?? 0;
                  saveUserData(_organisation.text, _address.text, mobile, _selectedProfession!);
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
              child: const Text(
                'Save Details',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
