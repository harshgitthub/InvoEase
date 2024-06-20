// // import 'package:cloneapp/pages/home.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloneapp/pages/subpages/billing.dart';
// // import 'package:intl/intl.dart';

// // class InvoiceView extends StatefulWidget {
// //   const InvoiceView({super.key});

// //   @override
// //   State<InvoiceView> createState() => _InvoiceViewState();
// // }

// // class _InvoiceViewState extends State<InvoiceView> {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   late User? currentUser;
// //   String _searchQuery = '';

// //   @override
// //   void initState() {
// //     super.initState();
// //     currentUser = _auth.currentUser;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return DefaultTabController(
// //       length: 3, // Number of tabs: All, Unpaid, and Paid
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("INVOICE"),
// //           leading: Builder(
// //             builder: (BuildContext context) {
// //               return IconButton(
// //                 icon: const Icon(Icons.menu),
// //                 onPressed: () {
// //                   Scaffold.of(context).openDrawer();
// //                 },
// //                 tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
// //               );
// //             },
// //           ),
// //           actions: [
// //              IconButton(
            
// //           onPressed: () {
// //             Navigator.pushNamed(context, '/invoiceadd');
// //           },
// //           icon: const Icon(Icons.add ),

// //         ),
// //            IconButton(
// //   icon: const Icon(Icons.search),
// //   onPressed: () {
// //     showSearch(
// //       context: context,
// //       delegate: InvoiceSearchDelegate(
// //         currentUser: currentUser,
// //         onQueryChanged: (query) {
// //           // Defer the state update until after the build cycle completes
// //           WidgetsBinding.instance.addPostFrameCallback((_) {
// //             setState(() {
// //               _searchQuery = query;
// //             });
// //           });
// //         },
// //       ),
// //     );
// //   },
// // ),


// //           ],
// //          bottom: const TabBar(
// //   tabs: [
// //     Tab(text: 'All'),
// //     Tab(text: 'Unpaid'),
// //     Tab(text: 'Paid'),
// //   ],
// //   labelStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.bold , color: Colors.blue), // Selected tab style
// //   unselectedLabelStyle: TextStyle(fontSize: 16 , color: Colors.black,) // Unselected tabs style
// // ),

// //         ),
// //         drawer: drawer(context),
       
// //         body: TabBarView(
// //           children: [
// //             _buildInvoiceList(context, null), // All invoices
// //             _buildInvoiceList(context, false), // Unpaid invoices
// //             _buildInvoiceList(context, true), // Paid invoices
// //           ],
// //         ),
// //       ),
// //     );
// //   }


// //   Widget _buildInvoiceList(BuildContext context, bool? isPaid) {
// //   return StreamBuilder<QuerySnapshot>(
// //     stream: FirebaseFirestore.instance
// //         .collection("USERS")
// //         .doc(currentUser!.uid)
// //         .collection("invoices")
// //         .snapshots(),
// //     builder: (context, snapshot) {
// //       if (snapshot.connectionState == ConnectionState.waiting) {
// //         return const Center(child: CircularProgressIndicator());
// //       } else if (snapshot.hasError) {
// //         return Center(child: Text('Error: ${snapshot.error}'));
// //       } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //         return const Center(child: Text('No invoices found.'));
// //       }

// //       var invoices = snapshot.data!.docs;

// //       // Filter invoices based on the search query and paid status
// //       invoices = invoices.where((doc) {
// //         var invoice = doc.data() as Map<String, dynamic>;
// //         var customerName = invoice['customerName'].toString().toLowerCase();

// //         if (_searchQuery.isNotEmpty && !customerName.contains(_searchQuery.toLowerCase())) {
// //           return false;
// //         }

// //         if (isPaid == null) {
// //           return true; // All invoices
// //         }

// //         return invoice['status'] == isPaid;
// //       }).toList();

// //       return ListView.builder(
// //         itemCount: invoices.length,
// //         itemBuilder: (context, index) {
// //           var invoice = invoices[index].data() as Map<String, dynamic>;
// //           var docId = invoices[index].id;
// //           var isInvoicePaid = invoice['status'] ?? false;
// //           var dueDate = invoice['dueDate']?.toDate();
// //           var formattedDueDate = dueDate != null
// //               ? DateFormat('yyyy-MM-dd HH:mm').format(dueDate) // Format due date
// //               : 'No due date';

// //           var isOverdue = !isInvoicePaid && dueDate != null && dueDate.isBefore(DateTime.now());

// //           return ListTile(
// //             contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
// //             title: Text(
// //               '${invoice['customerName'] ?? 'No customer name'}',
// //               style: const TextStyle(fontSize: 20),
// //             ),
// //             subtitle: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text('customer ID: ${invoice['customerID']?.toString() ?? ''}' , style: const TextStyle(fontSize: 15),),
// //                 Text('Date: ${invoice['invoiceDate']?.toString() ?? 'No invoice date'}' , style: const TextStyle(fontSize: 15),),
// //                 Text('Due Date: $formattedDueDate',style: const TextStyle(fontSize: 15)),
// //                 if (isOverdue) const Text('Status: Overdue', style: TextStyle(color: Colors.red , fontSize: 15)),
// //               ],
// //             ),
// //             trailing: Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                Text(
// //   isInvoicePaid ? 'Paid' : 'Unpaid',
// //   style: TextStyle(color: isInvoicePaid ? Colors.green  : Colors.red , fontSize: 15),
// // ),
// //                 Checkbox(
// //                   value: isInvoicePaid,
// //                   onChanged: (value) {
// //                     FirebaseFirestore.instance
// //                         .collection("USERS")
// //                         .doc(currentUser!.uid)
// //                         .collection("invoices")
// //                         .doc(docId)
// //                         .update({
// //                           'status': value, // Update 'status' field in Firestore
// //                         },);
// //                   },
// //                 ),
// //                 IconButton(
// //                   icon: const Icon(Icons.delete, color: Colors.red),
// //                   onPressed: () {
// //                     _deleteInvoice(currentUser!.uid, docId);
// //                   },
// //                 ),
// //               ],
// //             ),
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => BillingPage(invoice: invoice),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       );
// //     },
// //   );
// // }


// //   void _deleteInvoice(String userId, String docId) async {
// //     await FirebaseFirestore.instance
// //         .collection("USERS")
// //         .doc(userId)
// //         .collection("invoices")
// //         .doc(docId)
// //         .delete();
// //   }
// // }
// // class InvoiceSearchDelegate extends SearchDelegate<String> {
// //   final User? currentUser;
// //   final ValueChanged<String>? onQueryChanged;

// //   InvoiceSearchDelegate({required this.currentUser, this.onQueryChanged});

// //   @override
// //   List<Widget>? buildActions(BuildContext context) {
// //     return [
// //       IconButton(
// //         icon: const Icon(Icons.clear),
// //         onPressed: () {
// //           clearSearchQuery();
// //         },
// //       ),
// //     ];
// //   }

// //   void clearSearchQuery() {
// //     query = '';
// //     onQueryChanged?.call(query);
// //   }

// //   @override
// //   Widget? buildLeading(BuildContext context) {
// //     return IconButton(
// //       icon: const Icon(Icons.arrow_back),
// //       onPressed: () {
// //         close(context, '');
// //       },
// //     );
// //   }

// //   @override
// //   Widget buildResults(BuildContext context) {
// //     onQueryChanged?.call(query);
// //     return Container();
// //   }

// //   @override
// //   Widget buildSuggestions(BuildContext context) {
// //     onQueryChanged?.call(query);
// //     return Container();
// //   }
// // }

// import 'package:cloneapp/pages/home.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:cloneapp/pages/subpages/billing.dart';

// class InvoiceView extends StatefulWidget {
//   const InvoiceView({Key? key}) : super(key: key);

//   @override
//   State<InvoiceView> createState() => _InvoiceViewState();
// }

// class _InvoiceViewState extends State<InvoiceView> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   late User? currentUser;
//   bool sortByCustomerName = true; // Default sorting by customer name
//   bool sortByDueDate = false;
//   bool sortByInvoiceDate = false;

//   @override
//   void initState() {
//     super.initState();
//     currentUser = _auth.currentUser;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3, // Number of tabs: All, Unpaid, and Paid
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("INVOICE"),
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: const Icon(Icons.menu),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//                 tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//               );
//             },
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/invoiceadd');
//               },
//               icon: const Icon(Icons.add),
//             ),
//             IconButton(
//               onPressed: () {
//                 _toggleSortByCustomerName();
//               },
//               icon: Icon(sortByCustomerName ? Icons.sort_by_alpha : Icons.sort),
//             ),
//             IconButton(
//               onPressed: () {
//                 _toggleSortByDueDate();
//               },
//               icon: Icon(sortByDueDate ? Icons.date_range : Icons.sort),
//             ),
//             IconButton(
//               onPressed: () {
//                 _toggleSortByInvoiceDate();
//               },
//               icon: Icon(sortByInvoiceDate ? Icons.calendar_today : Icons.sort),
//             ),
//           ],
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'All'),
//               Tab(text: 'Unpaid'),
//               Tab(text: 'Paid'),
//             ],
//             labelStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.blue), // Selected tab style
//             unselectedLabelStyle: TextStyle(fontSize: 16, color: Colors.black), // Unselected tabs style
//           ),
//         ),
//         drawer: drawer(context),
//         body: TabBarView(
//           children: [
//             _buildInvoiceList(context, null), // All invoices
//             _buildInvoiceList(context, false), // Unpaid invoices
//             _buildInvoiceList(context, true), // Paid invoices
//           ],
//         ),
//       ),
//     );
//   }

//   void _toggleSortByCustomerName() {
//     setState(() {
//       sortByCustomerName = !sortByCustomerName;
//       sortByDueDate = false;
//       sortByInvoiceDate = false;
//     });
//   }

//   void _toggleSortByDueDate() {
//     setState(() {
//       sortByDueDate = !sortByDueDate;
//       sortByCustomerName = false;
//       sortByInvoiceDate = false;
//     });
//   }

//   void _toggleSortByInvoiceDate() {
//     setState(() {
//       sortByInvoiceDate = !sortByInvoiceDate;
//       sortByCustomerName = false;
//       sortByDueDate = false;
//     });
//   }

//   Widget _buildInvoiceList(BuildContext context, bool? isPaid) {
//     Query invoicesQuery = FirebaseFirestore.instance
//         .collection("USERS")
//         .doc(currentUser!.uid)
//         .collection("invoices");

//     // Sorting options
//     if (sortByCustomerName) {
//       invoicesQuery = invoicesQuery.orderBy('customerName', descending: false);
//     } else if (sortByDueDate) {
//       invoicesQuery = invoicesQuery.orderBy('dueDate', descending: false);
//     } else if (sortByInvoiceDate) {
//       invoicesQuery = invoicesQuery.orderBy('invoiceDate', descending: false);
//     }

//     return StreamBuilder<QuerySnapshot>(
//       stream: invoicesQuery.snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No invoices found.'));
//         }

//         var invoices = snapshot.data!.docs;

//         // Filter invoices based on the paid status
//         invoices = invoices.where((doc) {
//           var invoice = doc.data() as Map<String, dynamic>;

//           if (isPaid == null) {
//             return true; // All invoices
//           }

//           return invoice['status'] == isPaid;
//         }).toList();

//         return ListView.builder(
//           itemCount: invoices.length,
//           itemBuilder: (context, index) {
//             var invoice = invoices[index].data() as Map<String, dynamic>;
//             var docId = invoices[index].id;
//             var isInvoicePaid = invoice['status'] ?? false;
//             var dueDate = (invoice['dueDate'] as Timestamp?)?.toDate();
//             var invoiceDate = (invoice['invoiceDate'] as Timestamp?)?.toDate();
//             var formattedDueDate = dueDate != null
//                 ? DateFormat('yyyy-MM-dd HH:mm').format(dueDate) // Format due date
//                 : 'No due date';
//             var formattedInvoiceDate = invoiceDate != null
//                 ? DateFormat('yyyy-MM-dd HH:mm').format(invoiceDate) // Format invoice date
//                 : 'No invoice date';
//             var isOverdue = !isInvoicePaid && dueDate != null && dueDate.isBefore(DateTime.now());

//             return ListTile(
//               contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//               title: Text(
//                 '${invoice['customerName'] ?? 'No customer name'}',
//                 style: const TextStyle(fontSize: 20),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Customer ID: ${invoice['customerID']?.toString() ?? ''}', style: const TextStyle(fontSize: 15)),
//                   Text('Invoice Date: $formattedInvoiceDate', style: const TextStyle(fontSize: 15)),
//                   Text('Due Date: $formattedDueDate', style: const TextStyle(fontSize: 15)),
//                   if (isOverdue) const Text('Status: Overdue', style: TextStyle(color: Colors.red, fontSize: 15)),
//                 ],
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     isInvoicePaid ? 'Paid' : 'Unpaid',
//                     style: TextStyle(color: isInvoicePaid ? Colors.green : Colors.red, fontSize: 15),
//                   ),
//                   Checkbox(
//                     value: isInvoicePaid,
//                     onChanged: (value) {
//                       FirebaseFirestore.instance.collection("USERS").doc(currentUser!.uid).collection("invoices").doc(docId).update({
//                         'status': value, // Update 'status' field in Firestore
//                       });
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     onPressed: () {
//                       _deleteInvoice(currentUser!.uid, docId);
//                     },
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BillingPage(invoice: invoice),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   void _deleteInvoice(String userId, String docId) async {
//     await FirebaseFirestore.instance
//         .collection("USERS")
//         .doc(userId)
//         .collection("invoices")
//         .doc(docId)
//         .delete();
//   }
// }


import 'package:cloneapp/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';  // Import intl package for date formatting
import 'package:cloneapp/pages/subpages/billing.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({Key? key}) : super(key: key);

  @override
  State<InvoiceView> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? currentUser;
  int? _selectedSortOption = 0; // Default sorting by customer name

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs: All, Unpaid, and Paid
      child: Scaffold(
        appBar: AppBar(
          title: const Text("INVOICE"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/invoiceadd');
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                _showSortOptionsDialog(context);
              },
              icon: const Icon(Icons.sort),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Unpaid'),
              Tab(text: 'Paid'),
            ],
            labelStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.blue), // Selected tab style
            unselectedLabelStyle: TextStyle(fontSize: 16, color: Colors.black), // Unselected tabs style
          ),
        ),
        drawer: drawer(context),
        body: TabBarView(
          children: [
            _buildInvoiceList(context, null), // All invoices
            _buildInvoiceList(context, false), // Unpaid invoices
            _buildInvoiceList(context, true), // Paid invoices
          ],
        ),
      ),
    );
  }

  void _showSortOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sort Invoices'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Sort by Customer Name'),
                leading: Radio<int>(
                  value: 0,
                  groupValue: _selectedSortOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedSortOption = value;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: const Text('Sort by Due Date'),
                leading: Radio<int>(
                  value: 1,
                  groupValue: _selectedSortOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedSortOption = value;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: const Text('Sort by Invoice Date'),
                leading: Radio<int>(
                  value: 2,
                  groupValue: _selectedSortOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedSortOption = value;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInvoiceList(BuildContext context, bool? isPaid) {
    Query invoicesQuery = FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentUser!.uid)
        .collection("invoices");

    // Sorting options
    switch (_selectedSortOption) {
      case 0:
        invoicesQuery = invoicesQuery.orderBy('customerName', descending: false);
        break;
      case 1:
        invoicesQuery = invoicesQuery.orderBy('dueDate', descending: false);
        break;
      case 2:
        invoicesQuery = invoicesQuery.orderBy('invoiceDate', descending: false);
        break;
      default:
        invoicesQuery = invoicesQuery.orderBy('customerName', descending: false);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: invoicesQuery.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No invoices found.'));
        }

        var invoices = snapshot.data!.docs;

        // Filter invoices based on the paid status
        invoices = invoices.where((doc) {
          var invoice = doc.data() as Map<String, dynamic>;

          if (isPaid == null) {
            return true; // All invoices
          }

          return invoice['status'] == isPaid;
        }).toList();

        return ListView.builder(
          itemCount: invoices.length,
          itemBuilder: (context, index) {
            var invoice = invoices[index].data() as Map<String, dynamic>;
            var docId = invoices[index].id;
            var isInvoicePaid = invoice['status'] ?? false;

            var dueDate = invoice['dueDate'];
            var invoiceDate = invoice['invoiceDate'];

            // Format the dates
            var formattedDueDate = dueDate != null
                ? DateFormat('MMMM d, yyyy').format((dueDate as Timestamp).toDate())
                : 'No due date';
            var formattedInvoiceDate = invoiceDate != null
                ? DateFormat('MMMM d, yyyy').format((invoiceDate as Timestamp).toDate())
                : 'No invoice date';

            var isOverdue = !isInvoicePaid && dueDate != null && (dueDate as Timestamp).toDate().isBefore(DateTime.now());

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              title: Text(
                '${invoice['customerName'] ?? 'No customer name'}',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer ID: ${invoice['customerID']?.toString() ?? ''}', style: const TextStyle(fontSize: 15)),
                  Text('Invoice Date: $formattedInvoiceDate', style: const TextStyle(fontSize: 15)),
                  Text('Due Date: $formattedDueDate', style: const TextStyle(fontSize: 15)),
                  if (isOverdue) const Text('Status: Overdue', style: TextStyle(color: Colors.red, fontSize: 15)),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isInvoicePaid ? 'Paid' : 'Unpaid',
                    style: TextStyle(color: isInvoicePaid ? Colors.green : Colors.red, fontSize: 15),
                  ),
                  Checkbox(
                    value: isInvoicePaid,
                    onChanged: (value) {
                      FirebaseFirestore.instance.collection("USERS").doc(currentUser!.uid).collection("invoices").doc(docId).update({
                        'status': value, // Update 'status' field in Firestore
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteInvoice(currentUser!.uid, docId);
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BillingPage(invoice: invoice),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _deleteInvoice(String userId, String docId) async {
    await FirebaseFirestore.instance
        .collection("USERS")
        .doc(userId)
        .collection("invoices")
        .doc(docId)
        .delete();
  }
}
