
// // import 'package:cloneapp/pages/home.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';

// // class Customerpage extends StatefulWidget {
// //   const Customerpage({super.key});

// //  @override
// //   State<Customerpage> createState() => _CustomerpageState();
// // }
// // class _CustomerpageState extends State<Customerpage> {
// //   final User? currentUser = FirebaseAuth.instance.currentUser;

// //   String selectedFilter = 'All';
// //   // final String mobileNumber = currentUser.

// //   // void _makePhoneCall() async {
// //   //   if (await canLaunchUrlUrl('tel:$mobileNumber')) {
// //   //     await launchUrl('tel:$mobileNumber');
// //   //   } else {
// //   //     throw 'Could not launch $mobileNumber';
// //   //   }
// //   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Customers"),
// //         leading: Builder(
// //           builder: (BuildContext context) {
// //             return IconButton(
// //               icon: const Icon(Icons.menu),
// //               onPressed: () {
// //                 Scaffold.of(context).openDrawer();
// //               },
// //               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
// //             );
// //           },
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.search),
// //             onPressed: () {
              
// //             },
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.filter_list),
// //             onPressed: () {
// //               // Implement filter options (e.g., dropdown menu)
// //               _showFilterOptions();
// //             },
// //           ),
// //         ],
// //       ),
// //       drawer: drawer(context),
// //       floatingActionButton: FloatingActionButton(
// //         backgroundColor: Colors.amber,
// //         onPressed: () {
// //           Navigator.pushNamed(context, '/customer');
// //         },
// //         tooltip: 'Add Customer',
// //         child: const Icon(Icons.add),
// //       ),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance
// //             .collection("USERS")
// //             .doc(currentUser!.uid)
// //             .collection("customers")
// //             .snapshots(),
// //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.connectionState == ConnectionState.active) {
// //             if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
// //               var filteredDocs = snapshot.data!.docs.where((doc) {
// //                 // Apply selected filters
// //                 if (selectedFilter == 'All') return true;
// //                 if (selectedFilter == 'Customer Name') {
// //                   return doc["customerName"] != null && doc["customerName"].isNotEmpty;
// //                 }
// //                 if (selectedFilter == 'Price') {
// //                   return doc["Selling Price"] != null && doc["Selling Price"] > 100;
// //                 }
// //                 return false;
// //               }).toList();

// //               return ListView.builder(
// //                 itemCount: filteredDocs.length,
// //                 itemBuilder: (context, index) {
// //                   var doc = filteredDocs[index];

// //                   return ListTile(
// //                     contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
// //                     leading: CircleAvatar(
// //                       backgroundColor: Colors.blueAccent,
// //                       child: Text(
// //                         "${index + 1}",
// //                         style: const TextStyle(color: Colors.white),
// //                       ),
// //                     ),
// //                     title: Text(
// //                       "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
// //                       style: const TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.black,
// //                       ),
// //                     ),
// //                     subtitle: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         const SizedBox(height: 5),
// //                         Text(
// //                           "${doc["Email"]}",
// //                           style: const TextStyle(color: Colors.grey),
// //                         ),
// //                         const SizedBox(height: 5),
// //           //                IconButton(
// //           //   onPressed: _makePhoneCall,
// //           //   icon: Icon(Icons.phone),
// //           // ),
// //                         Text(
                          
// //                           "Work-phone: ${doc["Work-phone"]}",
// //                           style: const TextStyle(fontWeight: FontWeight.w500),
// //                         ),
// //                         const SizedBox(height: 2),
// //           //                IconButton(
// //           //   onPressed: _makePhoneCall,
// //           //   icon: Icon(Icons.phone),
// //           // ),
// //                         Text(
// //                           "Other Number : ${doc["Mobile"]}",
// //                           style: const TextStyle(fontWeight: FontWeight.w500),
// //                         ),
                        
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               );
// //             } else {
// //               return const Center(child: Text("No customers found"));
// //             }
// //           } else if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return const Center(child: Text("Error fetching data"));
// //           } else {
// //             return const Center(child: Text("No data available"));
// //           }
// //         },
// //       ),
// //     );
// //   }

// //   void _showFilterOptions() {
// //     // Implement filter options (e.g., showDialog with choices)
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text('Select Filter'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: <Widget>[
// //               ListTile(
// //                 title: const Text('All'),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFilter = 'All';
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //               ListTile(
// //                 title: const Text('Customer Name'),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFilter = 'Customer Name';
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //               ListTile(
// //                 title: const Text('Price > 100'),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFilter = 'Price';
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }



// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // class Customerpage extends StatefulWidget {
// //   const Customerpage({super.key});

// //   @override
// //   State<Customerpage> createState() => _CustomerpageState();
// // }

// // class _CustomerpageState extends State<Customerpage> {
// //   final User? currentUser = FirebaseAuth.instance.currentUser;
// //   String selectedFilter = 'All';

// //   Future<void> _makePhoneCall(String phoneNumber) async {
// //     final url = 'tel:$phoneNumber';
// //     if (await canLaunchUrl(url)) {
// //       await launch(url);
// //     } else {
// //       throw 'Could not launch $url';
// //     }
// //   }

// //   Future<void> _sendWhatsApp(String phoneNumber) async {
// //     final url = 'https://wa.me/$phoneNumber';
// //     if (await canLaunchUrl(url)) {
// //       await launch(url);
// //     } else {
// //       throw 'Could not launch $url';
// //     }
// //   }

// //   Future<void> _sendMessage(String phoneNumber) async {
// //     final url = 'sms:$phoneNumber';
// //     if (await canLaunchUrl(url)) {
// //       await launch(url);
// //     } else {
// //       throw 'Could not launch $url';
// //     }
// //   }

// //   Future<void> _deleteCustomer(String docId) async {
// //     await FirebaseFirestore.instance
// //         .collection("USERS")
// //         .doc(currentUser!.uid)
// //         .collection("customers")
// //         .doc(docId)
// //         .delete();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Customers"),
// //         leading: Builder(
// //           builder: (BuildContext context) {
// //             return IconButton(
// //               icon: const Icon(Icons.menu),
// //               onPressed: () {
// //                 Scaffold.of(context).openDrawer();
// //               },
// //               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
// //             );
// //           },
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.search),
// //             onPressed: () {},
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.filter_list),
// //             onPressed: () {
// //               _showFilterOptions();
// //             },
// //           ),
// //         ],
// //       ),
// //       drawer: _drawer(context),
// //       floatingActionButton: FloatingActionButton(
// //         backgroundColor: Colors.amber,
// //         onPressed: () {
// //           Navigator.pushNamed(context, '/customer');
// //         },
// //         tooltip: 'Add Customer',
// //         child: const Icon(Icons.add),
// //       ),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance
// //             .collection("USERS")
// //             .doc(currentUser!.uid)
// //             .collection("customers")
// //             .snapshots(),
// //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.connectionState == ConnectionState.active) {
// //             if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
// //               var filteredDocs = snapshot.data!.docs.where((doc) {
// //                 if (selectedFilter == 'All') return true;
// //                 if (selectedFilter == 'Customer Name') {
// //                   return doc["customerName"] != null && doc["customerName"].isNotEmpty;
// //                 }
// //                 if (selectedFilter == 'Price') {
// //                   return doc["Selling Price"] != null && doc["Selling Price"] > 100;
// //                 }
// //                 return false;
// //               }).toList();

// //               return ListView.builder(
// //                 itemCount: filteredDocs.length,
// //                 itemBuilder: (context, index) {
// //                   var doc = filteredDocs[index];

// //                   return ListTile(
// //                     contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
// //                     leading: CircleAvatar(
// //                       backgroundColor: Colors.blueAccent,
// //                       child: Text(
// //                         "${index + 1}",
// //                         style: const TextStyle(color: Colors.white),
// //                       ),
// //                     ),
// //                     title: Text(
// //                       "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
// //                       style: const TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.black,
// //                       ),
// //                     ),
// //                     subtitle: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         const SizedBox(height: 5),
// //                         Text(
// //                           "${doc["Email"]}",
// //                           style: const TextStyle(color: Colors.grey),
// //                         ),
// //                         const SizedBox(height: 5),
// //                         Text(
// //                           "Work-phone: ${doc["Work-phone"]}",
// //                           style: const TextStyle(fontWeight: FontWeight.w500),
// //                         ),
// //                         const SizedBox(height: 2),
// //                         Text(
// //                           "Other Number : ${doc["Mobile"]}",
// //                           style: const TextStyle(fontWeight: FontWeight.w500),
// //                         ),
// //                         const SizedBox(height: 5),
// //                         Row(
// //                           children: [
// //                             IconButton(
// //                               icon: const Icon(Icons.phone),
// //                               onPressed: () => _makePhoneCall(doc["Mobile"]),
// //                             ),
// //                             IconButton(
// //                               icon: const Icon(Icons.message),
// //                               onPressed: () => _sendMessage(doc["Mobile"]),
// //                             ),
// //                             IconButton(
// //                               icon: const Icon(Icons.whatshot),
// //                               onPressed: () => _sendWhatsApp(doc["Mobile"]),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                     trailing: Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         IconButton(
// //                           icon: const Icon(Icons.edit),
// //                           onPressed: () {
                            
// //                           },
// //                         ),
// //                         IconButton(
// //                           icon: const Icon(Icons.delete),
// //                           onPressed: () {
// //                             _deleteCustomer(doc.id);
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               );
// //             } else {
// //               return const Center(child: Text("No customers found"));
// //             }
// //           } else if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return const Center(child: Text("Error fetching data"));
// //           } else {
// //             return const Center(child: Text("No data available"));
// //           }
// //         },
// //       ),
// //     );
// //   }

// //   void _showFilterOptions() {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text('Select Filter'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: <Widget>[
// //               ListTile(
// //                 title: const Text('All'),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFilter = 'All';
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //               ListTile(
// //                 title: const Text('Customer Name'),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFilter = 'Customer Name';
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //               ListTile(
// //                 title: const Text('Price > 100'),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFilter = 'Price';
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Drawer _drawer(BuildContext context) {
// //     return Drawer(
// //       child: ListView(
// //         padding: EdgeInsets.zero,
// //         children: <Widget>[
// //           DrawerHeader(
// //             decoration: BoxDecoration(
// //               color: Colors.blue,
// //             ),
// //             child: Text(
// //               'Menu',
// //               style: TextStyle(
// //                 color: Colors.white,
// //                 fontSize: 24,
// //               ),
// //             ),
// //           ),
// //           ListTile(
// //             leading: Icon(Icons.home),
// //             title: Text('Home'),
// //             onTap: () {
// //               Navigator.pushReplacementNamed(context, '/home');
// //             },
// //           ),
// //           ListTile(
// //             leading: Icon(Icons.settings),
// //             title: Text('Settings'),
// //             onTap: () {
// //               Navigator.pushReplacementNamed(context, '/settings');
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// // import 'package:cloneapp/pages/home.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // class Customerpage extends StatefulWidget {
// //   const Customerpage({super.key});

// //   @override
// //   State<Customerpage> createState() => _CustomerpageState();
// // }

// // class _CustomerpageState extends State<Customerpage> {
// //   final User? currentUser = FirebaseAuth.instance.currentUser;
// //   String selectedFilter = 'All';

// //   Future<void> _makePhoneCall(String docId) async {
// //     try {
// //       // Check if currentUser is null
// //       if (currentUser == null) {
// //         throw 'User not logged in';
// //       }

// //       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
// //           .collection("USERS")
// //           .doc(currentUser!.uid)
// //           .collection("customers")
// //           .doc(docId)
// //           .get();

// //       // Check if customer exists
// //        if (customerSnapshot.exists) {
// //         // Ensure data is Map<String, dynamic> or null
// //         Map<String, dynamic>? customerData =
// //             customerSnapshot.data() as Map<String, dynamic>?;

// //         if (customerData != null) {
// //           // Access phone number from customer data
// //           dynamic mobile = customerData['Mobile'];

// //           // Check if phone number is available and convert if necessary
// //           if (mobile is int) {
// //             String phoneNumber = mobile.toString();
// //               String url = 'tel:$phoneNumber';
// //               await _launchURL(url);
// //             } else {
// //             throw 'Phone number not available';
// //           }
// //         } else {
// //           throw 'Customer data not available';
// //         }
// //       } else {
// //         throw 'Customer not found';
// //       }
// //     } catch (e) {
// //       // Handle errors
// //       print('Error in _sendWhatsApp: $e');
// //       rethrow; // Rethrow the error to propagate it up the call stack if needed
// //     }
// //   }

// //   Future<void> _sendWhatsApp(String docId) async {
// //     try {
// //       // Check if currentUser is null
// //       if (currentUser == null) {
// //         throw 'User not logged in';
// //       }

// //       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
// //           .collection("USERS")
// //           .doc(currentUser!.uid)
// //           .collection("customers")
// //           .doc(docId)
// //           .get();

// //       // Check if customer exists
// //       if (customerSnapshot.exists) {
// //         // Ensure data is Map<String, dynamic> or null
// //         Map<String, dynamic>? customerData =
// //             customerSnapshot.data() as Map<String, dynamic>?;

// //         if (customerData != null) {
// //           // Access phone number from customer data
// //           dynamic mobile = customerData['Mobile'];

// //           // Check if phone number is available and convert if necessary
// //           if (mobile is int) {
// //             String phoneNumber = mobile.toString();
// //             String url = 'https://wa.me/$phoneNumber';
// //             await _launchURL(url);
// //           } else {
// //             throw 'Phone number not available';
// //           }
// //         } else {
// //           throw 'Customer data not available';
// //         }
// //       } else {
// //         throw 'Customer not found';
// //       }
// //     } catch (e) {
// //       // Handle errors
// //       print('Error in _sendWhatsApp: $e');
// //       rethrow; // Rethrow the error to propagate it up the call stack if needed
// //     }
// //   }

// //   Future<void> _sendMessage(String docId) async {
// //     try {
// //       // Check if currentUser is null
// //       if (currentUser == null) {
// //         throw 'User not logged in';
// //       }

// //       // Retrieve customer data snapshot
// //       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
// //           .collection("USERS")
// //           .doc(currentUser!.uid)
// //           .collection("customers")
// //           .doc(docId)
// //           .get();

// //       // Check if customer exists
// //       if (customerSnapshot.exists) {
// //         // Ensure data is Map<String, dynamic> or null
// //         Map<String, dynamic>? customerData =
// //             customerSnapshot.data() as Map<String, dynamic>?;

// //         if (customerData != null) {
// //           // Access phone number from customer data
// //           dynamic mobile = customerData['Mobile'];

// //           // Check if phone number is available and convert if necessary
// //           if (mobile is int) {
// //             String phoneNumber = mobile.toString(); // Convert int to String
// //             String url = 'sms:$phoneNumber';
// //             await _launchURL(url);
// //           } else if (mobile is String) {
// //             String url = 'sms:$mobile';
// //             await _launchURL(url);
// //           } else {
// //             throw 'Mobile number is not available or not valid';
// //           }
// //         } else {
// //           throw 'Customer data not available';
// //         }
// //       } else {
// //         throw 'Customer not found';
// //       }
// //     } catch (e) {
// //       // Handle errors
// //       print('Error in _sendMessage: $e');
// //       // You can choose to show a snackbar, dialog, or handle errors in other ways as per your app's UI/UX design
// //       // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
// //     }
// //   }

// //   Future<void> _launchURL(String url) async {
// //     try {
// //       await _launchURL(url); // Use launch from url_launcher directly for general URLs
// //     } catch (e) {
// //       throw 'Could not launch $url';
// //     }
// //   }

// //   Future<void> _deleteCustomer(String docId) async {
// //     await FirebaseFirestore.instance
// //         .collection("USERS")
// //         .doc(currentUser!.uid)
// //         .collection("customers")
// //         .doc(docId)
// //         .delete();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Color.fromARGB(255, 255, 217, 194),
// //       appBar: AppBar(
// //         title: const Text("Customers"),
// //         leading: Builder(
// //           builder: (BuildContext context) {
// //             return IconButton(
// //               icon: const Icon(Icons.menu),
// //               onPressed: () {
// //                 Scaffold.of(context).openDrawer();
// //               },
// //               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
// //             );
// //           },
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.search),
// //             onPressed: () {},
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.filter_list),
// //             onPressed: () {
// //               _showFilterOptions();
// //             },
// //           ),
// //         ],
// //       ),
// //       drawer: drawer(context),
// //       floatingActionButton: FloatingActionButton(
// //         backgroundColor: Colors.amber,
// //         onPressed: () {
// //           Navigator.pushNamed(context, '/customer');
// //         },
// //         tooltip: 'Add Customer',
// //         child: const Icon(Icons.add),
// //       ),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance
// //             .collection("USERS")
// //             .doc(currentUser!.uid)
// //             .collection("customers")
// //             .snapshots(),
// //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.connectionState == ConnectionState.active) {
// //             if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
// //               var filteredDocs = snapshot.data!.docs.where((doc) {
// //                 if (selectedFilter == 'All') return true;
// //                 if (selectedFilter == 'Customer Name') {
// //                   return doc["customerName"] != null &&
// //                       doc["customerName"].isNotEmpty;
// //                 }
// //                 if (selectedFilter == 'Price') {
// //                   return doc["Selling Price"] != null &&
// //                       doc["Selling Price"] > 100;
// //                 }
// //                 return false;
// //               }).toList();

// //               return ListView.builder(
// //                 itemCount: filteredDocs.length,
// //                 itemBuilder: (context, index) {
// //                   var doc = filteredDocs[index];

// //                   return ListTile(
// //                     contentPadding: const EdgeInsets.symmetric(
// //                         vertical: 15.0, horizontal: 20.0),
// //                     // leading: CircleAvatar(
// //                     //   backgroundColor: Colors.blue,
// //                     //   radius: 25,
// //                     //   child: Text(
// //                     //     "${index + 1}",
// //                     //     style: const TextStyle(color: Colors.white),
// //                     //   ),
// //                     // ),
// //                     title: Text(
// //                       "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
// //                       style: const TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.black,
// //                         fontSize: 25
// //                       ),
// //                     ),
// //                     subtitle: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         const SizedBox(height: 5),
// //                         Text(
// //                           "${doc["Email"]}",
// //                           style: const TextStyle(color: Colors.blue ,fontSize: 18),
// //                         ),
// //                         const SizedBox(height: 5),
// //                         Text(
// //                           "Work-phone: ${doc["Work-phone"]}",
// //                           style: const TextStyle(fontWeight: FontWeight.w500 ,fontSize: 18),
// //                         ),
// //                         const SizedBox(height: 2),
// //                         Text(
// //                           "Other Number : ${doc["Mobile"]}",
// //                           style: const TextStyle(fontWeight: FontWeight.w500 , fontSize: 18),
// //                         ),
// //                         const SizedBox(height: 5),
// //                         Row(
// //                           children: [
// //                             IconButton(
// //                               icon: const Icon(Icons.phone ,color: Colors.green, size: 35,),
// //                               onPressed: () => _makePhoneCall(doc.id),
// //                             ),
// //                             IconButton(
// //                               icon: const Icon(Icons.message , color: Colors.blue, size: 35,),
// //                               onPressed: () => _sendMessage(doc.id),
// //                             ),
// //                             IconButton(
// //                               icon: const Icon(Icons.card_membership, color: Colors.green, size: 35,),
// //                               onPressed: () => _sendWhatsApp(doc.id),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                     trailing: Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         IconButton(
// //                           icon: const Icon(Icons.edit ,color: Colors.blue, size: 35,),
// //                           onPressed: () {
// //                             Navigator.pushNamed(
// //                               context,
// //                               '/customer',
// //                               arguments: doc,
// //                             );
// //                           },
// //                         ),
// //                         IconButton(
// //                           icon: const Icon(Icons.delete , color: Colors.red, size: 35,),
// //                           onPressed: () {
// //                             _deleteCustomer(doc.id);
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               );
// //             } else {
// //               return const Center(child: Text("No customers found"));
            
// //             }
// //           } else if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return const Center(child: Text("Error fetching data"));
// //           } else {
// //             return const Center(child: Text("No data available"));
// //           }
// //         },
// //       ),
// //     );
// //   }

// //   void _showFilterOptions() {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text('Select Filter'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: <Widget>[
// //               ListTile(
// //                 title: const Text('All'),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFilter = 'All';
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //               ListTile(
// //                 title: const Text('Customer Name'),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFilter = 'Customer Name';
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //               ListTile(
// //                 title: const Text('Price > 100'),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFilter = 'Price';
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
  
// //   }
// // }


// import 'package:cloneapp/pages/home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Customerpage extends StatefulWidget {
//   const Customerpage({Key? key}) : super(key: key);

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
//             String url = 'tel:$phoneNumber';
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
//       print('Error in _makePhoneCall: $e');
//       // You can choose to show a snackbar, dialog, or handle errors in other ways as per your app's UI/UX design
//       // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
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
//       // You can choose to show a snackbar, dialog, or handle errors in other ways as per your app's UI/UX design
//       // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
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
//       if (await canLaunch(url)) {
//         await launch(url);
//       } else {
//         throw 'Could not launch $url';
//       }
//     } catch (e) {
//       print('Error launching URL: $e');
//       // Handle error as per your requirement
//       // For example, show a snackbar or dialog to inform the user
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
//       drawer: drawer(context),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.amber,
//         onPressed: () {
//           Navigator.pushNamed(context, '/customer');
//         },
//         tooltip: 'Add Customer',
//         child: const Icon(Icons.add),
//       ),
  //     body: StreamBuilder(
  //       stream: FirebaseFirestore.instance
  //           .collection("USERS")
  //           .doc(currentUser!.uid)
  //           .collection("customers")
  //           .snapshots(),
  //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.active) {
  //           if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
  //             var filteredDocs = snapshot.data!.docs.where((doc) {
  //               if (selectedFilter == 'All') return true;
  //               if (selectedFilter == 'Customer Name') {
  //                 return doc["customerName"] != null &&
  //                     doc["customerName"].isNotEmpty;
  //               }
  //               if (selectedFilter == 'Price') {
  //                 return doc["Selling Price"] != null &&
  //                     doc["Selling Price"] > 100;
  //               }
  //               return false;
  //             }).toList();

  //             return ListView.builder(
  //               itemCount: filteredDocs.length,
  //               itemBuilder: (context, index) {
  //                 var doc = filteredDocs[index];

  //                 return ListTile(
  //                   contentPadding: const EdgeInsets.symmetric(
  //                       vertical: 15.0, horizontal: 20.0),
  //                   title: Text(
  //                     "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
  //                     style: const TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.black,
  //                         fontSize: 25),
  //                   ),
  //                   subtitle: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const SizedBox(height: 5),
  //                       Text(
  //                         "${doc["Email"]}",
  //                         style: const TextStyle(
  //                             color: Colors.blue, fontSize: 18),
  //                       ),
  //                       const SizedBox(height: 5),
  //                       Text(
  //                         "Work-phone: ${doc["Work-phone"]}",
  //                         style: const TextStyle(
  //                             fontWeight: FontWeight.w500, fontSize: 18),
  //                       ),
  //                       const SizedBox(height: 2),
  //                       Text(
  //                         "Other Number : ${doc["Mobile"]}",
  //                         style: const TextStyle(
  //                             fontWeight: FontWeight.w500, fontSize: 18),
  //                       ),
  //                       const SizedBox(height: 5),
  //                       Row(
  //                         children: [
  //                           IconButton(
  //                             icon: const Icon(Icons.phone,
  //                                 color: Colors.green, size: 35),
  //                             onPressed: () => _makePhoneCall(doc.id),
  //                           ),
  //                           IconButton(
  //                             icon: const Icon(Icons.message,
  //                                 color: Colors.blue, size: 35),
  //                             onPressed: () => _sendMessage(doc.id),
  //                           ),
  //                           // IconButton(
  //                           //   icon: const Icon(Icons.card_membership,
  //                           //       color: Colors.green, size: 35),
  //                           //                                 onPressed: () => _sendWhatsApp(doc.id),
  //                           // ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   trailing: Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       IconButton(
  //                         icon: const Icon(Icons.edit,
  //                             color: Colors.blue, size: 35),
  //                         onPressed: () {
  //                           Navigator.pushNamed(
  //                             context,
  //                            MaterialPageRoute(
  //                           builder: (context) => Customeritem(

  //                           ), 
  //                           ),
  //                           );
  //                         },
  //                       ),
  //                       IconButton(
  //                         icon: const Icon(Icons.delete,
  //                             color: Colors.red, size: 35),
  //                         onPressed: () {
  //                           _deleteCustomer(doc.id);
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             );
  //           } else {
  //             return const Center(child: Text("No customers found"));
  //           }
  //         } else if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return const Center(child: Text("Error fetching data"));
  //         } else {
  //           return const Center(child: Text("No data available"));
  //         }
  //       },
  //     ),
  //   );
  // }


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


// class Customeredit extends StatefulWidget {
//   final DocumentSnapshot? customerData;

//   const Customeredit({Key? key, this.customerData}) : super(key: key);

//   @override
//   _CustomereditState createState() => _CustomereditState();
// }


  
// class Customeredit extends StatefulWidget {
//   final _salutation = 
//   final _firstname = ;
//   final _lastname =
//   final _workphone = 
//   final _mobile = 
//   final _address = 

//   var currentUser = FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.customerData != null) {
//       _salutation.text = widget.customerData!["Salutation"] ?? "";
//       _firstname.text = widget.customerData!["First Name"] ?? "";
//       _lastname.text = widget.customerData!["Last Name"] ?? "";
//       _email.text = widget.customerData!["Email"] ?? "";
//       _workphone.text = widget.customerData!["Work-phone"]?.toString() ?? "";
//       _mobile.text = widget.customerData!["Mobile"]?.toString() ?? "";
//       _address.text = widget.customerData!["Address"] ?? "";
//     }
//   }

//   Future<void> _saveCustomer() async {
//     String? salutation = _salutation.text.trim();
//     String? firstname = _firstname.text.trim();
//     String? lastname = _lastname.text.trim();
//     String? email = _email.text.trim();
//     String? address = _address.text.trim();
//     int? workphone = int.tryParse(_workphone.text.trim());
//     int? mobile = int.tryParse(_mobile.text.trim());

//     if (
//         firstname == "" ||
//         lastname == "" ||
//         mobile==null
//          ) {
//           _showErrorDialog("fill the first name , last name anf mobile fields");
//       return;
//     }

//     try {
//       CollectionReference customersCollection = FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentUser!.uid)
//           .collection("customers");

//       if (widget.customerData == null) {
//         await customersCollection.add({
//           "Salutation": salutation,
//           "First Name": firstname,
//           "Last Name": lastname,
//           "Email": email,
//           "Work-phone": workphone,
//           "Mobile": mobile,
//           "Address": address,
//         });
//       } else {
//         await customersCollection
//             .doc(widget.customerData!.id)
//             .update({
//               "Salutation": salutation,
//               "First Name": firstname,
//               "Last Name": lastname,
//               "Email": email,
//               "Work-phone": workphone,
//               "Mobile": mobile,
//               "Address": address,
//             })
//             .then((value) => print("Customer updated"))
//             .catchError((error) => print("Failed to update customer: $error"));
//       }

//       // Clear text fields after saving
//       _salutation.clear();
//       _firstname.clear();
//       _lastname.clear();
//       _email.clear();
//       _workphone.clear();
//       _mobile.clear();
//       _address.clear();

//       // Show success dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Success'),
//           content: const Text('Customer data saved successfully'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.pushNamed(context, '/customeradd');
//               },
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       print("Error: $e");
//       // Handle error, show error dialog or snackbar
//     }
//   }
  
// void _showErrorDialog(String message) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("Error"),
//         content: Text(message),
//         actions: <Widget>[
//           TextButton(
//             child: const Text("OK"),
//             onPressed: () {
//               Navigator.of(context).pop(); // Dismiss the dialog
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

//   @override
//   void dispose() {
//     _salutation.dispose();
//     _firstname.dispose();
//     _lastname.dispose();
//     _email.dispose();
//     _workphone.dispose();
//     _mobile.dispose();
//     _address.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Customer"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Customer Name:',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                       child: TextFormField(
//                         controller: _salutation,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Salutation',
//                           contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                       child: TextFormField(
//                         controller: _firstname,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'First Name',
//                           contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                       child: TextFormField(
//                         controller: _lastname,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Last Name',
//                           contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Customer Email:',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: TextFormField(
//                   controller: _email,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Email',
//                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Customer Address:',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: TextFormField(
//                   controller: _address,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Address',
//                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Customer Phone:',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                       child: TextFormField(
//                         controller: _workphone,
//                         keyboardType: TextInputType.phone,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Work Phone',
//                           contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                       child: TextFormField(
//                         controller: _mobile,
//                         keyboardType: TextInputType.phone,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Mobile',
//                           contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: _saveCustomer,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: const Text('Save', style: TextStyle(color: Colors.white)),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: const
//  Text('Cancel', style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       )
//     );
//   }
// }

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
      if (currentUser == null) {
        throw 'User not logged in';
      }

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("customers")
          .doc(docId)
          .get();

      if (customerSnapshot.exists) {
        Map<String, dynamic>? customerData =
            customerSnapshot.data() as Map<String, dynamic>?;

        if (customerData != null) {
          dynamic mobile = customerData['Mobile'];

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
      print('Error in _makePhoneCall: $e');
    }
  }

  Future<void> _sendWhatsApp(String docId) async {
    try {
      if (currentUser == null) {
        throw 'User not logged in';
      }

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("customers")
          .doc(docId)
          .get();

      if (customerSnapshot.exists) {
        Map<String, dynamic>? customerData =
            customerSnapshot.data() as Map<String, dynamic>?;

        if (customerData != null) {
          dynamic mobile = customerData['Mobile'];

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
      print('Error in _sendWhatsApp: $e');
    }
  }

  Future<void> _sendMessage(String docId) async {
    try {
      if (currentUser == null) {
        throw 'User not logged in';
      }

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("customers")
          .doc(docId)
          .get();

      if (customerSnapshot.exists) {
        Map<String, dynamic>? customerData =
            customerSnapshot.data() as Map<String, dynamic>?;

        if (customerData != null) {
          dynamic mobile = customerData['Mobile'];

          if (mobile is int) {
            String phoneNumber = mobile.toString();
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
      print('Error in _sendMessage: $e');
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
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/customer');
            },
            tooltip: "Add customer",
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions();
            },
          ),
        ],
      ),
      drawer: drawer(context), // Use your drawer widget here
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.amber,
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/customer');
      //   },
      //   tooltip: 'Add Customer',
      //   child: const Icon(Icons.add),
      // ),
//         body: StreamBuilder(
//   stream: FirebaseFirestore.instance
//       .collection("USERS")
//       .doc(currentUser!.uid)
//       .collection("customers")
//       .snapshots(),
//   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (snapshot.connectionState == ConnectionState.active) {
//       if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//         var filteredDocs = snapshot.data!.docs.where((doc) {
//           if (selectedFilter == 'All') return true;
//           if (selectedFilter == 'Customer Name') {
//             return doc["customerName"] != null && doc["customerName"].isNotEmpty;
//           }
//           if (selectedFilter == 'Price') {
//             return doc["Selling Price"] != null && doc["Selling Price"] > 100;
//           }
//           return false;
//         }).toList();

//         return SingleChildScrollView(
//           child: ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: filteredDocs.length,
//             itemBuilder: (context, index) {
//               var doc = filteredDocs[index];

//               return ListTile(
//                 contentPadding: const EdgeInsets.symmetric(
//                     vertical: 15.0, horizontal: 20.0),
//                 title: Text(
//                   "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                       fontSize: 25),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 5),
//                     Text(
//                       "${doc["Email"]}",
//                       style: const TextStyle(
//                           color: Colors.blue, fontSize: 18),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       "Work-phone: ${doc["Work-phone"]}",
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w500, fontSize: 18),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       "Other Number : ${doc["Mobile"]}",
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w500, fontSize: 18),
//                     ),
//                   ],
//                 ),
//                 trailing: Column(
//                   children: [
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.phone,
//                               color: Colors.green, size: 10),
//                           onPressed: () => _makePhoneCall(doc.id),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.message,
//                               color: Colors.blue, size: 10),
//                           onPressed: () => _sendMessage(doc.id),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit, color: Colors.blue, size: 10),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => Customeredit(customerData: doc),
//                               ),
//                             );
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red, size: 10),
//                           onPressed: () {
//                             _deleteCustomer(doc.id);
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       } else {
//         return const Center(child: Text("No customers found"));
//       }
//     } else if (snapshot.connectionState == ConnectionState.waiting) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (snapshot.hasError) {
//       return const Center(child: Text("Error fetching data"));
//     } else {
//       return const Center(child: Text("No data available"));
//     }
//   },
// ),
 // Use your drawer widget here
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("USERS")
            .doc(currentUser!.uid)
            .collection("customers")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching data"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No customers found"));
          }

          var filteredDocs = snapshot.data!.docs.where((doc) {
            switch (selectedFilter) {
              case 'Customer Name':
                return doc["customerName"] != null && doc["customerName"].isNotEmpty;
              case 'Price':
                return doc["Selling Price"] != null && doc["Selling Price"] > 100;
              default:
                return true;
            }
          }).toList();

          // return ListView.builder(
          //   padding: EdgeInsets.all(10.0),
          //   itemCount: filteredDocs.length,
          //   itemBuilder: (context, index) {
          //     var doc = filteredDocs[index];

          //     return Card(
          //       margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
          //       elevation: 5,
          //       child: ListTile(
          //         contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          //         title: Text(
          //           "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
          //           style: const TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black,
          //             fontSize: 20,
          //           ),
          //         ),
          //         subtitle: Padding(
          //           padding: const EdgeInsets.only(top: 5.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "${doc["Email"]}",
          //                 style: const TextStyle(
          //                   color: Colors.blue,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               const SizedBox(height: 5),
          //               Text(
          //                 "Work-phone: ${doc["Work-phone"]}",
          //                 style: const TextStyle(
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               const SizedBox(height: 2),
          //               Text(
          //                 "Other Number: ${doc["Mobile"]}",
          //                 style: const TextStyle(
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         trailing: Wrap(
          //           spacing: 8.0,
          //           direction: Axis.vertical,
          //           children: [
          //             IconButton(
          //               icon: const Icon(Icons.phone, color: Colors.green, size: 25),
          //               onPressed: () => _makePhoneCall(doc.id),
          //             ),
          //             IconButton(
          //               icon: const Icon(Icons.message, color: Colors.blue, size: 25),
          //               onPressed: () => _sendMessage(doc.id),
          //             ),
          //             IconButton(
          //               icon: const Icon(Icons.edit, color: Colors.blue, size: 25),
          //               onPressed: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) => Customeredit(customerData: doc),
          //                   ),
          //                 );
          //               },
          //             ),
          //             IconButton(
          //               icon: const Icon(Icons.delete, color: Colors.red, size: 25),
          //               onPressed: () => _deleteCustomer(doc.id),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // );
        return  ListView.builder(
  padding: EdgeInsets.all(10.0),
  itemCount: filteredDocs.length,
  itemBuilder: (context, index) {
    var doc = filteredDocs[index];
     return InkWell(
      onTap: () {
        // Handle the tap event here
        Navigator.pushNamed(context,
        '/invoice'
          
          );
      },
    

    child:  Card(
      color: Color.fromARGB(255, 240, 207, 207),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(
                    
                    "${doc["Salutation"] ?? ''} ${doc["First Name"] ?? ''} ${doc["Last Name"] ?? ''}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                   Text(doc["customerID"],style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    ),
                  Text(
                    "${doc["Email"]}",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Work-phone: ${doc["Work-phone"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Other Number: ${doc["Mobile"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.phone, color: Colors.green, size: 25),
                  onPressed: () => _makePhoneCall(doc.id),
                ),
                IconButton(
                  icon: const Icon(Icons.message, color: Colors.blue, size: 25),
                  onPressed: () => _sendMessage(doc.id),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue, size: 25),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Customeredit(customerData: doc),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 25),
                  onPressed: () => _deleteCustomer(doc.id),
                ),
              ],
            ),
          ],
        ),
      ),
    )
    );
  },
);

        },
      ),
    );
  }

  void _showFilterOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                RadioListTile<String>(
                  title: const Text('All'),
                  value: 'All',
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Customer Name'),
                  value: 'Customer Name',
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Price > 100'),
                  value: 'Price',
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Customeredit extends StatelessWidget {
  final DocumentSnapshot customerData;

  Customeredit({required this.customerData});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController salutationController = TextEditingController();
  final TextEditingController workphoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    salutationController.text = customerData["Salutation"];
    firstNameController.text = customerData["First Name"];
    lastNameController.text = customerData["Last Name"];
    emailController.text = customerData["Email"];
    mobileController.text = customerData["Mobile"].toString();
    workphoneController.text = customerData["Work-phone"].toString();
    addressController.text = customerData["Address"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Customer"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Name:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: salutationController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Salutation',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First Name',
                          contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Last Name',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Customer Email:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Customer Address:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Address',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Customer Phone:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: workphoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Work Phone',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mobile',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
                   const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("USERS")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("customers")
                    .doc(customerData.id)
                    .update({
                  "Salutation":salutationController.text,
                  "First Name": firstNameController.text,
                  "Last Name": lastNameController.text,
                  "Email": emailController.text,
                  "Work-phone":int.tryParse(workphoneController.text) ?? workphoneController.text,
                  "Mobile": int.tryParse(mobileController.text) ?? mobileController.text,
                  "Address":addressController.text,
                } );

                Navigator.pop(context);
                 ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Updated the details"),
        ),
      );
                Navigator.pushNamed(context,'/customeradd');
              },
               style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
               child: const Text('Update', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
            ]
      ),
      )
      )
    );
  }
}