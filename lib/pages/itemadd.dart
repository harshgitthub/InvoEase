import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Itemadd extends StatefulWidget {
  const Itemadd({super.key});

  @override
  State<Itemadd> createState() => _ItemaddState();
}

class _ItemaddState extends State<Itemadd> {
  var currentuser = FirebaseAuth.instance.currentUser;

  final _itemname = TextEditingController();
  final _sellingprice = TextEditingController();
  final _description = TextEditingController();

  void addItem(String itemname, int? sellingprice, String description) async {
    if (itemname.isEmpty  ) {
      _showErrorDialog(context, "Add Name of item");
      return;
    }
    if(sellingprice == null){
      _showErrorDialog(context, "Add price of item"); 
      return;
    }

    try {
      // Check if an item with the same name already exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("items")
          .where("Item Name", isEqualTo: itemname)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Item with the same name exists, show warning dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Warning'),
              content: const Text('An item with this name already exists. Do you want to proceed?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Rename'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Proceed'),
                  onPressed: () {
                    // Proceed with adding the item
                    _saveItem(itemname, sellingprice, description);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // No existing item with the same name, proceed to add
        _saveItem(itemname, sellingprice, description);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

 void _saveItem(String itemname, int? sellingprice, String description) async {
  try {
    await FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentuser!.uid)
        .collection("items")
        .add({
          "Item Name": itemname,
          "Selling Price": sellingprice,
          "Description": description,
        });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Item added successfully."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context,'/customeradd');
              },
            ),
          ],
        );
      },
    );
    _itemname.clear();
    _sellingprice.clear();
    _description.clear();
  } catch (e) {
    print("Error: $e");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text("Failed to add item. Error: $e"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
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
 void _showErrorDialog(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: 'Error',
    desc: message,
    btnOkText: 'OK',
    btnOkColor: Colors.red,
    btnOkOnPress: () {
      // Optionally perform some action on button press
    },
  ).show();
}


  @override
  void dispose() {
    _itemname.dispose();
    _sellingprice.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser ;
  return 
   StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentUser?.uid)
        .collection("details")
        .doc(currentUser?.uid)
        .snapshots(),
    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Loading"),
          ),
          body: const Center(child: CircularProgressIndicator()),
        );
      } else if (snapshot.hasError) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Loading"),
          ),
          body: Center(child: Text("Error: ${snapshot.error}")),
        );
      } else if (!snapshot.hasData || !snapshot.data!.exists) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("No data"),
          ),
          body: const Center(child: Text("No data available")),
        );
      } else {
        var userData = snapshot.data!;
        var item = userData["item"] ?? "Default Item Name";

        return Scaffold(
          appBar: AppBar(
            title: Text('Add $item'),
          ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                '$item *',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: _itemname,
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add name of $item ',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: _description,
                  maxLines: null, // Allow multiple lines of description
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add description of $item',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  ),
                ),
              ),
               const SizedBox(height: 20),
              const Text(
                'Price *',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: _sellingprice,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: 'price of $item',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addItem(
                        _itemname.text.trim(),
                        int.tryParse(_sellingprice.text.trim()),
                        _description.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _itemname.clear();
                      _sellingprice.clear();
                      _description.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
        );
      }
    });
  }
}