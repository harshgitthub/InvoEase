// // ignore_for_file: avoid_print, use_build_context_synchronously

// import 'package:cloneapp/pages/auth_service.dart';
// // ignore: unused_import
// import 'package:cloneapp/pages/home.dart';
// import 'package:cloneapp/pages/verify.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {

//   final _auth =AuthService();
//   final _name =TextEditingController();
//   final _email = TextEditingController();
//   final _password = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _name.dispose();
//     _email.dispose();
//     _password.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.blue,
    //   appBar: AppBar(
    //     backgroundColor: Colors.blue,
    //   ),
    //   body: SingleChildScrollView(
    //     child:  Padding(
        // padding: const EdgeInsets.all(20.0),
        // child: Column(

        //   children: [
        //     const SizedBox(height: 200,),
        //     const Text("SIGNUP TO CONTINUE", style: TextStyle(color: Colors.white, fontSize: 20)),
        //     const SizedBox(height: 10,),
        //     // TextFormField(
//             //   controller: _name,
//             //   decoration: InputDecoration(
//             //     prefixIcon: const Icon(Icons.person),
//             //     labelText: 'Username',
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(3),
//             //     ),
//             //     fillColor: Colors.white,
//             //     filled: true,
//             //   ),
//             //   validator: (value) {
//             //     if (value == null || value.isEmpty) {
//             //       return 'Please enter your username';
//             //     }
//             //     return null;
//             //   },
//             // ),
//             const SizedBox(height: 10),
//             TextFormField(
//               controller: _email,
            //   decoration: InputDecoration(
            //     prefixIcon: const Icon(Icons.email , color: Colors.blue,),
            //     hintText: 'Email',
            //     hintStyle: TextStyle(color: Colors.grey[400]),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(3),
            //     ),
            //     fillColor: Colors.white,
            //     filled: true,
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter your email';
            //     }
            //     // Add email validation if needed
            //     return null;
            //   },
            // ),
//             const SizedBox(height: 10),
//             TextFormField(
//               controller: _password,
            //   decoration: InputDecoration(
            //     hintText: 'Password',
            //     hintStyle: TextStyle(color: Colors.grey[400]),
            //     prefixIcon: const Icon(Icons.lock, color: Colors.blue,),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(3),
            //     ),
            //     fillColor: Colors.white,
            //     filled: true,
            //   ),
            //   obscureText: true,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter a password';
            //     }
            //     // Add password validation if needed
            //     return null;
            //   },
            // ),
            // const SizedBox(height: 10),
//              ElevatedButton.icon(
//               onPressed: _signup,
            //   style: ElevatedButton.styleFrom(
            //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
               
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(3),
            //     ),
            //   ),
            //   icon: const Icon(Icons.person_add, color: Colors.blue),
            //   label: const Text(
            //     'Sign up',
            //    style: TextStyle(color: Colors.blue, fontSize: 18),
            //   )
            //  )
//           ],
//         ),
//       )
//       ),
//     );
//   }
 

//  _signup() async{
 
//   String name = _name.text;
//   String password = _password.text;
//   String email = _email.text;
// try{
// User? user = await _auth.createUserWithEmailAndPassword(email, password);
//  if(user!=null){
//   print("logged in");
//    Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Verify()),
//       );
//  }
//   else{
//     print("not logged in");
//     _showErrorDialog("SignUp failed Try again");
//   }
// }
// catch(e){
//   _handleSignUpError(e);
// }
// }
// String _handleSignUpError(dynamic error) {
//     String errorMessage = "An undefined error occurred.";

//     if (error is FirebaseAuthException) {
//       switch (error.code) {
//         case 'weak-password':
//           errorMessage = "The password provided is too weak.";
//           break;
//         case 'email-already-in-use':
//           errorMessage = "The account already exists for that email.";
//           break;
//         case 'invalid-email':
//           errorMessage = "Invalid email address.";
//           break;
//         default:
//           errorMessage = "Sign up failed. Please try again later.";
//           break;
//       }
//     }

//     return errorMessage;
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Sign Up Error'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

// //   void _showSuccessDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text('Sign Up Successful'),
// //           content: Text('You have successfully signed up.'),
// //           actions: <Widget>[
// //             TextButton(
// //               child: Text('OK'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //                 // Optionally you can navigate to another screen after successful signup
// //                 // Navigator.pushNamed(context, '/home');
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Signup extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
            const Text("SIGNUP TO CONTINUE", style: TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email , color: Colors.blue,),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey[400]),
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
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
             decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.lock, color: Colors.blue,),
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
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3),
    ),
  ),
  icon: const Icon(Icons.person_add, color: Colors.blue),
  label: const Text(
    'Sign up',
    style: TextStyle(color: Colors.blue, fontSize: 18),
  ),
)
          ],
        ),
      ),
      )
    );
  }
}
