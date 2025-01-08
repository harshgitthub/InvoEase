import 'dart:math';

import 'package:cloneapp/pages/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Otpscreen extends StatefulWidget {
  String verificationid;
  Otpscreen({super.key , required this.verificationid});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 120,),
          Text("Verify code", style: TextStyle(color: Colors.white , fontSize: 30),
           textAlign: TextAlign.center,),
          const SizedBox(height: 20),
          TextField(
            controller: otpcontroller,
            keyboardType: TextInputType.number,
          decoration: InputDecoration(
                hintText: 'Enter OTP',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.code, color: Colors.blue),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
             
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20), 
           
          ElevatedButton.icon(
             onPressed: () async{
            try{
              PhoneAuthCredential credential = await PhoneAuthProvider.credential(verificationId: widget.verificationid, smsCode: otpcontroller.text.toString());
              FirebaseAuth.instance.signInWithCredential(credential).then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Details()));
              });
            }
            catch(ex){
              print(ex);
            }
          }, 
              icon: const Icon(Icons.done, color: Colors.blue),
              label: const Text(
                'Verify',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
        ],
      ),
      )
    );
  }
}