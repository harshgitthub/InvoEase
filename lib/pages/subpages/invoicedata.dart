import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Invoicedata extends StatefulWidget {
  const Invoicedata({Key? key}) : super(key: key);

  @override
  _InvoicedataState createState() => _InvoicedataState();
}

class _InvoicedataState extends State<Invoicedata> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? currentUser;
  CollectionReference termsCollection =
      FirebaseFirestore.instance.collection('USERS');

  List<Term> termsAndConditions = [];

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    if (currentUser != null) {
      fetchTermsAndConditions();
    }
  }

  Future<void> fetchTermsAndConditions() async {
    try {
      QuerySnapshot querySnapshot = await termsCollection
          .doc(currentUser!.uid)
          .collection('terms')
          .orderBy('index') // Order by the 'index' field
          .get();

      List<Term> tempList = [];

      querySnapshot.docs.forEach((doc) {
        tempList.add(Term(
          id: doc.id,
          text: doc['text'],
        ));
      });

      setState(() {
        termsAndConditions = tempList;
      });
    } catch (e) {
      print('Error fetching terms and conditions: $e');
    }
  }

  Future<void> addTermAndCondition(String text, int newIndex) async {
    try {
      await termsCollection
          .doc(currentUser!.uid)
          .collection('terms')
          .add({
            'text': text,
            'index': newIndex,
          });

      // Fetch updated terms list
      await fetchTermsAndConditions();
    } catch (e) {
      print('Error adding term and condition: $e');
    }
  }

  Future<void> deleteTermAndCondition(String id) async {
    try {
      await termsCollection
          .doc(currentUser!.uid)
          .collection('terms')
          .doc(id)
          .delete();

      // Fetch updated terms list
      await fetchTermsAndConditions();
    } catch (e) {
      print('Error deleting term and condition: $e');
    }
  }

  Future<void> updateTermAndCondition(String id, String newText) async {
    try {
      await termsCollection
          .doc(currentUser!.uid)
          .collection('terms')
          .doc(id)
          .update({
            'text': newText,
          });

      // Fetch updated terms list
      await fetchTermsAndConditions();
    } catch (e) {
      print('Error updating term and condition: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: ListView.builder(
        itemCount: termsAndConditions.length,
        itemBuilder: (context, index) {
          Term term = termsAndConditions[index];
          String termNumber = 'Term ${index + 1}';

          return ListTile(
            title: Text('$termNumber: ${term.text}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditTermDialog(term);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteTermAndCondition(term.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTermDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTermDialog() {
    TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Term and Condition'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Enter term and condition'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String text = textController.text;
                if (text.isNotEmpty) {
                  // Determine the new index based on the current list size
                  int newIndex = termsAndConditions.length;
                  addTermAndCondition(text, newIndex);
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTermDialog(Term term) {
    TextEditingController textController =
        TextEditingController(text: term.text);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Term and Condition'),
          content: TextField(
            controller: textController,
            decoration:
                const InputDecoration(hintText: 'Edit term and condition'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newText = textController.text;
                if (newText.isNotEmpty) {
                  updateTermAndCondition(term.id, newText);
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class Term {
  final String id;
  final String text;

  Term({required this.id, required this.text});
}
