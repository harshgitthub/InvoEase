
import 'package:cloneapp/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Customerpage extends StatefulWidget {
  const Customerpage({super.key});

 @override
  State<Customerpage> createState() => _CustomerpageState();
}
class _CustomerpageState extends State<Customerpage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  String selectedFilter = 'All';
  // final String mobileNumber = currentUser.

  // void _makePhoneCall() async {
  //   if (await canLaunchUrl('tel:$mobileNumber')) {
  //     await launchUrl('tel:$mobileNumber');
  //   } else {
  //     throw 'Could not launch $mobileNumber';
  //   }
  // }

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
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implement filter options (e.g., dropdown menu)
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
                // Apply selected filters
                if (selectedFilter == 'All') return true;
                if (selectedFilter == 'Item Name') {
                  return doc["Item Name"] != null && doc["Item Name"].isNotEmpty;
                }
                if (selectedFilter == 'Price') {
                  return doc["Selling Price"] != null && doc["Selling Price"] > 100;
                }
                return false;
              }).toList();

              return ListView.builder(
                itemCount: filteredDocs.length,
                itemBuilder: (context, index) {
                  var doc = filteredDocs[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      "${doc["Salutation"]} ${doc["First Name"]} ${doc["Last Name"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          "${doc["Email"]}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
          //                IconButton(
          //   onPressed: _makePhoneCall,
          //   icon: Icon(Icons.phone),
          // ),
                        Text(
                          
                          "Work-phone: ${doc["Work-phone"]}",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 2),
          //                IconButton(
          //   onPressed: _makePhoneCall,
          //   icon: Icon(Icons.phone),
          // ),
                        Text(
                          "Other Number : ${doc["Mobile"]}",
                          style: const TextStyle(fontWeight: FontWeight.w500),
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
    // Implement filter options (e.g., showDialog with choices)
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
                title: const Text('Item Name'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'Item Name';
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
