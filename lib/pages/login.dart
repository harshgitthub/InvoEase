
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloneapp/pages/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

   final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.blue,
    appBar: AppBar(backgroundColor: Colors.blue,),
   body: SingleChildScrollView(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(
        "Hello There!",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 20),
      const Text(
        "LOGIN TO YOUR ACCOUNT",
        style: TextStyle(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 40),
      TextField(
        controller: _email,
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: const Icon(Icons.person, color: Colors.blue),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
      const SizedBox(height: 20),
      TextField(
        controller: _password,
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: const Icon(Icons.lock, color: Colors.blue),
          suffixIcon: GestureDetector(
            onTap: () {
              // Implement forgot password functionality
            },
            child: const Icon(Icons.help_outline, color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _signin(),
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          // Checkbox(
          //   value: _rememberMe,
          //   onChanged: (value) {
          //     setState(() {
          //       // _rememberMe = value!;
          //     });
          //   },
          //   fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
          //   checkColor: Colors.blue,
          // ),
          const Text(
            'Remember me',
            style: TextStyle(color: Colors.white),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              // Implement forgot password functionality
            },
            child: const Text(
              'Forgot Password?',
              style:  TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      ElevatedButton.icon(
        onPressed: () => _signin(),
        icon: const Icon(Icons.login, color: Colors.blue),
        label: const Text(
          'Login',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              // Implement sign-in with Google
            },
            icon: const FaIcon(FontAwesomeIcons.google,   color: Colors.amber ), // Replace with Google icon
          ),
          IconButton(
            onPressed: () {
              // Implement sign-in with Facebook
            },
            icon:const FaIcon(FontAwesomeIcons.facebook, color: Colors.amber ) ,// Replace with Facebook icon
          ),
          IconButton(
            onPressed: () {
              // Implement sign-in with Twitter
            },
            icon: const FaIcon(FontAwesomeIcons.twitter,  color: Colors.amber ), // Replace with Twitter icon
          ),
          IconButton(
            onPressed: () {
              // Implement sign-in with Microsoft
            },
            icon: const FaIcon(FontAwesomeIcons.microsoft, color: Colors.amber ), // Replace with Microsoft icon
          ),
        ],
      ),
    ],
  ),
    ),
  );
}


void _signin() async{
  //   final user = await _auth.createUserwithEmailandPassword(_email.text, _password.text);
  //   if(user!=null){
  //     print("login");
  //     gotoHome(context);
  //   }  
  //   else{
  //     print("not logged in");
  //   }
  // }

  String password = _password.text;
  String email = _email.text;
try{
  User? user = await _auth.signInWithEmailAndPassword(email, password);

  if(user!=null){
    // print("logged in");
    // Show success dialog
      _showSuccessDialog();
    Navigator.pushNamed(context, "/invoice");
 }
  else{
  _showErrorDialog("Login failed. Please try again.");
    print("not logged in");
  }
}
catch(e){
  _handleSignInError(e);
}
}


void _showSuccessDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Success"),
        content: const Text("Login successful"),
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

String _handleSignInError(dynamic error) {
  String errorMessage = "An undefined error occurred.";

  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        errorMessage = "Invalid email address.";
        break;
      case 'user-disabled':
        errorMessage = "User account has been disabled.";
        break;
      case 'user-not-found':
        errorMessage = "No user found with this email.";
        break;
      case 'wrong-password':
        errorMessage = "Incorrect password.";
        break;
      default:
        errorMessage = "Sign in failed. Please try again later.";
        break;
    }
  }

  return errorMessage;
}
}
