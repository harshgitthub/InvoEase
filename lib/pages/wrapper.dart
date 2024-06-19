//   // // // import 'package:cloneapp/pages/details.dart';
//   // // // import 'package:cloneapp/pages/invoice.dart';

//   // // // import 'package:cloneapp/pages/open.dart';
//   // // // import 'package:cloneapp/pages/subpages/about.dart';
//   // // // import 'package:cloneapp/pages/verify.dart';

//   // // // import 'package:firebase_auth/firebase_auth.dart';
//   // // // import 'package:flutter/material.dart';

//   // // // class Wrapper extends StatelessWidget {
//   // // //   const Wrapper({super.key});

//   // // //   @override
//   // // //   Widget build(BuildContext context) {
//   // // //     return Scaffold(
//   // // //       body: StreamBuilder(
//   // // //         stream:FirebaseAuth.instance.authStateChanges() 
//   // // //       , builder: (context , snapshot){
//   // // //         if(snapshot.hasData){
//   // // //           print(snapshot.data);
//   // // //           if(snapshot.data!.emailVerified){
//   // // //             return Open();
//   // // //           }
//   // // //           else{
//   // // //             Navigator.pushNamed(context, '/verify');
//   // // //           }
            
//   // // //         }
//   // // //         else{
//   // // //           return const Open();
//   // // //         }
//   // // //       }),
//   // // //     );
//   // // //   }
//   // // // }

//   // // import 'package:cloneapp/pages/details.dart';
//   // // import 'package:cloneapp/pages/invoice.dart';
//   // // import 'package:cloneapp/pages/open.dart';
//   // // import 'package:cloneapp/pages/subpages/about.dart';
//   // // import 'package:cloneapp/pages/verify.dart';
//   // // import 'package:firebase_auth/firebase_auth.dart';
//   // // import 'package:flutter/material.dart';

//   // // class Wrapper extends StatelessWidget {
//   // //   const Wrapper({super.key});

//   // //   @override
//   // //   Widget build(BuildContext context) {
//   // //     return Scaffold(
//   // //       body: StreamBuilder<User?>(
//   // //         stream: FirebaseAuth.instance.authStateChanges(),
//   // //         builder: (context, snapshot) {
//   // //           if (snapshot.connectionState == ConnectionState.waiting) {
//   // //             return const Center(child: CircularProgressIndicator());
//   // //           }
            
//   // //           if (snapshot.hasData) {
//   // //             // final user = snapshot.data!;
//   // //             // if (user.emailVerified) {
//   // //             //   return Details();
//   // //             // } else {
//   // //             //   return Open();
//   // //             // }
//   // //             return Open();
//   // //           } else {
//   // //             return Open();
//   // //           }
//   // //         },
//   // //       ),
//   // //     );
//   // //   }
//   // // }

//   // import 'package:flutter/material.dart';
//   // import 'package:firebase_auth/firebase_auth.dart';
//   // import 'package:google_sign_in/google_sign_in.dart';
//   // import 'package:cloneapp/pages/details.dart';
//   // import 'package:cloneapp/pages/open.dart';

//   // class Wrapper extends StatelessWidget {
//   //   const Wrapper({Key? key});

//   //   Future<void> _signInWithGoogle(BuildContext context) async {
//   //     try {
//   //       final GoogleSignIn googleSignIn = GoogleSignIn();
//   //       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//   //       if (googleUser != null) {
//   //         final GoogleSignInAuthentication googleAuth =
//   //             await googleUser.authentication;

//   //         final OAuthCredential credential = GoogleAuthProvider.credential(
//   //           accessToken: googleAuth.accessToken,
//   //           idToken: googleAuth.idToken,
//   //         );

//   //         await FirebaseAuth.instance.signInWithCredential(credential);
//   //       }
//   //     } catch (e) {
//   //       print('Google Sign-In error: $e');
//   //       // Handle error
//   //     }
//   //   }

//   //   @override
//   //   Widget build(BuildContext context) {
//   //     return Scaffold(
//   //       body: StreamBuilder<User?>(
//   //         stream: FirebaseAuth.instance.authStateChanges(),
//   //         builder: (context, snapshot) {
//   //           if (snapshot.connectionState == ConnectionState.waiting) {
//   //             return const Center(child: CircularProgressIndicator());
//   //           }

//   //           if (snapshot.hasData) {
//   //             final User user = snapshot.data!;
//   //             if (user.emailVerified) {
//   //               // Navigate to Details page when authenticated
//   //               return Details();
//   //             } else {
//   //               // Navigate to Verify page if email is not verified
//   //               return Open();
//   //             }
//   //           } else {
//   //             // Not authenticated, show the Open page or Sign-in options
//   //             return Open(
//   //             onGoogleSignIn: () => _signInWithGoogle(context),
//   //             );
//   //           }
//   //         },
//   //       ),
//   //     );
//   //   }
//   // }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloneapp/pages/details.dart';
// import 'package:cloneapp/pages/open.dart';

// class Wrapper extends StatefulWidget {
//   const Wrapper({Key? key}) : super(key: key);

//   @override
//   _WrapperState createState() => _WrapperState();
// }

// class _WrapperState extends State<Wrapper> {
//   late User? _currentUser;

//   @override
//   void initState() {
//     super.initState();
//     // Listen to auth state changes
//     FirebaseAuth.instance.authStateChanges().listen((user) {
//       setState(() {
//         _currentUser = user;
//       });
//     });
//   }

//   Future<void> _signInWithGoogle() async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

//       if (googleUser != null) {
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;

//         final OAuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         await FirebaseAuth.instance.signInWithCredential(credential);
//       }
//     } catch (e) {
//       print('Google Sign-In error: $e');
//       // Handle Google Sign-In error
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_currentUser == null) {
//       // No user logged in, show Open page
//       return Open(onGoogleSignIn: _signInWithGoogle);
//     } else {
//       // User is logged in
//       if (_currentUser!.emailVerified) {
//         // Email verified, show Details page (only once after signing up)
//         WidgetsBinding.instance!.addPostFrameCallback((_) {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => Details()),
//           );
//         });
//       } else {
//         // Email not verified, show Open page
//         return Open(onGoogleSignIn: _signInWithGoogle);
//       }
//     }

//     // Default return, should not hit this point if navigation is properly handled
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
