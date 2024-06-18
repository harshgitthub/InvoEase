import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
    Home({super.key});

  final currentuser = FirebaseAuth.instance.currentUser;
  


  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Name of the organisation"),
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
              icon: const Icon(Icons.support_agent_rounded),
              onPressed: () {
                // Implement search functionality
              },
            ),
            IconButton(
              icon: const Icon(Icons.notification_add_rounded),
              onPressed: () {
                // Implement filter functionality
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab3'),
            ],
          ),
        ),
        drawer: drawer(context),    
      ),
    );
  }
}

Drawer drawer(BuildContext context) {
  final currentUser = FirebaseAuth.instance.currentUser;

  return Drawer(
    child: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("details")
          .doc(currentUser.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            // Show a popup and redirect to '/profile'
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("Missing Details"),
                  content: Text("Please complete your profile details."),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Go to Profile'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        Navigator.pushNamed(context, '/details');
                      },
                    ),
                  ],
                ),
              );
            });

            // Return a placeholder or loading indicator until redirect
            return Center(child: CircularProgressIndicator());
          } else {
            var userData = snapshot.data!;
            var organization =
                userData["Organisation Name"] ?? "No Organization";
            var imageUrl = userData["Profile Image"];

            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      imageUrl != null
                          ? CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(imageUrl),
                            )
                          : CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.person, size: 30),
                            ),
                      SizedBox(height: 8),
                      Text(
                        organization,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 4),
                      // Add other user information as needed
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Customer',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/customeradd');
                  },
                ),
                Divider(
                  thickness: 2,
                  height: 3,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text(
                    'Items',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/item');
                  },
                ),
                Divider(
                  thickness: 2,
                  height: 3,
                ),
                ListTile(
                  leading: Icon(Icons.inbox_rounded),
                  title: Text(
                    'Invoices',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/invoice');
                  },
                ),
                Divider(
                  thickness: 2,
                  height: 3,
                ),
                ListTile(
                  leading: Icon(Icons.note_add),
                  title: Text(
                    'Add Notes',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/note');
                  },
                ),
                Divider(
                  thickness: 2,
                  height: 3,
                ),
                ListTile(
                  leading: Icon(Icons.expand),
                  title: Text(
                    'Invoice Pdf',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                Divider(
                  thickness: 2,
                  height: 3,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/setting');
                  },
                ),
                Divider(
                  thickness: 2,
                  height: 3,
                ),
              ],
            );
          }
        }
      },
    ),
  );
}
