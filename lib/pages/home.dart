// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class Home extends StatefulWidget {
//   Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final currentuser = FirebaseAuth.instance.currentUser;
//   Position? position ;
  
// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Check if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     return Future.error('Location permissions are permanently denied, we cannot request permissions.');
//   }

//   return await Geolocator.getCurrentPosition();
// }


//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Home"),
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
//               icon: const Icon(Icons.support_agent_rounded),
//               onPressed: () {
//                 // Implement support agent functionality
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.notification_add_rounded),
//               onPressed: () {
//                 // Implement notification functionality
//               },
//             ),
//           ],
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'Add Customer'),
//               Tab(text: 'Tab 2'),
//               Tab(text: 'Tab 3'),
//             ],
//           ),
//         ),
//         drawer: drawer(context),
//         body: TabBarView(
//           children: [
//             Center(
//               child: ElevatedButton.icon(
                
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/customer');
//                 },
//                 icon: const Icon(Icons.person_add, color: Colors.amber),
//                 label: const Text(
//                   'Add Customer',
//                   style: TextStyle(fontSize: 18, color:Colors.white) ,
//                 ),
//                 style: ElevatedButton.styleFrom(
//                  backgroundColor: Colors.amber,
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   elevation: 10,
//                   shadowColor: Colors.black.withOpacity(0.5),
//                 ),
//               ),
//             ),
//             const Center(
//               child: Column(
//                 children: [
//                   ElevatedButton(onPressed :
//                     _determinePosition()
//                    , 
//                   child: Text("location"),
//                   )
//                 ],
//               ),
//             ),
//             const Center(child: Text('Tab 3 Content')),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final currentUser = FirebaseAuth.instance.currentUser;
  Position? position;
  String locationMessage = '';

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = 'Location permissions are denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage = 'Location permissions are permanently denied';
      });
      return;
    }

    position = await Geolocator.getCurrentPosition();
    setState(() {
      locationMessage = 'Latitude: ${position?.latitude}, Longitude: ${position?.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
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
                // Implement support agent functionality
              },
            ),
            IconButton(
              icon: const Icon(Icons.notification_add_rounded),
              onPressed: () {
                // Implement notification functionality
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Add Customer'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
          ),
        ),
        drawer: drawer(context),
        body: TabBarView(
          children: [
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/customer');
                },
                icon: const Icon(Icons.person_add, color: Colors.amber),
                label: const Text(
                  'Add Customer',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _determinePosition,
                    child: const Text("Get Location"),
                  ),
                  const SizedBox(height: 20),
                  Text(locationMessage),
                ],
              ),
            ),
            const Center(child: Text('Tab 3 Content')),
          ],
        ),
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
        .doc(currentUser?.uid)
        .collection("details")
        .doc(currentUser?.uid)
        .snapshots(),
    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Missing Details"),
                content: const Text("Please complete your profile details."),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Go to Profile'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.pushNamed(context, '/details');
                    },
                  ),
                ],
              ),
            );
          });

          return const Center(child: CircularProgressIndicator());
        } else {
          var userData = snapshot.data!;
          var organization = userData["Organisation Name"] ?? "No Organization";
          var imageUrl = userData["Profile Image"];
          var item = userData["item"] ?? "item";

          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: imageUrl != null
                            ? NetworkImage(imageUrl)
                            : null,
                        child: imageUrl == null
                            ? const Icon(Icons.person, size: 30, color: Colors.white)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      
                      label: Text(
                        organization,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                           decoration: TextDecoration.underline, 
                           decorationColor: Colors.white, 

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildListTile(
                Icons.home_filled,
                'Home',
                '/home',
                context,
              ),
              buildListTile(
                Icons.person,
                'Customers',
                '/customeradd',
                context,
              ),
              buildListTile(
                Icons.list,
                item , 
                '/item',
                context,
              ),
              buildListTile(
                Icons.inbox_rounded,
                'Invoices',
                '/invoice',
                context,
              ),
              buildListTile(
                Icons.calendar_month,
                'Calendar',
                '/note',
                context,
              ),
              buildListTile(
                Icons.notes,
                'Notes',
                '/notepage',
                context,
              ),
              buildListTile(
                Icons.expand,
                'Pdf',
                '/about',
                context,
              ),
              buildListTile(
                Icons.settings,
                'Settings',
                '/setting',
                context,
              ),
            ],
          );
        }
      }
    },
  ),
);
}

Widget buildListTile(
  IconData icon,
  String title,
  String routeName,
  BuildContext context,
) {
  bool isSelected = ModalRoute.of(context)?.settings.name == routeName;

  return ListTile(
    leading: Icon(icon),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: isSelected ? Colors.blue : Colors.black87,
      ),
    ),
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
    selected: isSelected,
    selectedTileColor: Colors.grey[200],
  );
}