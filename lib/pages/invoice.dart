// import 'package:cloneapp/pages/home.dart';
// import 'package:flutter/material.dart';
// // import 'package:share/share.dart';

// class Invoice extends StatefulWidget {
//   const Invoice({super.key});

//   @override
//   State<Invoice> createState() => _InvoiceState();
// }

// class _InvoiceState extends State<Invoice> {

  
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4, // Number of tabs
//       child: Scaffold(
//     // return Scaffold(
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
//               icon: const Icon(Icons.filter),
//               onPressed: () {
//                 // Implement filter functionality
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {
//                 // Implement search functionality
//               },
//             ),
//           ],
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'All'),
//               Tab(text: 'Unpaid'),
//               Tab(text: 'Paid'),
//               Tab(text: 'Draft'),
//             ],
//           ),
//         ),
//         drawer: drawer(context),
//         floatingActionButton: FloatingActionButton(
        
//         onPressed: () {
//           Navigator.pushNamed(context, '/invoiceadd');
//         },
//         child: const Icon(Icons.add),
//       ),
//     )
//     );
//     // );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Invoice extends StatefulWidget {
//   const Invoice({super.key});

//   @override
//   State<Invoice> createState() => _InvoiceState();
// }

// class _InvoiceState extends State<Invoice> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? get currentUser => _auth.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4, // Number of tabs
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
//               icon: const Icon(Icons.filter),
//               onPressed: () {
//                 // Implement filter functionality
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {
//                 // Implement search functionality
//               },
//             ),
//           ],
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'All'),
//               Tab(text: 'Unpaid'),
//               Tab(text: 'Paid'),
//               Tab(text: 'Draft'),
//             ],
//           ),
//         ),
//         drawer: Drawer(
//           // Implement your drawer widget here
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/invoiceadd');
//           },
//           child: const Icon(Icons.add),
//         ),
//         body: TabBarView(
//           children: [
//             buildInvoiceList(context, 'All'),
//             buildInvoiceList(context, 'Unpaid'),
//             buildInvoiceList(context, 'Paid'),
//             buildInvoiceList(context, 'Draft'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildInvoiceList(BuildContext context, String status) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentUser!.uid)
//           .collection("invoices")
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No invoices found.'));
//         }

//         var invoices = snapshot.data!.docs;

//         if (status != 'All') {
//           invoices = invoices.where((doc) {
//             return doc['status'] == status;
//           }).toList();
//         }

//         return ListView.builder(
//           itemCount: invoices.length,
//           itemBuilder: (context, index) {
//             var invoice = invoices[index];
//             return ListTile(
//               title: Text(invoice['customerName'] ?? 'No customer name'),
//               subtitle: Text('Due Date: ${invoice['dueDate']?.toDate().toString() ?? 'No due date'}'),
//               trailing: Text('Status: ${invoice['status'] ?? 'No status'}'),
//               onTap: () {
//                 // Implement your invoice detail view navigation here
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Invoice extends StatefulWidget {
//   const Invoice({super.key});

//   @override
//   State<Invoice> createState() => _InvoiceState();
// }

// class _InvoiceState extends State<Invoice> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? get currentUser => _auth.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4, // Number of tabs
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
//               icon: const Icon(Icons.filter),
//               onPressed: () {
//                 // Implement filter functionality
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {
//                 // Implement search functionality
//               },
//             ),
//           ],
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'All'),
//               Tab(text: 'Unpaid'),
//               Tab(text: 'Paid'),
//               Tab(text: 'Draft'),
//             ],
//           ),
//         ),
//         drawer: Drawer(
//           // Implement your drawer widget here
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/invoiceadd');
//           },
//           child: const Icon(Icons.add),
//         ),
//         body: TabBarView(
//           children: [
//             buildInvoiceList(context),
//             buildInvoiceList(context),
//             buildInvoiceList(context),
//             buildInvoiceList(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildInvoiceList(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentUser!.uid)
//           .collection("invoices")
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No invoices found.'));
//         }

//         var invoices = snapshot.data!.docs;

//         return ListView.builder(
//           itemCount: invoices.length,
//           itemBuilder: (context, index) {
//             var invoice = invoices[index];
//             return ListTile(
//               title: Text(invoice['customerName'] ?? 'No invoice number'),
//               subtitle: Text('InvoiceId: ${invoice['invoiceId']?.toString() ?? 'No due date'}' " " 'Payment Method : ${invoice["paymentMethod"]?.toString() ?? 'No due date'}'),
//               trailing: Text('invoiceDate ${invoice['invoiceDate']?.toString()  ?? 'No due date'}'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/invoiceadd');
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/subpages/billing.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({super.key});

  @override
  State<InvoiceView> createState() => _InvoiceState();
}

class _InvoiceState extends State<InvoiceView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
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
              icon: const Icon(Icons.filter),
              onPressed: () {
                // Implement filter functionality
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Implement search functionality
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Unpaid'),
              Tab(text: 'Paid'),
              Tab(text: 'Draft'),
            ],
          ),
        ),
        drawer: drawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/invoiceadd');
          },
          child: const Icon(Icons.add),
        ),
        body: TabBarView(
          children: [
            buildInvoiceList(context),
            buildInvoiceList(context),
            buildInvoiceList(context),
            buildInvoiceList(context),
          ],
        ),
      ),
    );
  }

  Widget buildInvoiceList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("invoices")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No invoices found.'));
        }

        var invoices = snapshot.data!.docs;

        return ListView.builder(
          itemCount: invoices.length,
          itemBuilder: (context, index) {
            var invoice = invoices[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text( '${invoice['customerName'] ?? 'No customer name'}' , style: const TextStyle(fontSize: 20),),
              subtitle: Text('Invoice Date: ${invoice['invoiceDate']?.toString() ?? 'No invoice date'}'),
              trailing: Text('Invoice Id: ${invoice['invoiceId'] ?? 'No status'}' , style:const TextStyle(fontSize: 15),),
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
}
