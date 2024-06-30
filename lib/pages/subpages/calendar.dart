import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/subpages/addnotes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});
Future<void> _deletetask(BuildContext context, String taskId) async {
  // Show confirmation dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
          ),
          TextButton(
            child: const Text("Delete"),
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                try {
                  // Perform delete operation
                  await FirebaseFirestore.instance
                      .collection('USERS')
                      .doc(user.uid)
                      .collection('calendar')
                      .doc(taskId)
                      .delete();
                  Navigator.of(context).pop(); // Close dialog
                  // Optionally show a confirmation Snackbar or Toast
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Task deleted successfully"),
                    ),
                  );
                } catch (e) {
                  print("Error deleting task: $e");
                  // Optionally show an error Snackbar or Toast
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Failed to delete task"),
                    ),
                  );
                }
              }
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
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
        actions: [IconButton(onPressed:  () {
          Navigator.pushNamed(context, '/taskadd');
        },icon: Icon(Icons.bookmark_add_outlined) ,iconSize: 30,)],
      ),
      drawer: drawer(context),
      
      body: user != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('USERS')
                  .doc(user.uid)
                  .collection('calendar')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No record found'));
                }

                final notes = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    final noteData = note.data() as Map<String, dynamic>;
                    final noteId = note.id;
                    final task = noteData['task'];
                    final dateTime =
                        (noteData['dateTime'] as Timestamp).toDate();

                    return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        title: Text(task , style: const TextStyle(fontSize:21 ),),
                        subtitle: Text(
                          '${dateTime.toLocal()}',
                          style: const TextStyle(fontSize: 18.0 ,),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit , color: Colors.blue , size: 25,),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotesAddScreen(
                                      noteId: noteId,
                                      noteData: noteData,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete ,  color: Colors.black , size: 25,),
                              onPressed: () => _deletetask(context , noteId),
                            ),
                          ],
                        ),
                    );
                  },
                );
              },
            )
          : const Center(child: Text('Please log in to see your record')),
    );
  }
}
