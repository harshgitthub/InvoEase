// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Verify extends StatefulWidget {
//   const Verify({Key? key}) : super(key: key);

//   @override
//   State<Verify> createState() => _VerifyState();
// }

// class _VerifyState extends State<Verify> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? user;
//   bool isVerified = false;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     user = _auth.currentUser;
//     isVerified = user?.emailVerified ?? false;

//     if (!isVerified) {
//       sendVerificationEmail();
//     } else {
//       navigateToDetails();
//     }
//   }

//   Future<void> sendVerificationEmail() async {
//     if (user != null && !isVerified) {
//       try {
//         await user!.sendEmailVerification();
//       } catch (e) {
//         print("Error sending email verification: $e");
//       }
//     }
//   }

//   void checkEmailVerified() async {
//     await user?.reload();
//     user = _auth.currentUser;

//     if (user?.emailVerified ?? false) {
//       setState(() {
//         isVerified = true;
//       });
//       navigateToDetails();
//     } else {
//       _showErrorDialog("Email is not verified yet. Please check your inbox.");
//     }
//   }

//   void navigateToDetails() {
//     Navigator.pushReplacementNamed(context, '/details');
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Verification Error'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text("Verify Email"),
//       ),
//       body: Center(
//         child: isLoading
//             ? CircularProgressIndicator()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'A verification email has been sent to ${user?.email}. Please verify your email.',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: checkEmailVerified,
//                     child: Text("I have verified my email"),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
