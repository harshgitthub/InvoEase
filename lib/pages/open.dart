// // import 'package:flutter/material.dart';

// // class Open extends StatefulWidget {
// //   const Open({super.key});

// //   @override
// //   State<Open> createState() => _OpenState();
// // }

// // class _OpenState extends State<Open> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(

// //       backgroundColor: Colors.blue,// Background color
// //       body:SingleChildScrollView(
// //         child:  
// //       Center(
// //         child: 
// //         SafeArea(child:  Padding(
// //           padding: const EdgeInsets.only(top: 20),
// //           child: Column(
            
// //             // crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               const SizedBox(height: 100),
// //               // App Title
// //               const Text(
// //                 'Welcome!',
// //                 style: TextStyle(
// //                   fontSize: 40,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.white,
                
// //                 ),
                
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 20),
// //               // App Description
// //               const Text(
// //                 'Manage your Invoice efficiently '
// //                 ,
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontStyle: FontStyle.italic,
// //                   fontSize: 16,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //               const SizedBox(height: 5),
// //               const Text(
// //                 'Login or Signup to continue'
// //                 ,
// //                 textAlign: TextAlign.center,

// //                 style: TextStyle(
// //                   fontStyle: FontStyle.italic,
// //                   fontSize: 16,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //               const SizedBox(height: 200,),
// //               // Login Button
// //               ElevatedButton(
// //                 onPressed: () {
// //                   Navigator.pushNamed(context, '/login');
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(3),
// //                   ),
// //                   backgroundColor: Colors.white,
// //                 ),
// //                 child: const Text(
// //                   'Login',
// //                   style: TextStyle(
// //                     color: Colors.blue,
// //                     fontSize: 18,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 10),
// //               // Signup Button
// //               OutlinedButton(
// //                 onPressed: () {
// //                   Navigator.pushNamed(context, '/signup');
// //                 },
// //                 style: OutlinedButton.styleFrom(
// //                   padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 10),
// //                   side: const BorderSide(color: Colors.white),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(3),
// //                   ),
// //                 ),
// //                 child: const Text(
// //                   'Sign up',
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                     fontSize: 18,
// //                   ),
// //                 ),
// //               ),
              
// //             ]
            
// //           ),
          
// //         ),
        
// //       ),
// //       )
// //       )
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';

// class Open extends StatelessWidget {
//   final VoidCallback? onGoogleSignIn; // Callback for Google Sign-In

//   const Open({Key? key, this.onGoogleSignIn}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: SingleChildScrollView(
//         child: Center(
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 100),
//                   const Text(
//                     'Welcome!',
//                     style: TextStyle(
//                       fontSize: 40,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Manage your Invoice efficiently',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontStyle: FontStyle.italic,
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   const Text(
//                     'Login or Signup to continue',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontStyle: FontStyle.italic,
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 200),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/login');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(3),
//                       ),
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   OutlinedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/signup');
//                     },
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 10),
//                       side: const BorderSide(color: Colors.white),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(3),
//                       ),
//                     ),
//                     child: const Text(
//                       'Sign up',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   // Google Sign-In Button
//                 ]       
//             ),
//           ),
//         ),
//       ),
//     )


import 'package:flutter/material.dart';

class Open extends StatelessWidget {
  const Open({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    'G-INVOICE',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Easy, Efficient, Eco-friendly ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                   const Text(
                    'Billing Solutions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // const Text(
                  //   'Login or Signup to continue',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontStyle: FontStyle.italic,
                  //     fontSize: 16,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  const SizedBox(height: 200),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Log-In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 10),
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Sign-Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Optionally, you can add other social login options here if needed
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//   }
// }

