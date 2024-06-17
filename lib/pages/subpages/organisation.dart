// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   const Profile({super.key});

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   var currentuser = FirebaseAuth.instance.currentUser;

//   final _organisation = TextEditingController();
//   final _mobile = TextEditingController();
//   final _address = TextEditingController();
//   final _profession = TextEditingController();
//   final _bankDetails = TextEditingController();
//   final _username = TextEditingController();

//   final List<String> _professions = [
//     'Engineer',
//     'Doctor',
//     'Lawyer',
//     'Artist',
//     'Teacher',
//     'Other',
//   ];
//   String? _selectedProfession;

//   @override
//   void initState() {
//     super.initState();
//     _fetchDetails();
//   }

//   Future<void> _fetchDetails() async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("details")
//           .doc(currentuser!.uid)
//           .get();

//       if (userDoc.exists) {
//         var data = userDoc.data() as Map<String, dynamic>;
//         _organisation.text = data['Organisation Name'] ?? '';
//         _address.text = data['Address'] ?? '';
//         _mobile.text = data['Phone Number'].toString();
//         _selectedProfession = data['Profession'] ?? '';
//         _bankDetails.text = data['Bank Details'] ?? '';
//         _username.text = data['Username'] ?? '';
//         setState(() {});
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.black,
//           content: Text("Failed to fetch details: $e"),
//         ),
//       );
//     }
//   }

//   Future<void> _updateDetails() async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("details")
//           .doc(currentuser!.uid)
//           .update({
//         "Organisation Name": _organisation.text,
//         "Address": _address.text,
//         "Phone Number": int.tryParse(_mobile.text),
//         "Profession": _selectedProfession,
//         "Bank Details": _bankDetails.text,
//         "Username": _username.text,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.black,
//           content: Text("Profile updated successfully"),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.black,
//           content: Text("Failed to update profile: $e"),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _organisation.dispose();
//     _address.dispose();
//     _mobile.dispose();
//     _profession.dispose();
//     _bankDetails.dispose();
//     _username.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: const Text("Profile"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _organisation,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.business),
//                   labelText: 'Organisation',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _address,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.location_city),
//                   labelText: 'Address',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _mobile,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.phone),
//                   labelText: 'Phone Number',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.work),
//                   labelText: 'Profession',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//                 value: _selectedProfession,
//                 items: _professions.map((String profession) {
//                   return DropdownMenuItem<String>(
//                     value: profession,
//                     child: Text(profession),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedProfession = newValue;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _bankDetails,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.account_balance),
//                   labelText: 'Bank Details',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _username,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.person),
//                   labelText: 'Username',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _updateDetails,
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(3.0),
//                   ),
//                   backgroundColor: Colors.white,
//                   iconColor: Colors.black,
//                 ),
//                 child: const Text(
//                   'Update Profile',
//                   style: TextStyle(color: Colors.black, fontSize: 18),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   const Profile({super.key});

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   var currentuser = FirebaseAuth.instance.currentUser;

//   final _organisation = TextEditingController();
//   final _mobile = TextEditingController();
//   final _address = TextEditingController();
//   final _bankDetails = TextEditingController();
//   final _username = TextEditingController();

//   final List<String> _professions = [
//     'Engineer',
//     'Doctor',
//     'Lawyer',
//     'Artist',
    
//     'Other',
//   ];
//   String? _selectedProfession;

//   String? imageUrl;

//   @override
//   void initState() {
//     super.initState();
//     _fetchDetails();
//   }

//   Future<void> _fetchDetails() async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("details").doc(currentuser!.uid)
//           .get();

//       if (userDoc.exists) {
//         var data = userDoc.data() as Map<String, dynamic>;
//         _organisation.text = data['Organisation'] ?? '';
//         _address.text = data['State'] ?? '';
//         _mobile.text = data['Phone Number']?.toString() ?? '';
//         _selectedProfession = data['Profession'] ?? '';
//         _bankDetails.text = data['Bank Details'] ?? '';
//         _username.text = data['Username'] ?? '';
//         imageUrl = data['Profile Image'];
//         setState(() {});
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.black,
//           content: Text("Failed to fetch details: $e"),
//         ),
//       );
//     }
//   }

//   Future<void> _updateDetails() async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentuser!.uid)
//           .collection("details").doc(currentuser!.uid)
//           .update({
//         "Organisation": _organisation.text,
//         "State": _address.text,
//         "Phone Number": int.tryParse(_mobile.text),
//         "Profession": _selectedProfession,
//         "Bank Details": _bankDetails.text,
//         "Username": _username.text,
//         "Profile Image": imageUrl,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.black,
//           content: Text("Profile updated successfully"),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.black,
//           content: Text("Failed to update profile: $e"),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _organisation.dispose();
//     _address.dispose();
//     _mobile.dispose();
//     _bankDetails.dispose();
//     _username.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: const Text("Profile"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _organisation,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.business),
//                   labelText: 'Organisation',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _address,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.location_city),
//                   labelText: 'Address',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _mobile,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.phone),
//                   labelText: 'Phone Number',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//   decoration: InputDecoration(
//     prefixIcon: const Icon(Icons.work),
//     labelText: 'Profession',
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(3),
//     ),
//     fillColor: Colors.white,
//     filled: true,
//   ),
//   value: _selectedProfession,
//   items: _professions.map((String profession) {
//     return DropdownMenuItem<String>(
//       value: profession,
//       child: Text(profession),
//     );
//   }).toList(),
//   onChanged: (String? newValue) {
//     setState(() {
//       _selectedProfession = newValue;
//     });
//   },
// ),

//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _bankDetails,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.account_balance),
//                   labelText: 'Bank Details',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _username,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.person),
//                   labelText: 'Username',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _updateDetails,
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(3.0),
//                   ),
//                   backgroundColor: Colors.white,
//                   iconColor: Colors.black,
//                 ),
//                 child: const Text(
//                   'Update Profile',
//                   style: TextStyle(color: Colors.black, fontSize: 18),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
