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
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final currentUser = FirebaseAuth.instance.currentUser;
  Position? position;
  String locationMessage = '';

   var currentuser = FirebaseAuth.instance.currentUser;
  final _organisation = TextEditingController();
  final _mobile = TextEditingController();
  final _address = TextEditingController();
  final _gst = TextEditingController();
  // final _propreitor = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  String? imageUrl;
  final ImagePicker _logoPicker = ImagePicker();
  String? logoUrl;

  final List<String> _professions = [
    'Engineer',
    'Doctor',
    'Lawyer',
    'Artist',
    'Teacher',
    'Other',
  ];
  String? _selectedProfession;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentuser!.uid)
        .collection("details")
        .doc(currentuser!.uid)
        .get();

    setState(() {
      _organisation.text = userDoc['Organisation Name'];
      // _propreitor.text = userDoc["Proprietor"];
      _address.text = userDoc['Address'];
      _mobile.text = userDoc['Phone Number'].toString();
      _gst.text = userDoc['gst'];
      _selectedProfession = userDoc['Profession'];
      imageUrl = userDoc['Profile Image'];
      logoUrl = userDoc['Logo'];
    });
  }


  // Future<void> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Check if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     setState(() {
  //       locationMessage = 'Location services are disabled.';
  //     });
  //     return;
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       setState(() {
  //         locationMessage = 'Location permissions are denied';
  //       });
  //       return;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     setState(() {
  //       locationMessage = 'Location permissions are permanently denied';
  //     });
  //     return;
  //   }

  //   position = await Geolocator.getCurrentPosition();
  //   setState(() {
  //     locationMessage = 'Latitude: ${position?.latitude}, Longitude: ${position?.longitude}';
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return  StreamBuilder(
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

          return
     Scaffold(
        appBar: CustomAppBar(organization: organization),
        // appBar: AppBar(
        //   title: Text(organization ,),
        //   titleTextStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.bold ,color: Colors.black),
        //   leading: Builder(
        //     builder: (BuildContext context) {
        //       return IconButton(
        //         icon: const Icon(Icons.menu),
        //         onPressed: () {
        //           Scaffold.of(context).openDrawer();
        //         },
        //         tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //       );
        //     },
        //   ),    
        // ),
        drawer: drawer(context),
//         body: Column(
//           children: [
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/customer');
//                 },
//                 icon: const Icon(Icons.person_add, color: Colors.amber),
//                 label: const Text(
//                   'Add Customer',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.amber,
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   elevation: 10,
//                   shadowColor: Colors.black.withOpacity(0.5),
//                 ),
//               ),
//             ),
//             // Center(
//             //   child: Column(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //       ElevatedButton(
//             //         onPressed: _determinePosition,
//             //         child: const Text("Get Location"),
//             //       ),
//             //       const SizedBox(height: 20),
//             //       Text(locationMessage),
//             //     ],
//             //   ),
//             // ),
//             // const Center(child: Text('Tab 3 Content')),
//           ],
//         ),
//       );
//   }
// }

 body:
 Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome, [User Name]',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildCarousel(),
              const SizedBox(height: 20),
              // const SizedBox(height: 10),
              // _buildProfileSummary(),
              const SizedBox(height: 20),
              // _buildSearchBar(),
              // const SizedBox(height: 20),
               const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
              _buildCard(
                context,
                title: 'Customer',
                subtitle: 'Add customer to begin invoicing',
                icon: Icons.person,
                color: Colors.blue,
                route: '/customer',
              ),
              _buildCard(
                context,
                title: 'Calendar',
                subtitle: 'Helps to set timer',
                icon: Icons.calendar_today,
                color: Colors.green,
                route: '/note',
              ),
              _buildCard(
                context,
                title: 'Notes',
                subtitle: 'Keep track of important information',
                icon: Icons.notes,
                color: Colors.red,
                route: '/notepage',
              ),
              const SizedBox(height: 20),
              // _buildStatistics(),
              const Text("Statistics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
               Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: InvoiceStatistics(userId: currentUser!.uid)),
         
          Expanded(
            flex: 2,
            child: CustomerStatistics(userId: currentUser!.uid)),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: CalendarStatistics(userId: currentUser!.uid)),
         
          Expanded(
            flex: 2,
            child: NoteStatistics(userId: currentUser!.uid)),
        ],
      ),
             
              const SizedBox(height: 20),
              // _buildRecentActivities(),
            ],
          ),
        ),
 )
     );
 
        }
  }
    }
    );
  }

  }

  Widget _buildCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSummary() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/profile.jpg'),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '[User Name]',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'View Profile',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Add new invoice action
              },
              icon: const Icon(Icons.receipt),
              label: const Text('New Invoice'),
              style: ElevatedButton.styleFrom(
                
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Add new note action
              },
              icon: const Icon(Icons.note_add),
              label: const Text('New Note'),
              style: ElevatedButton.styleFrom(
              
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 300),
        viewportFraction: 0.8,
      ),
      items: [
        'assets/invoice_1.png',
        'assets/invoice_2.png',
        'assets/invoice_3.png'
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(i),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildStatistics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Statistics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatisticCard('Total Sales', '\$50,000', Icons.attach_money, Colors.teal),
            _buildStatisticCard('Invoices', '120', Icons.receipt, Colors.orange),
            _buildStatisticCard('Customers', '80', Icons.people, Colors.purple),
          ],
        ),
      ],
    );
  }



    Widget _buildStatisticCard(String title, String value, IconData icon, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activities',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 3, // Number of recent activities to display
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text('Activity ${index + 1}'),
              subtitle: Text('Details about activity ${index + 1}'),
            );
          },
        ),
      ],
    );
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
                'Items', 
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


class InvoiceStatistics extends StatefulWidget {
  final String userId;

  InvoiceStatistics({required this.userId});

  @override
  State<InvoiceStatistics> createState() => _InvoiceStatisticsState();
}

class _InvoiceStatisticsState extends State<InvoiceStatistics> {
  final currentuser = FirebaseAuth.instance.currentUser;
  Future<int> _getInvoiceCount() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
    
        .collection('USERS')
        .doc(currentuser!.uid)
        .collection('invoices')
        .get();
    return snapshot.docs.length;
  }

  Widget _buildStatisticCard(String title, String value, IconData icon, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _getInvoiceCount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == 0) {
          return _buildStatisticCard('Invoices', '0', Icons.receipt, Colors.orange);
        } else {
          return _buildStatisticCard('Invoices', snapshot.data.toString(), Icons.receipt, Colors.orange);
        }
      },
    );
  }
}

class CustomerStatistics extends StatefulWidget {
  final String userId;

  CustomerStatistics({required this.userId});

  @override
  State<CustomerStatistics> createState() => _CustomerStatisticsState();
}

class _CustomerStatisticsState extends State<CustomerStatistics> {
   final currentuser = FirebaseAuth.instance.currentUser;
  Future<int> _getCustomerCount() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentuser!.uid)
        .collection('customers')
        .get();
    return snapshot.docs.length;
  }

  Widget _buildStatisticCard(String title, String value, IconData icon, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _getCustomerCount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == 0) {
          return _buildStatisticCard('Customers', '0', Icons.people, Colors.purple);
        } else {
          return _buildStatisticCard('Customers', snapshot.data.toString(), Icons.people, Colors.purple);
        }
      },
    );
  }
}




class CalendarStatistics extends StatefulWidget {
  final String userId;

  CalendarStatistics({required this.userId});

  @override
  State<CalendarStatistics> createState() => _CalendarStatisticsState();
}

class _CalendarStatisticsState extends State<CalendarStatistics> {
  final currentuser = FirebaseAuth.instance.currentUser;
  Future<int> _getInvoiceCount() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
    
        .collection('USERS')
        .doc(currentuser!.uid)
        .collection('calendar')
        .get();
    return snapshot.docs.length;
  }

  Widget _buildStatisticCard(String title, String value, IconData icon, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _getInvoiceCount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == 0) {
          return _buildStatisticCard('Tasks', '0', Icons.checklist, Colors.purple);
        } else {
          return _buildStatisticCard('Tasks', snapshot.data.toString(), Icons.checklist,Colors.purple);
        }
      },
    );
  }
}




class NoteStatistics extends StatefulWidget {
  final String userId;

  NoteStatistics({required this.userId});

  @override
  State<NoteStatistics> createState() => _NoteStatisticsState();
}

class _NoteStatisticsState extends State<NoteStatistics> {
  final currentuser = FirebaseAuth.instance.currentUser;
  Future<int> _getInvoiceCount() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
    
        .collection('USERS')
        .doc(currentuser!.uid)
        .collection('notes')
        .get();
    return snapshot.docs.length;
  }

  Widget _buildStatisticCard(String title, String value, IconData icon, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _getInvoiceCount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == 0) {
          return _buildStatisticCard('Notes', '0', Icons.notes, Colors.orange);
        } else {
          return _buildStatisticCard('Notes', snapshot.data.toString(), Icons.notes, Colors.orange);
        }
      },
    );
  }
}




class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String organization;

  CustomAppBar({required this.organization});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        organization,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: false, // To center the title
      backgroundColor: Colors.white, // Change background color if desired
      elevation: 4.0, // Add elevation for a shadow effect
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu_open_outlined, color: Colors.black), // Change icon color
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black), // Add a search icon
          onPressed: () {
            // Define search action
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black), // Add a notifications icon
          onPressed: () {
            // Define notifications action
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.yellow],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ), // Add a gradient background
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}