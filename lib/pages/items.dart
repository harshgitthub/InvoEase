import 'dart:async';

import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/invoice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  final currentuser = FirebaseAuth.instance.currentUser;
  String selectedFilter = 'All';

  void updateItem(String itemId, String? itemName, int? sellingPrice, String? description) async {
    try {
      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("items")
          .doc(itemId)
          .update({
            "Item Name": itemName,
            "Selling Price": sellingPrice,
            "Description": description,
          });
      print('Item updated successfully');
    } catch (e) {
      print('Error updating item: $e');
      // Handle error as needed
    }
  }


  // Show warning dialog and wait for user confirmation
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items"),
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
          IconButton(onPressed: (){
            Navigator.pushNamed(context,'/itemadd');
          }, icon: const Icon(Icons.add),
          tooltip: "Add Item",),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ItemSearchDelegate());
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      drawer: drawer(context),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.amber,
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/itemadd');
      //   },
      //   child: const Icon(Icons.add),
      // ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("USERS")
            .doc(currentuser!.uid)
            .collection("items")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              var filteredDocs = snapshot.data!.docs.where((doc) {
                if (selectedFilter == 'All') return true;
                if (selectedFilter == 'Item Name') {
                  return doc["Item Name"].isNotEmpty;
                }
                if (selectedFilter == 'Price') {
                  // Example filter condition, adjust as per your needs
                  return doc["Selling Price"] != null && doc["Selling Price"] > 100;
                }
                return false;
              }).toList();

              return ListView.builder(
                itemCount: filteredDocs.length,
                itemBuilder: (context, index) {
                  var doc = filteredDocs[index];
                  String itemId = doc.id;

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    // leading: CircleAvatar(
                    //   backgroundColor: Colors.blueAccent,
                    //   child: Text(
                    //     "${index + 1}",
                    //     style: const TextStyle(color: Colors.white),
                    //   ),
                    // ),
                    title: Text(
                      "${doc["Item Name"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          "${doc["Description"]}",
                          style: const TextStyle(color: Colors.grey ,fontWeight: FontWeight.w700,fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Price: ₹ ${doc["Selling Price"]}",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Edititem(
                              itemId: itemId,
                              initialItemName: doc["Item Name"],
                              initialSellingPrice: doc["Selling Price"],
                              initialDescription: doc["Description"],
                            ),
                          ),
                        );
                      },
                    
                      child: const Text('Update Item' , style: TextStyle(fontSize: 14 , color: Colors.black),),
                    ),
                  
                  );
                },
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No data available"));
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error fetching data"));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter'),
          content: DropdownButton<String>(
            value: selectedFilter,
            items: <String>['All', 'Item Name', 'Price']
                .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                selectedFilter = value!;
              });
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}

class ItemSearchDelegate extends SearchDelegate {
  final currentuser = FirebaseAuth.instance.currentUser;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("items")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var filteredDocs = snapshot.data!.docs.where((doc) {
              return doc["Item Name"]
                  .toLowerCase()
                  .contains(query.toLowerCase());
            }).toList();

            return ListView.builder(
              itemCount: filteredDocs.length,
              itemBuilder: (context, index) {
                var doc = filteredDocs[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("${index + 1}"),
                  ),
                  title: Text("${doc["Item Name"]}"),
                  subtitle: Text(
                      "${doc["Description"]}\nPrice: ${doc["Selling Price"]}"),
                );
              },
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No data available"));
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching data"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}


class Edititem extends StatefulWidget {
  final String itemId;
  final String initialItemName;
  final int initialSellingPrice;
  final String initialDescription;

  const Edititem({
    super.key,
    required this.itemId,
    required this.initialItemName,
    required this.initialSellingPrice,
    required this.initialDescription,
  });

  @override
  _EdititemState createState() => _EdititemState();
}

class _EdititemState extends State<Edititem> {
  final _itemname = TextEditingController();
  final _sellingprice = TextEditingController();
  final _description = TextEditingController();

  @override
  void initState() {
    super.initState();
    _itemname.text = widget.initialItemName;
    _sellingprice.text = widget.initialSellingPrice.toString();
    _description.text = widget.initialDescription;
  }

  @override
  void dispose() {
    _itemname.dispose();
    _sellingprice.dispose();
    _description.dispose();
    super.dispose();
  }
  

  void updateUser() async {
    String? itemName = _itemname.text;
    int? sellingPrice = int.tryParse(_sellingprice.text);
    String? description = _description.text;

    try {
      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("items")
          .doc(widget.itemId)
          .update({
            "Item Name": itemName,
            "Selling Price": sellingPrice,
            "Description": description,
          });
      print('Document updated successfully');
      Navigator.of(context).push(_createRoute());
    } catch (e) {
      print('Error updating document: $e');
      // Handle error as needed
    }
  }
  void deleteUserItem() async {
  // try {
  //   await FirebaseFirestore.instance
  //       .collection("USERS")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("items")
  //       .doc(widget.itemId)
  //       .delete();
  //   print('Document deleted successfully');
  //   Navigator.pushNamed(context, '/item');
  // } catch (e) {
  //   print('Error deleting document: $e');
  //   // Handle error as needed
  // }
   bool shouldDelete = await showWarning(context);

  // If the user confirmed the deletion, proceed with deleting the customer document
  if (shouldDelete) {
    await FirebaseFirestore.instance
        .collection("USERS")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(widget.itemId)
        .delete();
  }
}

Future<bool> showWarning(BuildContext context) async {
  // Completer to signal the result of the dialog
  Completer<bool> completer = Completer<bool>();

  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            completer.complete(false); // Signal that the deletion should not proceed
          },
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            completer.complete(true); // Signal that the deletion should proceed
          },
        ),
      ],
    ),
  );

  // Wait for the dialog to be closed and the result to be returned
  return completer.future;
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Edit Item"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Item Name ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _itemname,
            decoration: const InputDecoration(
              hintText: 'add name of item',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _description,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'add description of item',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Price',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _sellingprice,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter Selling Price',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: updateUser,
                  child: const Text('Update Item'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: deleteUserItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Red color for delete button
                  ),
                  child: const Text('Delete Item' , style:  TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the edit item page
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => InvoiceView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

}
