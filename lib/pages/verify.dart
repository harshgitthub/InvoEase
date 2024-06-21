import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloneapp/pages/details.dart';
import 'package:cloneapp/pages/wrapper.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    sendVerifyLink();
  }

  Future<void> sendVerifyLink() async {
    final user = FirebaseAuth.instance.currentUser!;
    try {
      await user.sendEmailVerification();
      Get.snackbar('Link sent', "A verification link has been sent to your email", margin: const EdgeInsets.all(10));
    } catch (e) {
      Get.snackbar('Error', "Failed to send verification email", margin: const EdgeInsets.all(10));
    }
  }

  Future<void> resendVerifyLink() async {
    setState(() {
      _isResending = true;
    });
    await sendVerifyLink();
    setState(() {
      _isResending = false;
    });
  }

  Future<void> reload() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Details()),
      );
    } else {
      Get.snackbar('Email not verified', "Please verify your email before proceeding", margin: const EdgeInsets.all(10));
      // You might want to resend the verification link or handle this case differently
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: reload,
              child: const Text("Continue"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isResending ? null : resendVerifyLink,
              child: _isResending
                  ? const CircularProgressIndicator()
                  : const Text("Resend Verification Link"),
            ),
          ],
        ),
      ),
    );
  }
}

