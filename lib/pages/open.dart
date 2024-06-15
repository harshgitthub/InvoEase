import 'package:flutter/material.dart';

class Open extends StatefulWidget {
  const Open({super.key});

  @override
  State<Open> createState() => _OpenState();
}

class _OpenState extends State<Open> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,// Background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 700),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // App Title
              const Text(
                'Welcome ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // App Description
              const Text(
                'Manage your Invoice efficiently '
                ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Login or Signup to continue'
                ,
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10,),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
              
            ]
            
          ),
          
        ),
        
      ),
      
    );
  }
}