import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

    bool _termsChecked = false;
    bool _isPasswordVisible = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child:  Padding(
           padding: const EdgeInsets.all(20.0),
        child: Column(

          children: [
            const SizedBox(height: 200,),
            const Text("Signup To Continue", style: TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email , color: Colors.blue,),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
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

            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
             decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.blue,
              ),
            ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: !_isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                // Add password validation if needed
                return null;
              },
            ),
            Row(
                children: [
                  Checkbox(
                    value: _termsChecked,
                    onChanged: (value) {
                      setState(() {
                        _termsChecked = value!;
                      });
                    },
                  ),
                  TextButton(onPressed: (){}, child: const Text("I agree to the terms and conditions" , style: TextStyle(color: Colors.white),))
                ],
              ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
  onPressed: () async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();
      
      Get.snackbar('Verification Email Sent', 'Please check your email to verify your account.');

      // Navigate to Details page for additional information
      Navigator.pushReplacementNamed(context, '/verify');
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth exceptions
      if (e.code == 'email-already-in-use') {
        // Show alert for existing account
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('The account already exists. Please try logging in instead.'),
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
      } else {
        // Show general error using Get.snackbar
        Get.snackbar('Error', e.message ?? 'An error occurred');
      }
    } catch (e) {
      // Handle other errors
      print('Error: $e');
      Get.snackbar('Error', 'An unexpected error occurred');
    }
  },
  style: OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 15),
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
    
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  
  label: const Text(
    'Sign-Up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
  ),
)
          ],
        ),
      ),
      )
    );
  }
}
