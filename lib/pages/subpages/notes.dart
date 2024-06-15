import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/subpages/addnotes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key});

  Future<void> _deleteNote(String noteId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('USERS')
          .doc(user.uid)
          .collection('notes')
          .doc(noteId)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Notes"),
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
            icon: const Icon(Icons.filter),
            onPressed: () {
              // Implement filter functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/notesadd');
        },
        child: const Icon(Icons.add),
      ),
      body: user != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('USERS')
                  .doc(user.uid)
                  .collection('notes')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No notes found.'));
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

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        title: Text(task),
                        subtitle: Text(
                          'Date: ${dateTime.toLocal()}',
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
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
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteNote(noteId),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(child: Text('Please log in to see your notes')),
    );
  }
}
