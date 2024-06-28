// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class Invoicedata extends StatefulWidget {
// //   const Invoicedata({super.key});

// //   @override
// //   _InvoicedataState createState() => _InvoicedataState();
// // }

// // class _InvoicedataState extends State<Invoicedata> {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   User? currentUser;
// //   CollectionReference termsCollection =
// //       FirebaseFirestore.instance.collection('USERS');

// //   List<Term> termsAndConditions = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     currentUser = _auth.currentUser;
// //     if (currentUser != null) {
// //       fetchTermsAndConditions();
// //     }
// //   }

// //   Future<void> fetchTermsAndConditions() async {
// //     try {
// //       QuerySnapshot querySnapshot = await termsCollection
// //           .doc(currentUser!.uid)
// //           .collection('terms')
// //           .orderBy('index') // Order by the 'index' field
// //           .get();

// //       List<Term> tempList = [];

// //       querySnapshot.docs.forEach((doc) {
// //         tempList.add(Term(
// //           id: doc.id,
// //           text: doc['text'],
// //         ));
// //       });

// //       setState(() {
// //         termsAndConditions = tempList;
// //       });
// //     } catch (e) {
// //       print('Error fetching terms and conditions: $e');
// //     }
// //   }

// //   Future<void> addTermAndCondition(String text, int newIndex) async {
// //     try {
// //       await termsCollection
// //           .doc(currentUser!.uid)
// //           .collection('terms')
// //           .add({
// //             'text': text,
// //             'index': newIndex,
// //           });

// //       // Fetch updated terms list
// //       await fetchTermsAndConditions();
// //     } catch (e) {
// //       print('Error adding term and condition: $e');
// //     }
// //   }

// //   Future<void> deleteTermAndCondition(String id) async {
// //     try {
// //       await termsCollection
// //           .doc(currentUser!.uid)
// //           .collection('terms')
// //           .doc(id)
// //           .delete();

// //       // Fetch updated terms list
// //       await fetchTermsAndConditions();
// //     } catch (e) {
// //       print('Error deleting term and condition: $e');
// //     }
// //   }

// //   Future<void> updateTermAndCondition(String id, String newText) async {
// //     try {
// //       await termsCollection
// //           .doc(currentUser!.uid)
// //           .collection('terms')
// //           .doc(id)
// //           .update({
// //             'text': newText,
// //           });

// //       // Fetch updated terms list
// //       await fetchTermsAndConditions();
// //     } catch (e) {
// //       print('Error updating term and condition: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Terms and Conditions'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: termsAndConditions.length,
// //         itemBuilder: (context, index) {
// //           Term term = termsAndConditions[index];
// //           String termNumber = 'Term ${index + 1}';

// //           return ListTile(
// //             title: Text('$termNumber: ${term.text}'),
// //             trailing: Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 IconButton(
// //                   icon: const Icon(Icons.edit),
// //                   onPressed: () {
// //                     _showEditTermDialog(term);
// //                   },
// //                 ),
// //                 IconButton(
// //                   icon: const Icon(Icons.delete),
// //                   onPressed: () {
// //                     deleteTermAndCondition(term.id);
// //                   },
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           _showAddTermDialog();
// //         },
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }

// //   void _showAddTermDialog() {
// //     TextEditingController textController = TextEditingController();

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: const Text('Add Term and Condition'),
// //           content: TextField(
// //             controller: textController,
// //             decoration: const InputDecoration(hintText: 'Enter term and condition'),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context);
// //               },
// //               child: const Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 String text = textController.text;
// //                 if (text.isNotEmpty) {
// //                   // Determine the new index based on the current list size
// //                   int newIndex = termsAndConditions.length;
// //                   addTermAndCondition(text, newIndex);
// //                 }
// //                 Navigator.pop(context);
// //               },
// //               child: const Text('Save'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _showEditTermDialog(Term term) {
// //     TextEditingController textController =
// //         TextEditingController(text: term.text);

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: const Text('Edit Term and Condition'),
// //           content: TextField(
// //             controller: textController,
// //             decoration:
// //                 const InputDecoration(hintText: 'Edit term and condition'),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context);
// //               },
// //               child: const Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 String newText = textController.text;
// //                 if (newText.isNotEmpty) {
// //                   updateTermAndCondition(term.id, newText);
// //                 }
// //                 Navigator.pop(context);
// //               },
// //               child: const Text('Save'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }

// // class Term {
// //   final String id;
// //   final String text;

// //   Term({required this.id, required this.text});
// // }
// import 'package:flutter/material.dart';

// class InvoiceTemplate extends StatelessWidget {
//   const InvoiceTemplate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Invoice Templates'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // Number of columns in the grid
//             crossAxisSpacing: 16.0,
//             mainAxisSpacing: 16.0,
//             childAspectRatio: 0.75, // Aspect ratio of each card
//           ),
//           itemCount: invoiceTemplates.length,
//           itemBuilder: (context, index) {
//             final template = invoiceTemplates[index];
//             return Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: template.color,
//                         borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Invoice #12345',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Date: 01/01/2024',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.white70,
//                               ),
//                             ),
//                             Spacer(),
//                             Text(
//                               'Total: \$1000',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       template.name,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class InvoiceTemplateModel {
//   final String name;
//   final Color color;

//   InvoiceTemplateModel(this.name, this.color);
// }

// // Sample data for the templates
// final List<InvoiceTemplateModel> invoiceTemplates = [
//   InvoiceTemplateModel('Classic', Colors.blue),
//   InvoiceTemplateModel('Modern', Colors.green),
//   InvoiceTemplateModel('Professional', Colors.red),
//   InvoiceTemplateModel('Simple', Colors.orange),
//   // Add more templates as needed
// ];
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InvoiceTemplate extends StatefulWidget {
  const InvoiceTemplate({Key? key}) : super(key: key);

  @override
  _InvoiceTemplateState createState() => _InvoiceTemplateState();
}

class _InvoiceTemplateState extends State<InvoiceTemplate> {
  final PageController _pageController = PageController();

  void _navigateToFullScreenTemplate(BuildContext context, InvoiceTemplateModel template) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenTemplate(template: template),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Templates'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: invoiceTemplates.length,
              itemBuilder: (context, index) {
                final template = invoiceTemplates[index];
                return GestureDetector(
                  onTap: () => _navigateToFullScreenTemplate(context, template),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Hero(
                      tag: template.name,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: template.color,
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Invoice #12345',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Date: 01/01/2024',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Total: \$1000',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                template.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: invoiceTemplates.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8.0,
                dotWidth: 8.0,
                activeDotColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InvoiceTemplateModel {
  final String name;
  final Color color;

  InvoiceTemplateModel(this.name, this.color);
}

final List<InvoiceTemplateModel> invoiceTemplates = [
  InvoiceTemplateModel('Classic', Colors.blue),
  InvoiceTemplateModel('Modern', Colors.green),
  InvoiceTemplateModel('Professional', Colors.red),
  InvoiceTemplateModel('Simple', Colors.orange),
  // Add more templates as needed
];

class FullScreenTemplate extends StatelessWidget {
  final InvoiceTemplateModel template;

  const FullScreenTemplate({Key? key, required this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(template.name),
      ),
      body: Center(
        child: Hero(
          tag: template.name,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: template.color,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Invoice #12345',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Date: 01/01/2024',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCustomerInfo(), // Custom method for customer details
                  const SizedBox(height: 16),
                  _buildLineItemsTable(), // Custom method for invoice line items
                  const Spacer(),
                  const Text(
                    'Total: \$1000',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'John Doe',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildLineItemsTable() {
    // Example table structure, replace with actual data and widgets as needed
    return Table(
      columnWidths: {
        0: const FlexColumnWidth(1),
        1: const FlexColumnWidth(2),
        2: const FlexColumnWidth(1),
      },
      children: [
        const TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Item',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Item 1',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Description of item 1',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '\$500',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
        const TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Item 2',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Description of item 2',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '\$500',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}