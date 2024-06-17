
// import 'package:cloneapp/pages/home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Customerpage extends StatefulWidget {
//   const Customerpage({super.key});

//  @override
//   State<Customerpage> createState() => _CustomerpageState();
// }
// class _CustomerpageState extends State<Customerpage> {
//   final User? currentUser = FirebaseAuth.instance.currentUser;

//   String selectedFilter = 'All';
//   // final String mobileNumber = currentUser.

//   // void _makePhoneCall() async {
//   //   if (await canLaunchUrlUrl('tel:$mobileNumber')) {
//   //     await launchUrl('tel:$mobileNumber');
//   //   } else {
//   //     throw 'Could not launch $mobileNumber';
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Customers"),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.menu),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
              
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: () {
//               // Implement filter options (e.g., dropdown menu)
//               _showFilterOptions();
//             },
//           ),
//         ],
//       ),
//       drawer: drawer(context),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.amber,
//         onPressed: () {
//           Navigator.pushNamed(context, '/customer');
//         },
//         tooltip: 'Add Customer',
//         child: const Icon(Icons.add),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("USERS")
//             .doc(currentUser!.uid)
//             .collection("customers")
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//               var filteredDocs = snapshot.data!.docs.where((doc) {
//                 // Apply selected filters
//                 if (selectedFilter == 'All') return true;
//                 if (selectedFilter == 'Customer Name') {
//                   return doc["customerName"] != null && doc["customerName"].isNotEmpty;
//                 }
//                 if (selectedFilter == 'Price') {
//                   return doc["Selling Price"] != null && doc["Selling Price"] > 100;
//                 }
//                 return false;
//               }).toList();

//               return ListView.builder(
//                 itemCount: filteredDocs.length,
//                 itemBuilder: (context, index) {
//                   var doc = filteredDocs[index];

//                   return ListTile(
//                     contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.blueAccent,
//                       child: Text(
//                         "${index + 1}",
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     title: Text(
//                       "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 5),
//                         Text(
//                           "${doc["Email"]}",
//                           style: const TextStyle(color: Colors.grey),
//                         ),
//                         const SizedBox(height: 5),
//           //                IconButton(
//           //   onPressed: _makePhoneCall,
//           //   icon: Icon(Icons.phone),
//           // ),
//                         Text(
                          
//                           "Work-phone: ${doc["Work-phone"]}",
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         const SizedBox(height: 2),
//           //                IconButton(
//           //   onPressed: _makePhoneCall,
//           //   icon: Icon(Icons.phone),
//           // ),
//                         Text(
//                           "Other Number : ${doc["Mobile"]}",
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
                        
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const Center(child: Text("No customers found"));
//             }
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text("Error fetching data"));
//           } else {
//             return const Center(child: Text("No data available"));
//           }
//         },
//       ),
//     );
//   }

//   void _showFilterOptions() {
//     // Implement filter options (e.g., showDialog with choices)
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Filter'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 title: const Text('All'),
//                 onTap: () {
//                   setState(() {
//                     selectedFilter = 'All';
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: const Text('Customer Name'),
//                 onTap: () {
//                   setState(() {
//                     selectedFilter = 'Customer Name';
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: const Text('Price > 100'),
//                 onTap: () {
//                   setState(() {
//                     selectedFilter = 'Price';
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Customerpage extends StatefulWidget {
//   const Customerpage({super.key});

//   @override
//   State<Customerpage> createState() => _CustomerpageState();
// }

// class _CustomerpageState extends State<Customerpage> {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   String selectedFilter = 'All';

//   Future<void> _makePhoneCall(String phoneNumber) async {
//     final url = 'tel:$phoneNumber';
//     if (await canLaunchUrl(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   Future<void> _sendWhatsApp(String phoneNumber) async {
//     final url = 'https://wa.me/$phoneNumber';
//     if (await canLaunchUrl(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   Future<void> _sendMessage(String phoneNumber) async {
//     final url = 'sms:$phoneNumber';
//     if (await canLaunchUrl(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   Future<void> _deleteCustomer(String docId) async {
//     await FirebaseFirestore.instance
//         .collection("USERS")
//         .doc(currentUser!.uid)
//         .collection("customers")
//         .doc(docId)
//         .delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Customers"),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.menu),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: () {
//               _showFilterOptions();
//             },
//           ),
//         ],
//       ),
//       drawer: _drawer(context),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.amber,
//         onPressed: () {
//           Navigator.pushNamed(context, '/customer');
//         },
//         tooltip: 'Add Customer',
//         child: const Icon(Icons.add),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("USERS")
//             .doc(currentUser!.uid)
//             .collection("customers")
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//               var filteredDocs = snapshot.data!.docs.where((doc) {
//                 if (selectedFilter == 'All') return true;
//                 if (selectedFilter == 'Customer Name') {
//                   return doc["customerName"] != null && doc["customerName"].isNotEmpty;
//                 }
//                 if (selectedFilter == 'Price') {
//                   return doc["Selling Price"] != null && doc["Selling Price"] > 100;
//                 }
//                 return false;
//               }).toList();

//               return ListView.builder(
//                 itemCount: filteredDocs.length,
//                 itemBuilder: (context, index) {
//                   var doc = filteredDocs[index];

//                   return ListTile(
//                     contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.blueAccent,
//                       child: Text(
//                         "${index + 1}",
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     title: Text(
//                       "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 5),
//                         Text(
//                           "${doc["Email"]}",
//                           style: const TextStyle(color: Colors.grey),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Work-phone: ${doc["Work-phone"]}",
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           "Other Number : ${doc["Mobile"]}",
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.phone),
//                               onPressed: () => _makePhoneCall(doc["Mobile"]),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.message),
//                               onPressed: () => _sendMessage(doc["Mobile"]),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.whatshot),
//                               onPressed: () => _sendWhatsApp(doc["Mobile"]),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () {
                            
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             _deleteCustomer(doc.id);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const Center(child: Text("No customers found"));
//             }
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text("Error fetching data"));
//           } else {
//             return const Center(child: Text("No data available"));
//           }
//         },
//       ),
//     );
//   }

//   void _showFilterOptions() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Filter'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 title: const Text('All'),
//                 onTap: () {
//                   setState(() {
//                     selectedFilter = 'All';
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: const Text('Customer Name'),
//                 onTap: () {
//                   setState(() {
//                     selectedFilter = 'Customer Name';
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: const Text('Price > 100'),
//                 onTap: () {
//                   setState(() {
//                     selectedFilter = 'Price';
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Drawer _drawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'Menu',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.home),
//             title: Text('Home'),
//             onTap: () {
//               Navigator.pushReplacementNamed(context, '/home');
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//             onTap: () {
//               Navigator.pushReplacementNamed(context, '/settings');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:cloneapp/pages/home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Customerpage extends StatefulWidget {
//   const Customerpage({super.key});

//   @override
//   State<Customerpage> createState() => _CustomerpageState();
// }

// class _CustomerpageState extends State<Customerpage> {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   String selectedFilter = 'All';

//   Future<void> _makePhoneCall(String docId) async {
//     try {
//       // Check if currentUser is null
//       if (currentUser == null) {
//         throw 'User not logged in';
//       }

//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentUser!.uid)
//           .collection("customers")
//           .doc(docId)
//           .get();

//       // Check if customer exists
//        if (customerSnapshot.exists) {
//         // Ensure data is Map<String, dynamic> or null
//         Map<String, dynamic>? customerData =
//             customerSnapshot.data() as Map<String, dynamic>?;

//         if (customerData != null) {
//           // Access phone number from customer data
//           dynamic mobile = customerData['Mobile'];

//           // Check if phone number is available and convert if necessary
//           if (mobile is int) {
//             String phoneNumber = mobile.toString();
//               String url = 'tel:$phoneNumber';
//               await _launchURL(url);
//             } else {
//             throw 'Phone number not available';
//           }
//         } else {
//           throw 'Customer data not available';
//         }
//       } else {
//         throw 'Customer not found';
//       }
//     } catch (e) {
//       // Handle errors
//       print('Error in _sendWhatsApp: $e');
//       rethrow; // Rethrow the error to propagate it up the call stack if needed
//     }
//   }

//   Future<void> _sendWhatsApp(String docId) async {
//     try {
//       // Check if currentUser is null
//       if (currentUser == null) {
//         throw 'User not logged in';
//       }

//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentUser!.uid)
//           .collection("customers")
//           .doc(docId)
//           .get();

//       // Check if customer exists
//       if (customerSnapshot.exists) {
//         // Ensure data is Map<String, dynamic> or null
//         Map<String, dynamic>? customerData =
//             customerSnapshot.data() as Map<String, dynamic>?;

//         if (customerData != null) {
//           // Access phone number from customer data
//           dynamic mobile = customerData['Mobile'];

//           // Check if phone number is available and convert if necessary
//           if (mobile is int) {
//             String phoneNumber = mobile.toString();
//             String url = 'https://wa.me/$phoneNumber';
//             await _launchURL(url);
//           } else {
//             throw 'Phone number not available';
//           }
//         } else {
//           throw 'Customer data not available';
//         }
//       } else {
//         throw 'Customer not found';
//       }
//     } catch (e) {
//       // Handle errors
//       print('Error in _sendWhatsApp: $e');
//       rethrow; // Rethrow the error to propagate it up the call stack if needed
//     }
//   }

//   Future<void> _sendMessage(String docId) async {
//     try {
//       // Check if currentUser is null
//       if (currentUser == null) {
//         throw 'User not logged in';
//       }

//       // Retrieve customer data snapshot
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentUser!.uid)
//           .collection("customers")
//           .doc(docId)
//           .get();

//       // Check if customer exists
//       if (customerSnapshot.exists) {
//         // Ensure data is Map<String, dynamic> or null
//         Map<String, dynamic>? customerData =
//             customerSnapshot.data() as Map<String, dynamic>?;

//         if (customerData != null) {
//           // Access phone number from customer data
//           dynamic mobile = customerData['Mobile'];

//           // Check if phone number is available and convert if necessary
//           if (mobile is int) {
//             String phoneNumber = mobile.toString(); // Convert int to String
//             String url = 'sms:$phoneNumber';
//             await _launchURL(url);
//           } else if (mobile is String) {
//             String url = 'sms:$mobile';
//             await _launchURL(url);
//           } else {
//             throw 'Mobile number is not available or not valid';
//           }
//         } else {
//           throw 'Customer data not available';
//         }
//       } else {
//         throw 'Customer not found';
//       }
//     } catch (e) {
//       // Handle errors
//       print('Error in _sendMessage: $e');
//       // You can choose to show a snackbar, dialog, or handle errors in other ways as per your app's UI/UX design
//       // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }

//   Future<void> _launchURL(String url) async {
//     try {
//       await _launchURL(url); // Use launch from url_launcher directly for general URLs
//     } catch (e) {
//       throw 'Could not launch $url';
//     }
//   }

//   Future<void> _deleteCustomer(String docId) async {
//     await FirebaseFirestore.instance
//         .collection("USERS")
//         .doc(currentUser!.uid)
//         .collection("customers")
//         .doc(docId)
//         .delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 255, 217, 194),
//       appBar: AppBar(
//         title: const Text("Customers"),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.menu),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: () {
//               _showFilterOptions();
//             },
//           ),
//         ],
//       ),
//       drawer: drawer(context),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.amber,
//         onPressed: () {
//           Navigator.pushNamed(context, '/customer');
//         },
//         tooltip: 'Add Customer',
//         child: const Icon(Icons.add),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("USERS")
//             .doc(currentUser!.uid)
//             .collection("customers")
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//               var filteredDocs = snapshot.data!.docs.where((doc) {
//                 if (selectedFilter == 'All') return true;
//                 if (selectedFilter == 'Customer Name') {
//                   return doc["customerName"] != null &&
//                       doc["customerName"].isNotEmpty;
//                 }
//                 if (selectedFilter == 'Price') {
//                   return doc["Selling Price"] != null &&
//                       doc["Selling Price"] > 100;
//                 }
//                 return false;
//               }).toList();

//               return ListView.builder(
//                 itemCount: filteredDocs.length,
//                 itemBuilder: (context, index) {
//                   var doc = filteredDocs[index];

//                   return ListTile(
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 15.0, horizontal: 20.0),
//                     // leading: CircleAvatar(
//                     //   backgroundColor: Colors.blue,
//                     //   radius: 25,
//                     //   child: Text(
//                     //     "${index + 1}",
//                     //     style: const TextStyle(color: Colors.white),
//                     //   ),
//                     // ),
//                     title: Text(
//                       "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         fontSize: 25
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 5),
//                         Text(
//                           "${doc["Email"]}",
//                           style: const TextStyle(color: Colors.blue ,fontSize: 18),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Work-phone: ${doc["Work-phone"]}",
//                           style: const TextStyle(fontWeight: FontWeight.w500 ,fontSize: 18),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           "Other Number : ${doc["Mobile"]}",
//                           style: const TextStyle(fontWeight: FontWeight.w500 , fontSize: 18),
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.phone ,color: Colors.green, size: 35,),
//                               onPressed: () => _makePhoneCall(doc.id),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.message , color: Colors.blue, size: 35,),
//                               onPressed: () => _sendMessage(doc.id),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.card_membership, color: Colors.green, size: 35,),
//                               onPressed: () => _sendWhatsApp(doc.id),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit ,color: Colors.blue, size: 35,),
//                           onPressed: () {
//                             Navigator.pushNamed(
//                               context,
//                               '/customer',
//                               arguments: doc,
//                             );
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete , color: Colors.red, size: 35,),
//                           onPressed: () {
//                             _deleteCustomer(doc.id);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const Center(child: Text("No customers found"));
            
//             }
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text("Error fetching data"));
//           } else {
//             return const Center(child: Text("No data available"));
//           }
//         },
//       ),
//     );
//   }

//   void _showFilterOptions() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Filter'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 title: const Text('All'),
//                 onTap: () {
//                   setState(() {
//                     selectedFilter = 'All';
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: const Text('Customer Name'),
//                 onTap: () {
//                   setState(() {
//                     selectedFilter = 'Customer Name';
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: const Text('Price > 100'),
//                 onTap: () {
//                   setState(() {
//                     selectedFilter = 'Price';
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
  
//   }
// }


import 'package:cloneapp/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Customerpage extends StatefulWidget {
  const Customerpage({Key? key}) : super(key: key);

  @override
  State<Customerpage> createState() => _CustomerpageState();
}

class _CustomerpageState extends State<Customerpage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  String selectedFilter = 'All';

  Future<void> _makePhoneCall(String docId) async {
    try {
      // Check if currentUser is null
      if (currentUser == null) {
        throw 'User not logged in';
      }

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("customers")
          .doc(docId)
          .get();

      // Check if customer exists
      if (customerSnapshot.exists) {
        // Ensure data is Map<String, dynamic> or null
        Map<String, dynamic>? customerData =
            customerSnapshot.data() as Map<String, dynamic>?;

        if (customerData != null) {
          // Access phone number from customer data
          dynamic mobile = customerData['Mobile'];

          // Check if phone number is available and convert if necessary
          if (mobile is int) {
            String phoneNumber = mobile.toString();
            String url = 'tel:$phoneNumber';
            await _launchURL(url);
          } else {
            throw 'Phone number not available';
          }
        } else {
          throw 'Customer data not available';
        }
      } else {
        throw 'Customer not found';
      }
    } catch (e) {
      // Handle errors
      print('Error in _makePhoneCall: $e');
      // You can choose to show a snackbar, dialog, or handle errors in other ways as per your app's UI/UX design
      // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _sendWhatsApp(String docId) async {
    try {
      // Check if currentUser is null
      if (currentUser == null) {
        throw 'User not logged in';
      }

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("customers")
          .doc(docId)
          .get();

      // Check if customer exists
      if (customerSnapshot.exists) {
        // Ensure data is Map<String, dynamic> or null
        Map<String, dynamic>? customerData =
            customerSnapshot.data() as Map<String, dynamic>?;

        if (customerData != null) {
          // Access phone number from customer data
          dynamic mobile = customerData['Mobile'];

          // Check if phone number is available and convert if necessary
          if (mobile is int) {
            String phoneNumber = mobile.toString();
            String url = 'https://wa.me/$phoneNumber';
            await _launchURL(url);
          } else {
            throw 'Phone number not available';
          }
        } else {
          throw 'Customer data not available';
        }
      } else {
        throw 'Customer not found';
      }
    } catch (e) {
      // Handle errors
      print('Error in _sendWhatsApp: $e');
      // You can choose to show a snackbar, dialog, or handle errors in other ways as per your app's UI/UX design
      // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _sendMessage(String docId) async {
    try {
      // Check if currentUser is null
      if (currentUser == null) {
        throw 'User not logged in';
      }

      // Retrieve customer data snapshot
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("customers")
          .doc(docId)
          .get();

      // Check if customer exists
      if (customerSnapshot.exists) {
        // Ensure data is Map<String, dynamic> or null
        Map<String, dynamic>? customerData =
            customerSnapshot.data() as Map<String, dynamic>?;

        if (customerData != null) {
          // Access phone number from customer data
          dynamic mobile = customerData['Mobile'];

          // Check if phone number is available and convert if necessary
          if (mobile is int) {
            String phoneNumber = mobile.toString(); // Convert int to String
            String url = 'sms:$phoneNumber';
            await _launchURL(url);
          } else if (mobile is String) {
            String url = 'sms:$mobile';
            await _launchURL(url);
          } else {
            throw 'Mobile number is not available or not valid';
          }
        } else {
          throw 'Customer data not available';
        }
      } else {
        throw 'Customer not found';
      }
    } catch (e) {
      // Handle errors
      print('Error in _sendMessage: $e');
      // You can choose to show a snackbar, dialog, or handle errors in other ways as per your app's UI/UX design
      // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Handle error as per your requirement
      // For example, show a snackbar or dialog to inform the user
    }
  }

  Future<void> _deleteCustomer(String docId) async {
    await FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentUser!.uid)
        .collection("customers")
        .doc(docId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: AppBar(
        title: const Text("Customers"),
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
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions();
            },
          ),
        ],
      ),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.pushNamed(context, '/customer');
        },
        tooltip: 'Add Customer',
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("USERS")
            .doc(currentUser!.uid)
            .collection("customers")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              var filteredDocs = snapshot.data!.docs.where((doc) {
                if (selectedFilter == 'All') return true;
                if (selectedFilter == 'Customer Name') {
                  return doc["customerName"] != null &&
                      doc["customerName"].isNotEmpty;
                }
                if (selectedFilter == 'Price') {
                  return doc["Selling Price"] != null &&
                      doc["Selling Price"] > 100;
                }
                return false;
              }).toList();

              return ListView.builder(
                itemCount: filteredDocs.length,
                itemBuilder: (context, index) {
                  var doc = filteredDocs[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    title: Text(
                      "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          "${doc["Email"]}",
                          style: const TextStyle(
                              color: Colors.blue, fontSize: 18),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Work-phone: ${doc["Work-phone"]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Other Number : ${doc["Mobile"]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.phone,
                                  color: Colors.green, size: 35),
                              onPressed: () => _makePhoneCall(doc.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.message,
                                  color: Colors.blue, size: 35),
                              onPressed: () => _sendMessage(doc.id),
                            ),
                            // IconButton(
                            //   icon: const Icon(Icons.card_membership,
                            //       color: Colors.green, size: 35),
                            //                                 onPressed: () => _sendWhatsApp(doc.id),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: Colors.blue, size: 35),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/customer',
                              arguments: doc,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.red, size: 35),
                          onPressed: () {
                            _deleteCustomer(doc.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No customers found"));
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching data"));
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }

  void _showFilterOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('All'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'All';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Customer Name'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'Customer Name';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Price > 100'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'Price';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

