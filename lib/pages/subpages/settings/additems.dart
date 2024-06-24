// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class AddItems extends StatefulWidget {
//   const AddItems({Key? key}) : super(key: key);

//   @override
//   _AddItemsState createState() => _AddItemsState();
// }

// class _AddItemsState extends State<AddItems> {
//   String? selectedItem;
//   TextEditingController quantityController = TextEditingController();
//   TextEditingController searchController = TextEditingController();
//   double? rate;
//   double? price;
//   List<String> items = [];
//   List<String> filteredItems = [];
  
//   final currentuser = FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//     super.initState();
//     fetchItems();
//     searchController.addListener(_filterItems);
//   }

//   @override
//   void dispose() {
//     searchController.removeListener(_filterItems);
//     searchController.dispose();
//     super.dispose();
//   }

//   Future<void> fetchItems() async {
//     final snapshot = await FirebaseFirestore.instance.collection('USERS').doc(currentuser!.uid).collection("items").get();
//     setState(() {
//       items = snapshot.docs.map((doc) => doc['Item Name'].toString()).toList();
//       filteredItems = items;
//     });
//   }

//   void _filterItems() {
//     final query = searchController.text.toLowerCase();
//     setState(() {
//       filteredItems = items
//           .where((item) => item.toLowerCase().contains(query))
//           .toList();
//     });
//   }

//   void calculatePrice() {
//     if (quantityController.text.isNotEmpty && rate != null) {
//       setState(() {
//         price = double.parse(quantityController.text) * rate!;
//       });
//     } else {
//       setState(() {
//         price = null;
//       });
//     }
//   }

//   Future<void> fetchRate(String itemName) async {
//     final snapshot = await FirebaseFirestore.instance.
//         collection('USERS').doc(currentuser!.uid).collection("items")
//         .where('Item Name', isEqualTo: itemName)
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       setState(() {
//         rate = snapshot.docs.first['Selling Price'].toDouble();
//         calculatePrice();
//       });
//     }
//   }
// void saveItem() {
//   if (selectedItem != null && quantityController.text.isNotEmpty && rate != null && price != null) {
//     Navigator.pushNamed(
//       context,
//       '/invoiceadd',
//       arguments: {
//         'item': selectedItem,
//         'quantity': quantityController.text,
//         'rate': rate,
//         'price': price,
//       },
//     );
//   } else {
//     // Handle the error case if needed
//     print('Please ensure all fields are filled correctly.');
//   }
// }


//   void saveAndNewItem() {
//     saveItem();
//     setState(() {
//       selectedItem = null;
//       searchController.clear();
//       quantityController.clear();
//       rate = null;
//       price = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Items'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search Item',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             DropdownButton<String>(
//               isExpanded: true,
//               value: selectedItem,
//               hint: Text('Select an item'),
//               items: filteredItems.map((item) {
//                 return DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(item),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedItem = value;
//                   fetchRate(value!);
//                 });
//               },
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: quantityController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Quantity',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 calculatePrice();
//               },
//             ),
//             SizedBox(height: 16),
//             if (rate != null)
//               Text(
//                 'Rate: ${NumberFormat.currency(symbol: "\$").format(rate)}',
//                 style: TextStyle(fontSize: 16),
//               ),
//             if (price != null)
//               Text(
//                 'Price: ${NumberFormat.currency(symbol: "\$").format(price)}',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: saveAndNewItem,
//                   child: Text('Save and New'),
//                 ),
//                 ElevatedButton(
//                   onPressed: saveItem,
//                   child: Text('Save'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
