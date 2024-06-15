import 'package:cloneapp/pages/home.dart';
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.pushNamed(context, '/itemadd');
        },
        child: const Icon(Icons.add),
      ),
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
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      "${doc["Item Name"]}",
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
                          "${doc["Description"]}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Price: Rs ${doc["Selling Price"]}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
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
                      child: const Text('Update Item'),
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
      Navigator.pushNamed(context, '/item');
    } catch (e) {
      print('Error updating document: $e');
      // Handle error as needed
    }
  }
  void deleteUserItem() async {
  try {
    await FirebaseFirestore.instance
        .collection("USERS")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(widget.itemId)
        .delete();
    print('Document deleted successfully');
    Navigator.pushNamed(context, '/item');
  } catch (e) {
    print('Error deleting document: $e');
    // Handle error as needed
  }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _itemname,
              decoration: const InputDecoration(
                hintText: 'Item Name',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Selling Price',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _sellingprice,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Selling Price',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _description,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: updateUser,
                  child: const Text('Update Item'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: deleteUserItem,
                  child: const Text('delete Item'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
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
}
