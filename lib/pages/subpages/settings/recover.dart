// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // // class RecoverPasswordScreen extends StatefulWidget {
// // //   const RecoverPasswordScreen({super.key});

// // //   @override
// // //   _RecoverPasswordScreenState createState() => _RecoverPasswordScreenState();
// // // }

// // // class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
// // //   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
// // //   final TextEditingController _securityAnswerController = TextEditingController();
// // //   String? _storedSecurityQuestion;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _loadSecurityQuestion();
// // //   }

// // //   Future<void> _loadSecurityQuestion() async {
// // //     String? question = await _secureStorage.read(key: 'securityQuestion');
// // //     setState(() {
// // //       _storedSecurityQuestion = question;
// // //     });
// // //   }

// // //   Future<void> _verifySecurityAnswer() async {
// // //     String? storedAnswer = await _secureStorage.read(key: 'securityAnswer');
// // //     if (_securityAnswerController.text == storedAnswer) {
// // //       await _secureStorage.delete(key: 'lockType');
// // //       await _secureStorage.delete(key: 'lockValue');
// // //       Navigator.pop(context);
// // //     } else {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text('Incorrect security answer')),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Recover Password'),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           children: [
// // //             Text(
// // //               _storedSecurityQuestion ?? 'No security question set',
// // //               style: const TextStyle(fontSize: 18),
// // //             ),
// // //             const SizedBox(height: 20),
// // //             TextField(
// // //               controller: _securityAnswerController,
// // //               decoration: const InputDecoration(
// // //                 labelText: 'Enter your answer',
// // //                 border: OutlineInputBorder(),
// // //               ),
// // //               obscureText: true,
// // //             ),
// // //             const SizedBox(height: 20),
// // //             ElevatedButton(
// // //               onPressed: _verifySecurityAnswer,
// // //               child: const Text('Verify Answer'),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';

// // class BillingPage2 extends StatelessWidget {
// //   final Map<String, dynamic> invoicedData;

// //   BillingPage2({required this.invoicedData});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Billing Page'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               'Customer Name: ${invoicedData["customerName"]}',
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(height: 16),
// //             Text(
// //               'Customer Address: ${invoicedData["customerAddress"]}',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             SizedBox(height: 8),
// //             Text(
// //               'Invoice ID: ${invoicedData["invoiceId"]}',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             SizedBox(height: 8),
// //             Text(
// //               'Invoice Date: ${invoicedData["invoiceDate"]}',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             SizedBox(height: 8),
// //             Text(
// //               'Due Date: ${invoicedData["dueDate"]}',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             SizedBox(height: 8),
// //             Text(
// //               'Payment Method: ${invoicedData["paymentMethod"]}',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             SizedBox(height: 8),
// //             Text(
// //               'Customer Email: ${invoicedData["customerEmail"]}',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             SizedBox(height: 8),
// //             Text(
// //               'Customer ID: ${invoicedData["customerID"]}',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             SizedBox(height: 8),
// //             Text(
// //               'Work Phone: ${invoicedData["workphone"]}',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             SizedBox(height: 8),
// //             Text(
// //               'Mobile: ${invoicedData["mobile"]}',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class BillingPage2 extends StatelessWidget {
//   final Map<String, dynamic>? invoicedData;

//   const BillingPage2({Key? key, this.invoicedData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Billing Page'),
//       ),
//       body: Center(
//         child: invoicedData != null
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Customer Name: ${invoicedData!["customerName"]}'),
//                   Text('Customer Address: ${invoicedData!["customerAddress"]}'),
//                   Text('Invoice ID: ${invoicedData!["invoiceId"]}'),
//                   Text('Invoice Date: ${invoicedData!["invoiceDate"]}'),
//                   Text('Payment Method: ${invoicedData!["paymentMethod"]}'),
//                   Text('Due Date: ${invoicedData!["dueDate"]}'),
//                   Text('Status: ${invoicedData!["status"]}'),
//                 ],
//               )
//             : Text('No invoiced data received'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BillingPage2 extends StatelessWidget {
  final Map<String, dynamic>? invoicedData;

  const BillingPage2({Key? key, this.invoicedData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing Page'),
      ),
      body: Center(
        child: invoicedData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer Name: ${invoicedData!["customerName"]}'),
                  Text('Customer Address: ${invoicedData!["customerAddress"]}'),
                  Text('Invoice ID: ${invoicedData!["invoiceId"]}'),
                  Text('Invoice Date: ${invoicedData!["invoiceDate"]}'),
                  Text('Payment Method: ${invoicedData!["paymentMethod"]}'),
                  Text('Due Date: ${invoicedData!["dueDate"]}'),
                  Text('Status: ${invoicedData!["status"]}'),
                ],
              )
            : const Text('No invoiced data received'),
      ),
    );
  }
}
