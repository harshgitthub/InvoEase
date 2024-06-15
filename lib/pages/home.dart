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
      body: TabBarView(children:[
         StreamBuilder(
  stream: FirebaseFirestore.instance.collection("users").snapshots(),
  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.active) {
      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var doc = snapshot.data!.docs[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text("${index + 1}"),
              ),
              title: Text("${doc["Title"]}"),
              subtitle: Text("${doc["Description"]}"),
            );
          },
        );
      } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
        return const Center(child: Text("No data available"));
      } else if (snapshot.hasError) {
        return const Center(child: Text("Data has error"));
      }
    } 
    return const Center(child: CircularProgressIndicator());
  },
),
 const Center(
              child: Text('Tab 2 Content'),
            ),
const Center(
              child: Text('tab 3 finally'),
            ),

      ])     
,

    )
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
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No organization data"));
          } else {
            var userData = snapshot.data!;
            var organization = userData["Organisation"] ?? "No Organization";
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    organization,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Customer'),
                  onTap: () {
                    Navigator.pushNamed(context, '/customeradd');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Items'),
                  onTap: () {
                    Navigator.pushNamed(context, '/item');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.inbox_rounded),
                  title: const Text('Invoices'),
                  onTap: () {
                    Navigator.pushNamed(context, '/invoice');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.note_add),
                  title: const Text('Add Notes'),
                  onTap: () {
                    Navigator.pushNamed(context, '/note');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.expand),
                  title: const Text('Invoice Pdf'),
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text('Reports'),
                  onTap: () {
                    Navigator.pushNamed(context, '/report');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pushNamed(context, '/setting');
                  },
                ),
              ],
            );
          }
        }
      },
    ),
  );
}
