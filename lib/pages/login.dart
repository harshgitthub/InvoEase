
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloneapp/pages/auth_service.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
      
        padding: const EdgeInsets.only(right: 700.0 ,left: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Text("LOGIN TO YOUR ACCOUNT" , style: TextStyle(color: Colors.white, fontSize: 20  )),
            // Logo or Image
            // Image.asset(
            //    'assets/images/image.png',// Replace 'assets/logo.png' with your logo image path
            //   height: 150,
            // ),
            const SizedBox(height: 10),
            // Username Text Field
            TextField(
              controller: _email,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 10),
            // Password Text Field
            TextField(
              controller: _password,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            // Login Button
            ElevatedButton(
              onPressed: _signin,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  
                ),
                backgroundColor: Colors.white
              ),
              child: const Text('Login',style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
            ),
            const SizedBox(height: 5),
              // Signup Button
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
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

  User? user = await _auth.signInWithEmailAndPassword(email, password);
  if(user!=null){
    print("logged in");
    Navigator.pushNamed(context, "/home");
 }
  else{
    print("not logged in");
  }

}
}
