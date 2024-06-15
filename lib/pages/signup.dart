// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloneapp/pages/auth_service.dart';
// ignore: unused_import
import 'package:cloneapp/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _auth =AuthService();
  final _name =TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
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
            const Text("SIGNUP TO CONTINUE" , style: TextStyle(color: Colors.white, fontSize: 20 )),
            const SizedBox(height: 10,),
              TextFormField(
                controller: _name,
                decoration:  InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'Username',
                    border: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(3),
                ),
                fillColor: Colors.white,
                filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                   prefixIcon: const Icon(Icons.person),
                  labelText: 'Email',
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                fillColor: Colors.white,
                filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add email validation if needed
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _password,
                decoration:  InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.password),
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                fillColor: Colors.white,
                filled: true,
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  // Add password validation if needed
                  return null;
                },
              ),
              const SizedBox(height:10),
             OutlinedButton(
                onPressed: _signup,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  side: const BorderSide(color: Colors.black ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    
                  ),
                  backgroundColor: Colors.white
                ),
               child: const Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
  // gotoHome(BuildContext context) => Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context)=> const Home()),
  // );

void _signup() async{
  //   final user = await _auth.createUserwithEmailandPassword(_email.text, _password.text);
  //   if(user!=null){
  //     print("login");
  //     gotoHome(context);
  //   }  
  //   else{
  //     print("not logged in");
  //   }
  // }
  // ignore: unused_local_variable
  String name = _name.text;
  String password = _password.text;
  String email = _email.text;

User? user = await _auth.createUserWithEmailAndPassword(email, password);
 if(user!=null){
  print("logged in");
  Navigator.pushNamed(context, "/details");
 }
  else{
    print("not logged in");
  }

}
}
