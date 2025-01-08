// import 'package:cloneapp/pages/subpages/otpscreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class PhoneAuthState extends StatefulWidget {
//   const PhoneAuthState({super.key});

//   @override
//   State<PhoneAuthState> createState() => _PhoneAuthStateState();
// }

// class _PhoneAuthStateState extends State<PhoneAuthState> {
//   TextEditingController phonecontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   body: Column(
//     //     children: [
//     //       Padding(padding: const EdgeInsets.all(23),
//         //   child: TextField(
//         //     controller: phonecontroller,
//         //     decoration: InputDecoration(
//         //       hintText: 'enter your number'
//         //     ),
//         //   ),),
//         //   ElevatedButton(onPressed: ()async{
//         //     await FirebaseAuth.instance.verifyPhoneNumber(verificationCompleted: (PhoneAuthCredential credential){}, verificationFailed: (FirebaseAuthException ex){}, codeSent: (String verficationid , int? resendtoken){
//         //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Otpscreen(verificationid: verficationid,)));
//         //     }, codeAutoRetrievalTimeout: (String verficationid){} , phoneNumber: phonecontroller.text.toString());
//         //   }, 
//         //   child: Text("verify"))
          
//         // ],
//     //   ),
//     // );
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(height: 120,),
//           Text("Verify your number " , style: TextStyle(color: Colors.white , fontSize: 30),
//            textAlign: TextAlign.center,),
//           const SizedBox(height: 20),
//            TextField(
//   controller: phonecontroller,
//   keyboardType: TextInputType.phone, // Ensures numeric keyboard
//   decoration: InputDecoration(
//                 hintText: 'Enter your mobile number ',
//                 hintStyle: TextStyle(color: Colors.grey[400]),
//                 prefixIcon: const Icon(Icons.person, color: Colors.blue),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(color: Colors.blue, width: 2),
//                 ),
//               ),
              
//               textInputAction: TextInputAction.next,
//             ),
// const SizedBox(height: 20),
// ElevatedButton.icon(
//              onPressed: ()async{
//             await FirebaseAuth.instance.verifyPhoneNumber(verificationCompleted: (PhoneAuthCredential credential){}, verificationFailed: (FirebaseAuthException ex){}, codeSent: (String verficationid , int? resendtoken){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>Otpscreen(verificationid: verficationid,)));
//             }, codeAutoRetrievalTimeout: (String verficationid){} , phoneNumber: phonecontroller.text.toString());
//           }, 
//               icon: const Icon(Icons.phone_android, color: Colors.blue),
//               label: const Text(
//                 'Verify',
//                 style: TextStyle(color: Colors.blue, fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
          
//         ],
//       ),
//     )
    
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloneapp/pages/subpages/otpscreen.dart';
import 'package:cloneapp/pages/home.dart'; // Replace 'home.dart' with your actual home screen file

class PhoneAuthState extends StatefulWidget {
  const PhoneAuthState({Key? key}) : super(key: key);

  @override
  State<PhoneAuthState> createState() => _PhoneAuthStateState();
}

class _PhoneAuthStateState extends State<PhoneAuthState> {
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  void checkAuthentication() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already signed in, navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()), // Replace 'Home()' with your actual home screen widget
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Phone Authentication'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            Text(
              "Verify your number",
              style: TextStyle(color: Colors.white, fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your mobile number',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.person, color: Colors.blue),
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
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException ex) {},
                  codeSent: (String verificationId, int? resendToken) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Otpscreen(verificationid: verificationId),
                      ),
                    );
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                  phoneNumber: phoneController.text.trim(),
                );
              },
              icon: const Icon(Icons.phone_android, color: Colors.blue),
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
      ),
    );
  }
}
