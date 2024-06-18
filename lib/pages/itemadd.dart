import 'package:cloneapp/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  customer(String? itemname,  int? sellingprice, String? description) async {
    if (itemname == null || sellingprice == null || description == null ) {
      print("Please enter required fields");
    } else {
      try {
        await FirebaseFirestore.instance.collection("USERS").doc(currentuser!.uid).collection("items").add({
          "Item Name": itemname,
          "Selling Price": sellingprice,
          "Description": description,
        });
        print("Data entered successfully");
        _sellingprice.clear();
        _description.clear();
        _itemname.clear();
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  @override
  void dispose() {
   _sellingprice.dispose();
   _itemname.dispose();
   _description.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
      ),
      // drawer: drawer(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextFormField(
                      controller: _itemname,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'item name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Selling Price',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextFormField(
                controller: _sellingprice,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'selling price',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextFormField(
                      controller: _description,
                     
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description ...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    customer(
                      _itemname.text,
                      int.tryParse(_sellingprice.text),
                      _description.text,
                    );
                    Navigator.pushNamed(context, '/invoice');
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
                     _sellingprice.clear();
        _description.clear();
        _itemname.clear();
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
    );
  }
}

