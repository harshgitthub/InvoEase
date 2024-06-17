// import 'package:flutter/material.dart';
// import 'package:cloneapp/pages/auth_service.dart'; // Replace with your AuthService import
//
// class LinkAccountScreen extends StatefulWidget {
//   @override
//   _LinkAccountScreenState createState() => _LinkAccountScreenState();
// }
//
// class _LinkAccountScreenState extends State<LinkAccountScreen> {
//   final AuthService _auth = AuthService();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isLoading = false;
//
//   void _linkAccount() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty) {
//       // Handle empty fields error
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Email and password fields cannot be empty.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     try {
//       await _auth.linkEmailAndPassword(email, password);
//       // Linking successful
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Success'),
//           content: Text('New account linked successfully.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop(); // Pop twice to go back to Users screen
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       // Handle linking error
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Failed to link account: $e'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Link Account'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _linkAccount,
//                     child: Text('Link Account'),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
