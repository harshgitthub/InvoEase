import 'package:cloneapp/pages/auth_service.dart';
import 'package:flutter/material.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final AuthService auth = AuthService();

  @override
  void initState() {
    auth.sendEmailverificationLink(); // Corrected method name
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              auth.sendEmailverificationLink(); // Corrected method name
            },
            child: Text('Resend Verification Email'), // Add child widget for the button
          ),
        ],
      ),
    );
  }
}
