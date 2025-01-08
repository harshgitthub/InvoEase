import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController email = TextEditingController();

  reset() async {
    if (email.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent!'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text('Failed to send password reset email.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an email address.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      
      body: SingleChildScrollView(
        
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
          const SizedBox(height: 180,)
            ,
             TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Enter E-mail',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.email , color: Colors.blue,),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              obscureText:false,
              textInputAction: TextInputAction.done,
              
            ),
            const SizedBox(height: 40),
          
            
            ElevatedButton.icon(
              onPressed: () => reset(),
            
              label: const Text(
                'Send Link',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12 , horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {

                Navigator.pushNamed(context, '/login');
              },
              
              label: const Text(
                'Back to Login',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12 , horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
