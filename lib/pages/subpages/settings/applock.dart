// // import 'package:cloneapp/pages/subpages/settings/password.dart';
// // import 'package:cloneapp/pages/subpages/settings/pattern.dart';
// // import 'package:cloneapp/pages/subpages/settings/pin.dart';
// // import 'package:cloneapp/pages/subpages/settings/recover.dart';
// // import 'package:flutter/material.dart';
// // import 'package:local_auth/local_auth.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // void main() {
// //   runApp(const MaterialApp(
// //     home: Applock(),
// //   ));
// // }

// // class Applock extends StatefulWidget {
// //   const Applock({super.key});

// //   @override
// //   _ApplockState createState() => _ApplockState();
// // }

// // class _ApplockState extends State<Applock> {
// //   final LocalAuthentication _localAuth = LocalAuthentication();
// //   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
// //   String? _selectedLockType;
// //   bool _isLockEnabled = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _checkLockStatus();
// //   }

// //   Future<void> _checkLockStatus() async {
// //     String? lockType = await _secureStorage.read(key: 'lockType');
// //     setState(() {
// //       _selectedLockType = lockType;
// //       _isLockEnabled = lockType != null;
// //     });
// //   }

// //   Future<void> _enableFingerprint() async {
// //     bool isAuthenticated = false;
// //     try {
// //       isAuthenticated = await _localAuth.authenticate(
// //         localizedReason: 'Please authenticate to enable fingerprint lock',
// //         options: const AuthenticationOptions(biometricOnly: true),
// //       );
// //     } catch (e) {
// //       // Handle authentication errors here
// //     }

// //     if (isAuthenticated) {
// //       await _secureStorage.write(key: 'lockType', value: 'Fingerprint');
// //       setState(() {
// //         _selectedLockType = 'Fingerprint';
// //         _isLockEnabled = true;
// //       });
// //     }
// //   }

// //   void _enablePIN() {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (context) => const SetupPinScreen()),
// //     ).then((value) => _checkLockStatus());
// //   }

// //   void _enablePassword() {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (context) => const SetupPasswordScreen()),
// //     ).then((value) => _checkLockStatus());
// //   }

// //   void _enablePattern() {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (context) => const SetupPatternScreen()),
// //     ).then((value) => _checkLockStatus());
// //   }

// //   void _disableLock() async {
// //     await _secureStorage.delete(key: 'lockType');
// //     await _secureStorage.delete(key: 'lockValue');
// //     setState(() {
// //       _selectedLockType = null;
// //       _isLockEnabled = false;
// //     });
// //   }

// //   void _forgetLock() {
// //     _disableLock();
// //   }

// //   void _recoverPassword() {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (context) => const RecoverPasswordScreen()),
// //     ).then((value) => _checkLockStatus());
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('App Lock'),
// //       ),
// //       body: ListView(
// //         children: [
// //           ListTile(
// //             title: const Text('Fingerprint'),
// //             trailing: _isLockEnabled && _selectedLockType == 'Fingerprint'
// //                 ? const Icon(Icons.check)
// //                 : null,
// //             onTap: _enableFingerprint,
// //           ),
// //           ListTile(
// //             title: const Text('PIN'),
// //             trailing: _isLockEnabled && _selectedLockType == 'PIN'
// //                 ? const Icon(Icons.check)
// //                 : null,
// //             onTap: _enablePIN,
// //           ),
// //           ListTile(
// //             title: const Text('Password'),
// //             trailing: _isLockEnabled && _selectedLockType == 'Password'
// //                 ? const Icon(Icons.check)
// //                 : null,
// //             onTap: _enablePassword,
// //           ),
// //           ListTile(
// //             title: const Text('Pattern'),
// //             trailing: _isLockEnabled && _selectedLockType == 'Pattern'
// //                 ? const Icon(Icons.check)
// //                 : null,
// //             onTap: _enablePattern,
// //           ),
// //           const Divider(),
// //           ListTile(
// //             title: const Text('Forget Lock'),
// //             onTap: _isLockEnabled ? _forgetLock : null,
// //           ),
// //           ListTile(
// //             title: const Text('Disable Lock'),
// //             onTap: _isLockEnabled ? _disableLock : null,
// //           ),
// //           ListTile(
// //             title: const Text('Recover Password'),
// //             onTap: _recoverPassword,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';



// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Awesome Dialog Examples',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: DialogExamplePage(),
// //     );
// //   }
// // }

// class DialogExamplePage extends StatelessWidget {
//   void _showDialog(BuildContext context, int dialogNumber) {
//     switch (dialogNumber) {
      // case 1:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.success,
      //     animType: AnimType.bottomSlide,
      //     title: 'Success',
      //     desc: 'Operation completed successfully!',
      //     btnCancelOnPress: () {},
      //     btnOkOnPress: () {},
      //   ).show();
      //   break;
      // case 2:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.error,
      //     animType: AnimType.topSlide,
      //     title: 'Error',
      //     desc: 'Failed to complete operation.',
      //     btnOkOnPress: () {},
      //   ).show();
      //   break;
      // case 3:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.warning,
      //     animType: AnimType.leftSlide,
      //     title: 'Warning',
      //     desc: 'Are you sure you want to continue?',
      //     btnCancelOnPress: () {},
      //     btnOkOnPress: () {},
      //   ).show();
      //   break;
      // case 4:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.info,
      //     animType: AnimType.rightSlide,
      //     title: 'Information',
      //     desc: 'Here is some important information.',
      //     btnOkOnPress: () {},
      //   ).show();
      //   break;
      // case 5:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.infoReverse,
      //     animType: AnimType.scale,
      //     title: 'Custom Dialog',
      //     desc: '',
      //     body: Center(
      //       child: Column(
      //         children: <Widget>[
      //           Text('This is a custom dialog body.'),
      //           SizedBox(height: 10),
      //           ElevatedButton(
      //             onPressed: () {},
      //             child: Text('Action'),
      //           ),
      //         ],
      //       ),
      //     ),
      //     btnOkOnPress: () {},
      //   ).show();
      //   break;
      // case 6:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.question,
      //     animType: AnimType.scale,
      //     title: 'Question',
      //     desc: 'Do you want to save changes?',
      //     btnCancelOnPress: () {},
      //     btnOkOnPress: () {},
      //   ).show();
      //   break;
      // case 7:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.warning,
      //     animType: AnimType.rightSlide,
      //     title: 'Confirmation',
      //     desc: 'Do you really want to delete this item?',
      //     btnCancel: ElevatedButton(
      //       child: Text('No'),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //     btnOk: ElevatedButton(
      //       child: Text('Yes'),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //   ).show();
      //   break;
      // case 8:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.noHeader,
      //     body: Center(
      //       child: Column(
      //         children: <Widget>[
      //           Text(
      //             'No Header Dialog',
      //             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      //           ),
      //           SizedBox(height: 10),
      //           Text('This dialog does not have a header.'),
      //           SizedBox(height: 10),
      //           ElevatedButton(
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //             child: Text('Close'),
      //           ),
      //         ],
      //       ),
      //     ),
      //     btnOkOnPress: () {},
      //   ).show();
      //   break;
      // case 9:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.info,
      //     animType: AnimType.bottomSlide,
      //     customHeader: Icon(
      //       Icons.info,
      //       size: 50,
      //       color: Colors.blue,
      //     ),
      //     title: 'Custom Animation',
      //     desc: 'This dialog uses a custom header icon.',
      //     btnOkOnPress: () {},
      //   ).show();
      //   break;
      // case 10:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.info,
      //     animType: AnimType.scale,
      //     title: 'Rich Text',
      //     desc: '',
      //     body: RichText(
      //       text: TextSpan(
      //         children: [
      //           TextSpan(
      //             text: 'This is an ',
      //             style: TextStyle(color: Colors.black),
      //           ),
      //           TextSpan(
      //             text: 'important',
      //             style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      //           ),
      //           TextSpan(
      //             text: ' message.',
      //             style: TextStyle(color: Colors.black),
      //           ),
      //         ],
      //       ),
      //     ),
      //     btnOkOnPress: () {},
      //   ).show();
      //   break;
      // case 11:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.info,
      //     customHeader: Container(
      //       height: 50,
      //       width: 50,
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         color: Colors.blue,
      //       ),
      //       child: Center(
      //         child: Icon(
      //           Icons.person,
      //           size: 30,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     title: 'Custom Header',
      //     desc: 'This dialog uses a custom header widget.',
      //     btnOkOnPress: () {},
      //   ).show();
      //   break;
      // case 12:
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.info,
      //     animType: AnimType.scale,
      //     title: 'Auto Dismiss',
      //     desc: 'This dialog will close automatically after 3 seconds.',
      //     btnOkOnPress: () {},
      //     autoHide: Duration(seconds: 3),
      //   ).show();
      //   break;

//         case 13:
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.info,
//           animType: AnimType.scale,
//           title: 'Auto Dismiss',
//           desc: 'This dialog will close automatically after 3 seconds.',
//           btnOkOnPress: () {},
//           autoHide: Duration(seconds: 3),
//         ).show();
//         break;
//       case 14:
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.info,
//           animType: AnimType.scale,
//           title: 'Custom Background Color',
//           desc: 'This dialog has a custom background color.',
//           btnOkOnPress: () {},
//           dialogBackgroundColor: Colors.green[100],
//         ).show();
//         break;
//       case 15:
//         TextEditingController inputController = TextEditingController();
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.noHeader,
//           body: Column(
//             children: <Widget>[
//               Text(
//                 'Input Field Dialog',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: inputController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your input',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   String input = inputController.text;
//                   // Do something with the input
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//           btnOkOnPress: () {},
//         ).show();
//         break;
//       case 16:
//         bool isChecked = false;
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.noHeader,
//           body: StatefulBuilder(
//             builder: (context, setState) {
//               return Column(
//                 children: <Widget>[
//                   Text(
//                     'Checkbox Dialog',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: <Widget>[
//                       Checkbox(
//                         value: isChecked,
//                         onChanged: (value) {
//                           setState(() {
//                             isChecked = value!;
//                           });
//                         },
//                       ),
//                       Text('Accept terms and conditions'),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (isChecked) {
//                         // Do something if checkbox is checked
//                         Navigator.of(context).pop();
//                       } else {
//                         // Show a message if checkbox is not checked
//                       }
//                     },
//                     child: Text('Continue'),
//                   ),
//                 ],
//               );
//             },
//           ),
//           btnOkOnPress: () {},
//         ).show();
//         break;
//     }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Awesome Dialog Examples'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: List.generate(12, (index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: ElevatedButton(
//                   onPressed: () => showDialog(context, index + 1),
//                   child: Text('Show Dialog ${index + 1}'),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }


import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Dialog Examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DialogExamplePage(),
    );
  }
}

class DialogExamplePage extends StatelessWidget {
  void _showDialog(BuildContext context, int dialogNumber) {
    switch (dialogNumber) {
            case 1:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: 'Operation completed successfully!',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
        break;
      case 2:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.topSlide,
          title: 'Error',
          desc: 'Failed to complete operation.',
          btnOkOnPress: () {},
        ).show();
        break;
      case 3:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.leftSlide,
          title: 'Warning',
          desc: 'Are you sure you want to continue?',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
        break;
      case 4:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Information',
          desc: 'Here is some important information.',
          btnOkOnPress: () {},
        ).show();
        break;
      case 5:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.infoReverse,
          animType: AnimType.scale,
          title: 'Custom Dialog',
          desc: '',
          body: Center(
            child: Column(
              children: <Widget>[
                const Text('This is a custom dialog body.'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Action'),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {},
        ).show();
        break;
      case 6:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.question,
          animType: AnimType.scale,
          title: 'Question',
          desc: 'Do you want to save changes?',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
        break;
      case 7:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          title: 'Confirmation',
          desc: 'Do you really want to delete this item?',
          btnCancel: ElevatedButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          btnOk: ElevatedButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ).show();
        break;
      case 8:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.noHeader,
          body: Center(
            child: Column(
              children: <Widget>[
                const Text(
                  'No Header Dialog',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text('This dialog does not have a header.'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {},
        ).show();
        break;
      case 9:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.bottomSlide,
          customHeader: const Icon(
            Icons.info,
            size: 50,
            color: Colors.blue,
          ),
          title: 'Custom Animation',
          desc: 'This dialog uses a custom header icon.',
          btnOkOnPress: () {},
        ).show();
        break;
      case 10:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.scale,
          title: 'Rich Text',
          desc: '',
          body: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'This is an ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'important',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' message.',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {},
        ).show();
        break;
      case 11:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          customHeader: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          title: 'Custom Header',
          desc: 'This dialog uses a custom header widget.',
          btnOkOnPress: () {},
        ).show();
        break;
      case 12:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.scale,
          title: 'Auto Dismiss',
          desc: 'This dialog will close automatically after 3 seconds.',
          btnOkOnPress: () {},
          autoHide: const Duration(seconds: 3),
        ).show();
        break;


      
      case 13:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.scale,
          title: 'Auto Dismiss',
          desc: 'This dialog will close automatically after 3 seconds.',
          btnOkOnPress: () {},
          autoHide: const Duration(seconds: 3),
        ).show();
        break;
      case 14:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.scale,
          title: 'Custom Background Color',
          desc: 'This dialog has a custom background color.',
          btnOkOnPress: () {},
          dialogBackgroundColor: Colors.green[100],
        ).show();
        break;
      case 15:
        TextEditingController inputController = TextEditingController();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.noHeader,
          body: Column(
            children: <Widget>[
              const Text(
                'Input Field Dialog',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: inputController,
                decoration: const InputDecoration(
                  hintText: 'Enter your input',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String input = inputController.text;
                  // Do something with the input
                  Navigator.of(context).pop();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
          btnOkOnPress: () {},
        ).show();
        break;
      case 16:
        bool isChecked = false;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.noHeader,
          body: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: <Widget>[
                  const Text(
                    'Checkbox Dialog',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      const Text('Accept terms and conditions'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (isChecked) {
                        // Do something if checkbox is checked
                        Navigator.of(context).pop();
                      } else {
                        // Show a message if checkbox is not checked
                      }
                    },
                    child: const Text('Continue'),
                  ),
                ],
              );
            },
          ),
          btnOkOnPress: () {},
        ).show();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Dialog Examples'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(16, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
               child: ElevatedButton(
                  onPressed: () => _showDialog(context, index + 1),
                  child: Text('Show Dialog ${index + 1}'),
                ),
                
              );
            }),
          ),
        ),
      ),
    );
  }
}
