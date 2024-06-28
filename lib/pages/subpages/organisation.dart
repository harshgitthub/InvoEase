import 'package:cloneapp/localization/locales.dart';
import 'package:cloneapp/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  var currentUser = FirebaseAuth.instance.currentUser;
  late FlutterLocalization _flutterLocalization;

  final _item = TextEditingController(text: 'Items'); // Set the default item name here

late String _currentLocale;


@override
  void initState() {
    super.initState();
    _fetchUserData();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    print(_currentLocale);
    
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("details")
          .doc(currentUser!.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          _item.text = userDoc.get('item') ?? _item.text;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> saveItemData(String item) async {
    try {
      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentUser!.uid)
          .collection("details")
          .doc(currentUser!.uid)
          .update({
        "item": item,
      });
      print("Item name entered successfully");
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to save item name: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("USERS")
              .doc(currentUser?.uid)
              .collection("details")
              .doc(currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            } else if (snapshot.hasError) {
              return const Text("Error");
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text("No Data");
            } else {
              var userData = snapshot.data!;
              var item = userData["item"] ?? "Default Item Name";
              return Text(LocaleData.title.getString(context));
            }
          },
        ),
        backgroundColor: Colors.blue, // Example of setting a specific color
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
      DropdownButton(value: _currentLocale,
        items: 
      const [DropdownMenuItem(value :"en" ,child: Text("English")) , 
      DropdownMenuItem(value :"ge" ,child: Text("German")) , 
      DropdownMenuItem(value :"ch" ,child: Text("Chinese"))], onChanged:
      (value){
_setlocale(vaue){

}
      })
],

      ),
      drawer: drawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Enter the name you want to give to the things you sell",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _item,
                decoration: const InputDecoration(
                  
                  hintText: 'Enter item name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_item.text.isNotEmpty) {
                    saveItemData(_item.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Item name cannot be empty"),
                      ),
                    );
                  }
                },
                child: Text("Save Item".tr),
              ),
              

            ],
          ),
        ),
      ),
    );
  }
  void _setLocale(String? value) {
if (value == null) return;
if (value == "en") {
_flutterLocalization.translate("en");
} else if (value == "de") {
_flutterLocalization.translate("de");
} else if (value == "zh") {
_flutterLocalization. translate("zh");
} else {
return;
}
setState(() {
_currentLocale  = value ;
});
}
}

// // // import 'package:cloneapp/pages/home.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:geolocator/geolocator.dart';
// // // import 'package:localization/localization.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';

// // // class Preferences extends StatefulWidget {
// // //   const Preferences({Key? key}) : super(key: key);

// // //   @override
// // //   State<Preferences> createState() => _PreferencesState();
// // // }

// // // class _PreferencesState extends State<Preferences> {
// // //   var currentUser = FirebaseAuth.instance.currentUser;
// // //   final _item = TextEditingController(text: 'Default Item Name');
// // //   String _locationAddress = 'Fetching location...';
// // //   String _selectedCurrency = 'USD'; // Default currency
// // //   Locale _selectedLocale = const Locale('en'); // Default locale for English

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _fetchUserData();
// // //     _fetchUserLocation();
// // //   }

// // //   Future<void> _fetchUserData() async {
// // //     try {
// // //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
// // //           .collection("USERS")
// // //           .doc(currentUser!.uid)
// // //           .collection("details")
// // //           .doc(currentUser!.uid)
// // //           .get();

// // //       if (userDoc.exists) {
// // //         setState(() {
// // //           _item.text = userDoc.get('item') ?? _item.text;
// // //           _selectedCurrency = userDoc.get('currency') ?? _selectedCurrency;
// // //           String? languageCode = userDoc.get('language');
// // //           _selectedLocale = languageCode != null ? Locale(languageCode) : const Locale('en');
// // //         });
// // //       }
// // //     } catch (e) {
// // //       print("Error fetching user data: $e");
// // //     }
// // //   }

// // //   Future<void> _fetchUserLocation() async {
// // //    try {
// // //   Position position = await Geolocator.getCurrentPosition(
// // //       desiredAccuracy: LocationAccuracy.high);
// // //   List<Placemark> placemarks = await placemarkFromCoordinates(
// // //       position.latitude, position.longitude);
// // //   if (placemarks.isNotEmpty) {
// // //     Placemark place = placemarks[0];
// // //     setState(() {
// // //       _locationAddress = "${place.street}, ${place.locality}, ${place.country}";
// // //     });
// // //   } else {
// // //     setState(() {
// // //       _locationAddress = "Unknown location";
// // //     });
// // //   }
// // // } catch (e) {
// // //   print("Error fetching location: $e");
// // //   setState(() {
// // //     _locationAddress = "Location unavailable";
// // //   });
// // // }

// // //   }

// // //   Future<void> savePreferences(String item, String currency, Locale locale) async {
// // //     try {
// // //       await FirebaseFirestore.instance
// // //           .collection("USERS")
// // //           .doc(currentUser!.uid)
// // //           .collection("details")
// // //           .doc(currentUser!.uid)
// // //           .update({
// // //         "item": item,
// // //         "location": _locationAddress,
// // //         "currency": currency,
// // //         "language": locale.languageCode,
// // //       });
// // //       print("Preferences saved successfully");
// // //       Navigator.pushNamed(context, '/home');
// // //     } catch (e) {
// // //       print("Error: $e");
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(
// // //           backgroundColor: Colors.red,
// // //           content: Text("Failed to save preferences: $e"),
// // //         ),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("Preferences"),
// // //       ),
// // //       drawer: drawer(context),
// // //       body: SingleChildScrollView(
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               const Text(
// // //                 "Enter the name you want to give to the things you sell",
// // //                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// // //               ),
// // //               SizedBox(height: 10),
// // //               TextFormField(
// // //                 controller: _item,
// // //                 decoration: InputDecoration(
// // //                   labelText: 'Item Name',
// // //                   hintText: 'Enter item name',
// // //                   border: OutlineInputBorder(),
// // //                   contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
// // //                 ),
// // //               ),
// // //               SizedBox(height: 20),
// // //               const Text(
// // //                 "Your current location",
// // //                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// // //               ),
// // //               SizedBox(height: 10),
// // //               Text(_locationAddress),
// // //               SizedBox(height: 20),
// // //               const Text(
// // //                 "Select your currency",
// // //                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// // //               ),
// // //               SizedBox(height: 10),
// // //               DropdownButtonFormField<String>(
// // //                 value: _selectedCurrency,
// // //                 onChanged: (value) {
// // //                   setState(() {
// // //                     _selectedCurrency = value!;
// // //                   });
// // //                 },
// // //                 items: <String>['USD', 'EUR', 'GBP', 'JPY', 'CNY']
// // //                     .map<DropdownMenuItem<String>>((String value) {
// // //                   return DropdownMenuItem<String>(
// // //                     value: value,
// // //                     child: Text(value),
// // //                   );
// // //                 }).toList(),
// // //               ),
// // //               SizedBox(height: 20),
// // //               const Text(
// // //                 "Select your language",
// // //                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// // //               ),
// // //               SizedBox(height: 10),
// // //               DropdownButtonFormField<Locale>(
// // //                 value: _selectedLocale,
// // //                 onChanged: (value) {
// // //                   setState(() {
// // //                     _selectedLocale = value!;
// // //                   });
// // //                 },
// // //                 items: <Locale>[
// // //                   const Locale('en'),
// // //                   const Locale('es'),
// // //                   const Locale('fr'),
// // //                   const Locale('de'),
// // //                   const Locale('zh'),
// // //                 ].map<DropdownMenuItem<Locale>>((Locale value) {
// // //                   return DropdownMenuItem<Locale>(
// // //                     value: value,
// // //                     child: Text(Internationalization(value.languageCode).language),
// // //                   );
// // //                 }).toList(),
// // //               ),
// // //               SizedBox(height: 20),
// // //               ElevatedButton(
// // //                 onPressed: () {
// // //                   if (_item.text.isNotEmpty) {
// // //                     savePreferences(_item.text, _selectedCurrency, _selectedLocale);
// // //                   } else {
// // //                     ScaffoldMessenger.of(context).showSnackBar(
// // //                       SnackBar(
// // //                         backgroundColor: Colors.red,
// // //                         content: Text("Item name cannot be empty"),
// // //                       ),
// // //                     );
// // //                   }
// // //                 },
// // //                 child: Text("Save Preferences"),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Internationalization {
// // //   String language;
// // //   Internationalization(this.language);
// // // }


// import 'package:cloneapp/app_localis.dart';
// import 'package:cloneapp/locale_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';



// class Preferences extends StatefulWidget {
//   const Preferences({super.key});

//   @override
//   State<Preferences> createState() => _PreferencesState();
// }

// class _PreferencesState extends State<Preferences> {
//   var currentUser = FirebaseAuth.instance.currentUser;
//   final _item = TextEditingController(text: 'Items'); // Set the default item name here

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//   }

//   Future<void> _fetchUserData() async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentUser!.uid)
//           .collection("details")
//           .doc(currentUser!.uid)
//           .get();

//       if (userDoc.exists) {
//         setState(() {
//           _item.text = userDoc.get('item') ?? _item.text;
//         });
//       }
//     } catch (e) {
//       print("Error fetching user data: $e");
//     }
//   }

//   Future<void> saveItemData(String item) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("USERS")
//           .doc(currentUser!.uid)
//           .collection("details")
//           .doc(currentUser!.uid)
//           .update({
//         "item": item,
//       });
//       print("Item name entered successfully");
//       Navigator.pushNamed(context, '/home');
//     } catch (e) {
//       print("Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           content: Text("Failed to save item name: $e"),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var localizations = AppLocalizations.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: StreamBuilder<DocumentSnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection("USERS")
//               .doc(currentUser?.uid)
//               .collection("details")
//               .doc(currentUser?.uid)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Text(localizations.translate("loading"));
//             } else if (snapshot.hasError) {
//               return Text(localizations.translate("error"));
//             } else if (!snapshot.hasData || !snapshot.data!.exists) {
//               return Text(localizations.translate("no_data"));
//             } else {
//               var userData = snapshot.data!;
//               var item = userData["item"] ?? localizations.translate("item_name");
//               return Text(item);
//             }
//           },
//         ),
//         backgroundColor: Colors.blue, // Example of setting a specific color
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
//           DropdownButton<Locale>(
//             icon: Icon(Icons.language, color: Colors.white),
//             onChanged: (Locale? locale) {
//               if (locale != null) {
//                 Provider.of<LocaleProvider>(context, listen: false).setLocale(locale);
//               }
//             },
//             items: L10n.all.map((locale) {
//               final flag = L10n.getFlag(locale.languageCode);
//               return DropdownMenuItem(
//                 value: locale,
//                 child: Center(
//                   child: Text(
//                     flag,
//                     style: TextStyle(fontSize: 24),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         // Define your drawer content here
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Text(
//                 localizations.translate("enter_item_name"),
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _item,
//                 decoration: InputDecoration(
//                   hintText: localizations.translate("item_name"),
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_item.text.isNotEmpty) {
//                     saveItemData(_item.text);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         backgroundColor: Colors.red,
//                         content: Text(localizations.translate("item_name_empty")),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text(localizations.translate("save_item")),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
