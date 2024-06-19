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


// import 'package:flutter/material.dart';

// class InvoiceTemplate extends StatefulWidget {
//   const InvoiceTemplate({super.key});

//   @override
//   _InvoiceTemplateState createState() => _InvoiceTemplateState();
// }

// class _InvoiceTemplateState extends State<InvoiceTemplate> {
//   String selectedTemplate = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Invoice Template'),
//       ),
//       body: ListView(
//         children: [
//           ListTile(
//             title: Text('Standard Template'),
//             trailing: selectedTemplate == 'Standard' ? Icon(Icons.check, color: Colors.green) : null,
//             onTap: () {
//               setState(() {
//                 selectedTemplate = 'Standard';
//               });
//             },
//           ),
//           ListTile(
//             title: Text('Spreadsheet Template'),
//             trailing: selectedTemplate == 'Spreadsheet' ? Icon(Icons.check, color: Colors.green) : null,
//             onTap: () {
//               setState(() {
//                 selectedTemplate = 'Spreadsheet';
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: InvoiceTemplate(),
//   ));
// }

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CelebrationPage(),
    );
  }
}

class CelebrationPage extends StatefulWidget {
  @override
  _CelebrationPageState createState() => _CelebrationPageState();
}

class _CelebrationPageState extends State<CelebrationPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Celebration'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                _confettiController.play();
              },
              child: const Text('Celebrate!'),
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive, // start at a random direction
            shouldLoop: false, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
          // define a custom shape/path.
          ),
        ],
      ),
    );
  }

  
}
