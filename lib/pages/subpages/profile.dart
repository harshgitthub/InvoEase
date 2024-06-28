

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var currentuser = FirebaseAuth.instance.currentUser;
  final _organisation = TextEditingController();
  final _mobile = TextEditingController();
  final _address = TextEditingController();
  final _gst = TextEditingController();
  // final _propreitor = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentuser!.uid)
        .collection("details")
        .doc(currentuser!.uid)
        .get();

    setState(() {
      _organisation.text = userDoc['Organisation Name'];
      // _propreitor.text = userDoc["Proprietor"];
      _address.text = userDoc['Address'];
      _mobile.text = userDoc['Phone Number'].toString();
      _gst.text = userDoc['gst'];
      _selectedProfession = userDoc['Profession'];
      imageUrl = userDoc['Profile Image'];
    });
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      XFile? pickedImage = await _imagePicker.pickImage(source: source);

      if (pickedImage != null) {
        await uploadImageToFirebase(File(pickedImage.path));
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

  Future<void> updateCustomerDetails() async {
    try {
      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("details")
          .doc(currentuser!.uid)
          .update({
        "Organisation Name": _organisation.text,
        // "Propreitor":_propreitor.text,
        "Address": _address.text,
        "Phone Number": int.tryParse(_mobile.text),
        "gst": _gst.text,
        "Profession": _selectedProfession,
        "Profile Image": imageUrl,
        
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Profile updated successfully!"),
        ),
      );
      Navigator.pushNamed(context, '/invoice');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text("Failed to update profile: $e"),
        ),
      );
    }
  }

  Future<void> clearProfileImage() async {
    setState(() {
      imageUrl = null;
    });
  }

  @override
  void dispose() {
    _mobile.dispose();
    _address.dispose();
    _organisation.dispose();
    _gst.dispose();
    // _propreitor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Profile'),
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Edit Details",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                  child: imageUrl == null ? const Icon(Icons.person, size: 60) : null,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.gallery); // Pick image from gallery
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            buildTextField(_organisation, 'Organisation / Proprietor Name', Icons.person),
            const SizedBox(height: 20),
            //  buildTextField(_propreitor, 'Proprietor', Icons.business),
            //  const SizedBox(height: 20,),
            buildTextField(_address, 'Address', Icons.location_city),
            const SizedBox(height: 20),
            buildTextField(_mobile, 'Mobile', Icons.phone),
            const SizedBox(height: 20),
            buildTextField(_gst, 'GST', Icons.account_balance),
            const SizedBox(height: 20),
            buildDropdownButton(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: updateCustomerDetails,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                backgroundColor: Colors.white,
                iconColor: Colors.black,
              ),
              child: const Text(
                'Update Profile',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  DropdownButtonFormField<String> buildDropdownButton() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.work),
        labelText: 'Profession',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
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
    );
  }
}

