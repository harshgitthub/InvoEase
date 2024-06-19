
// // // ignore_for_file: use_build_context_synchronously, avoid_print

// // import 'package:cloneapp/pages/forgetpassword.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloneapp/pages/auth_service.dart';
// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:get/get.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:hive/hive.dart';


// // class Login extends StatefulWidget {
// //   const Login({super.key});

// //   @override
// //   State<Login> createState() => _LoginState();
// // }

// // class _LoginState extends State<Login> {

// //    final _auth = AuthService();
// //   final _email = TextEditingController();
// //   final _password = TextEditingController();
// //   bool _rememberMe = false;

// //   late Box box1;


// // login()async{

// // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

// // final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

// // final credential = GoogleAuthProvider.credential(
// // accessToken: googleAuth ?. accessToken,
// // idToken: googleAuth ?. idToken,
// // );
// // await FirebaseAuth.instance.signInWithCredential(credential);

// // }

// // @override

 
// //  @override
// //   void initState() {
// //     super.initState();
// //     createBox();
   
    
// //   }


// // void createBox() async{
// //    box1 = await Hive.openBox("Login data");
// //     getData();
// // }

// // void getData() async{
// //   if(box1.get('email')!= null){
// //     _email.text = box1.get('email');
// //     _rememberMe = true;
// //     setState(() {
       
// //      });

// //   }
// //   if(box1.get('password')!= null){
// //     _password.text = box1.get('password');
// //      _rememberMe = true;
// //      setState(() {
       
// //      });

// //   }


// // }


// //   @override
// //   void dispose() {
// //     super.dispose();
// //     _email.dispose();
// //     _password.dispose();
// //   }


// //   @override
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //     backgroundColor: Colors.blue,
// //     appBar: AppBar(backgroundColor: Colors.blue,),
// //    body: SingleChildScrollView(
// //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
// //   child: Column(
// //     crossAxisAlignment: CrossAxisAlignment.stretch,
// //     children: [
// //       const Text(
// //         "Hello There!",
// //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
// //         textAlign: TextAlign.center,
// //       ),
// //       const SizedBox(height: 20),
// //       const Text(
// //         "LOGIN TO YOUR ACCOUNT",
// //         style: TextStyle(color: Colors.white, fontSize: 20),
// //         textAlign: TextAlign.center,
// //       ),
// //       const SizedBox(height: 40),
// //       TextField(
// //         controller: _email,
// //         decoration: InputDecoration(
// //           hintText: 'Email',
// //           hintStyle: TextStyle(color: Colors.grey[400]),
// //           prefixIcon: const Icon(Icons.person, color: Colors.blue),
// //           filled: true,
// //           fillColor: Colors.white,
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(3),
// //             borderSide: const BorderSide(color: Colors.blue, width: 2),
// //           ),
// //         ),
// //         keyboardType: TextInputType.emailAddress,
// //         textInputAction: TextInputAction.next,
// //       ),
// //       const SizedBox(height: 20),
// //       TextField(
// //         controller: _password,
// //         decoration: InputDecoration(
// //           hintText: 'Password',
// //           hintStyle: TextStyle(color: Colors.grey[400]),
// //           prefixIcon: const Icon(Icons.lock, color: Colors.blue),
// //           suffixIcon: GestureDetector(
// //             onTap: () {
// //               // Implement forgot password functionality
// //             },
// //             child: const Icon(Icons.help_outline, color: Colors.white),
// //           ),
// //           filled: true,
// //           fillColor: Colors.white,
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(3),
// //             borderSide: const BorderSide(color: Colors.blue, width: 2),
// //           ),
// //         ),
// //         obscureText: true,
// //         textInputAction: TextInputAction.done,
// //         onSubmitted: (_) => _signin(),
// //       ),
// //       const SizedBox(height: 20),
// //       Row(
// //         children: [
// //           Checkbox(
// //             value: _rememberMe,
// //             onChanged: (value) {
// //               setState(() {
// //                 _rememberMe = value!;
// //               });
// //             },
// //             fillColor: WidgetStateColor.resolveWith((states) => Colors.white),
// //             checkColor: Colors.blue,
// //           ),
// //           const Text(
// //             'Remember me',
// //             style: TextStyle(color: Colors.white),
// //           ),
// //           const Spacer(),
// //           TextButton(
// //             onPressed: (()=> Get.to(Forgetpassword())
// //             ),
// //             child: const Text(
// //               'Forgot Password?',
// //               style:  TextStyle(color: Colors.white),
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 20),
// //       ElevatedButton.icon(
// //         onPressed: () => _signin() , 
// //         icon: const Icon(Icons.login, color: Colors.blue),
// //         label: const Text(
// //           'Login',
// //           style: TextStyle(color: Colors.blue, fontSize: 18),
// //         ),
// //         style: ElevatedButton.styleFrom(
// //           padding: const EdgeInsets.symmetric(vertical: 15),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(3),
// //           ),
// //         ),
// //       ),
// //       const SizedBox(height: 20),
// //       Row(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           IconButton(
// //             onPressed: (()=>login()),
// //             icon: const FaIcon(FontAwesomeIcons.google,   color: Colors.amber ), // Replace with Google icon
// //           ),
// //           IconButton(
// //             onPressed: () {
// //               // Implement sign-in with Facebook
// //             },
// //             icon:const FaIcon(FontAwesomeIcons.facebook, color: Colors.amber ) ,// Replace with Facebook icon
// //           ),
// //           IconButton(
// //             onPressed: () {
// //               // Implement sign-in with Twitter
// //             },
// //             icon: const FaIcon(FontAwesomeIcons.twitter,  color: Colors.amber ), // Replace with Twitter icon
// //           ),
// //           IconButton(
// //             onPressed: () {
// //               // Implement sign-in with Microsoft
// //             },
// //             icon: const FaIcon(FontAwesomeIcons.microsoft, color: Colors.amber ), // Replace with Microsoft icon
// //           ),
// //         ],
// //       ),
// //     ],
// //   ),
// //     ),
// //   );
// // }


// // void _signin() async{
// //   //   final user = await _auth.createUserwithEmailandPassword(_email.text, _password.text);
// //   //   if(user!=null){
// //   //     print("login");
// //   //     gotoHome(context);
// //   //   }  
// //   //   else{
// //   //     print("not logged in");
// //   //   }
// //   // }

// //   String password = _password.text;
// //   String email = _email.text;
// // try{
// //   User? user = await _auth.signInWithEmailAndPassword(email, password);

// //   if(user!=null){
// //     if(_rememberMe){
// //       box1.put('email', email);
// //       box1.put('password', password);
// //       _showSuccessDialog();
// //     Navigator.pushNamed(context, "/invoice");

// //     }
// //     else{
// //       _showSuccessDialog();
// //     Navigator.pushNamed(context, "/invoice");
// //     }
// //     // print("logged in");
// //     // Show success dialog
      
// //  }
// //   else{
// //   _showErrorDialog("Login failed. Please try again.");
// //     print("not logged in");
// //   }
// // }
// // catch(e){
// //   _handleSignInError(e);
// // }
// // }


// // void _showSuccessDialog() {
// //   showDialog(
// //     context: context,
// //     builder: (BuildContext context) {
// //       return AlertDialog(
// //         title: const Text("Success"),
// //         content: const Text("Login successful"),
// //         actions: <Widget>[
// //           TextButton(
// //             child: const Text("OK"),
// //             onPressed: () {
// //               Navigator.of(context).pop(); // Dismiss the dialog
// //             },
// //           ),
// //         ],
// //       );
// //     },
// //   );
// // }


// // void _showErrorDialog(String message) {
// //   showDialog(
// //     context: context,
// //     builder: (BuildContext context) {
// //       return AlertDialog(
// //         title: const Text("Error"),
// //         content: Text(message),
// //         actions: <Widget>[
// //           TextButton(
// //             child: const Text("OK"),
// //             onPressed: () {
// //               Navigator.of(context).pop(); // Dismiss the dialog
// //             },
// //           ),
// //         ],
// //       );
// //     },
// //   );
// // }

// // String _handleSignInError(dynamic error) {
// //   String errorMessage = "An undefined error occurred.";

// //   if (error is FirebaseAuthException) {
// //     switch (error.code) {
// //       case 'invalid-email':
// //         errorMessage = "Invalid email address.";
// //         break;
// //       case 'user-disabled':
// //         errorMessage = "User account has been disabled.";
// //         break;
// //       case 'user-not-found':
// //         errorMessage = "No user found with this email.";
// //         break;
// //       case 'wrong-password':
// //         errorMessage = "Incorrect password.";
// //         break;
// //       default:
// //         errorMessage = "Sign in failed. Please try again later.";
// //         break;
// //     }
// //   }

// //   return errorMessage;
// // }
// // }


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';

// import 'forgetpassword.dart'; // Import your Forgetpassword page here
// import 'auth_service.dart'; // Import your authentication service

// class Login extends StatefulWidget {
//   const Login({Key? key});

//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final _auth = AuthService();
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//   bool _rememberMe = false;
//   late Box box1;

//   @override
//   void initState() {
//     super.initState();
//     createBox();
//   }

//   void createBox() async {
//     box1 = await Hive.openBox("Login data");
//     getData();
//   }

//   void getData() {
//     if (box1.get('email') != null) {
//       _email.text = box1.get('email');
//       _rememberMe = true;
//       setState(() {});
//     }
//     if (box1.get('password') != null) {
//       _password.text = box1.get('password');
//       _rememberMe = true;
//       setState(() {});
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _email.dispose();
//     _password.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               "Hello There!",
//               style: TextStyle(
//                   fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "LOGIN TO YOUR ACCOUNT",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 40),
//             TextField(
//               controller: _email,
//               decoration: InputDecoration(
//                 hintText: 'Email',
//                 hintStyle: TextStyle(color: Colors.grey[400]),
//                 prefixIcon: const Icon(Icons.person, color: Colors.blue),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(3),
//                   borderSide: const BorderSide(color: Colors.blue, width: 2),
//                 ),
//               ),
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _password,
//               decoration: InputDecoration(
//                 hintText: 'Password',
//                 hintStyle: TextStyle(color: Colors.grey[400]),
//                 prefixIcon: const Icon(Icons.lock, color: Colors.blue),
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     // Implement forgot password functionality
//                     Get.to(Forgetpassword());
//                   },
//                   child: const Icon(Icons.help_outline, color: Colors.white),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(3),
//                   borderSide: const BorderSide(color: Colors.blue, width: 2),
//                 ),
//               ),
//               obscureText: true,
//               textInputAction: TextInputAction.done,
//               onSubmitted: (_) => _signin(),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Checkbox(
//                   value: _rememberMe,
//                   onChanged: (value) {
//                     setState(() {
//                       _rememberMe = value!;
//                     });
//                   },
//                   fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
//                   checkColor: Colors.blue,
//                 ),
//                 const Text(
//                   'Remember me',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 const Spacer(),
//                 TextButton(
//                   onPressed: () {
//                     Get.to(Forgetpassword());
//                   },
//                   child: const Text(
//                     'Forgot Password?',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () => _signin(),
//               icon: const Icon(Icons.login, color: Colors.blue),
//               label: const Text(
//                 'Login',
//                 style: TextStyle(color: Colors.blue, fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(3),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () => _loginWithGoogle(),
//                   icon: const FaIcon(FontAwesomeIcons.google, color: Colors.amber),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // Implement sign-in with Facebook
//                   },
//                   icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.amber),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // Implement sign-in with Twitter
//                   },
//                   icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.amber),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // Implement sign-in with Microsoft
//                   },
//                   icon: const FaIcon(FontAwesomeIcons.microsoft, color: Colors.amber),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _signin() async {
//     String password = _password.text;
//     String email = _email.text;

//     try {
//       User? user = await _auth.signInWithEmailAndPassword(email, password);

//       if (user != null) {
//         if (_rememberMe) {
//           box1.put('email', email);
//           box1.put('password', password);
//           _showSuccessDialog();
//           Navigator.pushNamed(context, "/invoice");
//         } else {
//           _showSuccessDialog();
//           Navigator.pushNamed(context, "/invoice");
//         }
//       } else {
//         _showErrorDialog("Login failed. Please try again.");
//       }
//     } catch (e) {
//       _handleSignInError(e);
//     }
//   }

//   void _loginWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       if (googleUser != null) {
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;

//         final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         await FirebaseAuth.instance.signInWithCredential(credential);
//         Navigator.pushNamed(context, "/invoice");
//       } else {
//         // Handle Google Sign-In cancelation or error
//         _showErrorDialog("Google Sign-In canceled or failed. Please try again.");
//       }
//     } catch (e) {
//       _handleSignInError(e);
//     }
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Success"),
//           content: const Text("Login successful"),
//           actions: <Widget>[
//             TextButton(
//               child: const Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Dismiss the dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Error"),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: const Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Dismiss the dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _handleSignInError(dynamic error) {

//     // String errorMessage = "An undefined error occurred.";

//     // if (error is FirebaseAuthException) {
//     //   switch (error.code) {
//     //     case 'invalid-email':
//     //       errorMessage = "Invalid email address.";
//     //       break;
//     //     case 'user-disabled':
//     //       errorMessage = "User account has been disabled.";
//     //       break;
//     //     case 'user-not-found':
//     //       errorMessage = "No user found with this email.";
//     //       break;
//     //     case 'wrong-password':
//     //       errorMessage = "Incorrect password.";
//     //       break;
//     //     default:
//     //       errorMessage = "Sign in failed. Please try again later.";
//     //       break;
//     //   }
//     // }

//     _showErrorDialog(error);
    
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import 'forgetpassword.dart'; // Import your Forgetpassword page here
import 'auth_service.dart'; // Import your authentication service
import 'details.dart'; // Import your Details page here
import 'invoice.dart'; // Import your Invoice page here

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _rememberMe = false;
  late Box box1;

  @override
  void initState() {
    super.initState();
    createBox();
  }

  void createBox() async {
    box1 = await Hive.openBox("Login data");
    getData();
  }

  void getData() {
    if (box1.get('email') != null) {
      _email.text = box1.get('email');
      _rememberMe = true;
      setState(() {});
    }
    if (box1.get('password') != null) {
      _password.text = box1.get('password');
      _rememberMe = true;
      setState(() {});
    }
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Hello There!",
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "LOGIN TO YOUR ACCOUNT",
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.person, color: Colors.blue),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _password,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                suffixIcon: GestureDetector(
                  onTap: () {
                    // Implement forgot password functionality
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Forgetpassword()));
                  },
                  child: const Icon(Icons.help_outline, color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _signin(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                  fillColor: WidgetStateColor.resolveWith((states) => Colors.white),
                  checkColor: Colors.blue,
                ),
                const Text(
                  'Remember me',
                  style: TextStyle(color: Colors.white),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Forgetpassword()));
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _signin(),
              icon: const Icon(Icons.login, color: Colors.blue),
              label: const Text(
                'Login',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _loginWithGoogle(),
                  icon: const FaIcon(FontAwesomeIcons.google, color: Colors.amber),
                ),
                IconButton(
                  onPressed: () {
                    // Implement sign-in with Facebook
                  },
                  icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.amber),
                ),
                IconButton(
                  onPressed: () {
                    // Implement sign-in with Twitter
                  },
                  icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.amber),
                ),
                IconButton(
                  onPressed: () {
                    // Implement sign-in with Microsoft
                  },
                  icon: const FaIcon(FontAwesomeIcons.microsoft, color: Colors.amber),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signin() async {
    String password = _password.text;
    String email = _email.text;

    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);

      if (user != null) {
        if (user.emailVerified) {
          if (_rememberMe) {
            box1.put('email', email);
            box1.put('password', password);
          }
          _showSuccessDialog();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const InvoiceView()));
        } else {
          _showErrorDialog("Email is not verified. Please verify your email.");
        }
      } else {
        _showErrorDialog("Login failed. Please try again.");
      }
    } catch (e) {
      _handleSignInError(e);
    }
  }

  void _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = userCredential.user;

        if (user != null) {
          if (user.emailVerified) {
            // Check if user exists in database or not
            // You may want to implement this logic to decide whether to navigate to Details or directly to Invoice
            bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? true;

            if (isNewUser) {
              _showGoogleDialog();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Details()));
            } else {
              // Existing user, navigate to Invoice page
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const InvoiceView()));
            }
          } else {
            // Email not verified, show error
            _showErrorDialog("Email is not verified. Please verify your email.");
          }
        } else {
          _showErrorDialog("Login failed. Please try again.");
        }
      } else {
        _showErrorDialog("Google Sign-In canceled or failed. Please try again.");
      }
    } catch (e) {
      _handleSignInError(e);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Login successful"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

void _showGoogleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Click the google button again to continue"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _handleSignInError(dynamic error) {
    String errorMessage = "An undefined error occurred.";

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          errorMessage = "Invalid email address.";
          break;
        case 'user-disabled':
          errorMessage = "User account has been disabled.";
          break;
        case 'user-not-found':
          errorMessage = "No user found with this email.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password.";
          break;
        default:
          errorMessage = "Sign in failed. Please try again later.";
          break;
      }
    }

    _showErrorDialog(errorMessage);
  }
}

