// import 'package:cloneapp/pages/home.dart';
// import 'package:cloneapp/pages/subpages/addnotes.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Notes extends StatefulWidget {
//   const Notes({super.key});

//   @override
//   State<Notes> createState() => _NotesState();
// }

// class _NotesState extends State<Notes> {
//   Future<void> _deleteNote(String noteId) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       try {
//         await FirebaseFirestore.instance
//             .collection('USERS')
//             .doc(user.uid)
//             .collection('notes')
//             .doc(noteId)
//             .delete();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Note deleted successfully!')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to delete note')),
//         );
//       }
//     }
//   }

//   void _confirmDelete(String noteId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Delete'),
//           content: const Text('Are you sure you want to delete this note?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _deleteNote(noteId);
//               },
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Notes"),
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
//           IconButton(onPressed: (){
//             Navigator.pushNamed(context, '/notesadd');
//           }, icon: const Icon(Icons.add , size: 30,)
//           ),
//           IconButton(onPressed: (){
//             Navigator.pushNamed(context, '/customer');
//           }, icon: const Icon(Icons.person_add , size: 30,)
//           ),
//         ],
//       ),
//       drawer: drawer(context),
//       body: user != null
//           ? StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('USERS')
//                   .doc(user.uid)
//                   .collection('notes')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(child: Text('No record found'));
//                 }

//                 final notes = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: notes.length,
//                   itemBuilder: (context, index) {
//                     final note = notes[index];
//                     final noteData = note.data() as Map<String, dynamic>;
//                     final noteId = note.id;
//                     final task = noteData['task'] ?? 'No task description';

//                     return  ListTile(
//                         contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//                         title: Text(task, style: const TextStyle(fontSize: 21)),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.edit, color: Colors.blue, size: 25),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => NotesAddScreen(
//                                       noteId: noteId,
//                                       noteData: noteData,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.black, size: 25),
//                               onPressed: () {
//                                 _confirmDelete(noteId);
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                   },
//                 );
//               },
//             )
//           : const Center(child: Text('Please log in to see your record')),
//     );
//   }
// }


// import 'package:cloneapp/pages/home.dart';
// import 'package:cloneapp/pages/subpages/addnotes.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Notes extends StatefulWidget {
//   const Notes({super.key});

//   @override
//   State<Notes> createState() => _NotesState();
// }

// class _NotesState extends State<Notes> {
//   Future<void> _deleteNote(String noteId) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       try {
//         await FirebaseFirestore.instance
//             .collection('USERS')
//             .doc(user.uid)
//             .collection('notes')
//             .doc(noteId)
//             .delete();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Note deleted successfully!')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to delete note')),
//         );
//       }
//     }
//   }

//   void _confirmDelete(String noteId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Delete'),
//           content: Text('Are you sure you want to delete this note?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _deleteNote(noteId);
//               },
//               child: Text('Delete', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     final customTheme = ThemeData(
//       primarySwatch: Colors.blue,
      
//       appBarTheme: AppBarTheme(
//         color: Colors.blue,
//         titleTextStyle: TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: Colors.orange,
//         textTheme: ButtonTextTheme.primary,
//       ),
//       // textTheme: TextTheme(
//       //   bodyText1: TextStyle(fontSize: 18, color: Colors.black),
//       //   bodyText2: TextStyle(fontSize: 16, color: Colors.black54),
//       //   headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
//       // ),
//       iconTheme: IconThemeData(
//         color: Colors.blue,
//         size: 30,
//       ),
//       snackBarTheme: SnackBarThemeData(
//         backgroundColor: Colors.blue,
//         contentTextStyle: TextStyle(color: Colors.white),
//       ),
//     );

//     return Theme(
//       data: customTheme,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Notes"),
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: Icon(Icons.menu),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//                 tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//               );
//             },
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/notesadd');
//               },
//               icon: Icon(Icons.add),
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/customer');
//               },
//               icon: Icon(Icons.person_add),
//             ),
//           ],
//         ),
//         drawer: drawer(context),
//         body: user != null
//             ? StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('USERS')
//                     .doc(user.uid)
//                     .collection('notes')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return Center(child: Text('No record found'));
//                   }

//                   final notes = snapshot.data!.docs;

//                   return ListView.builder(
//                     itemCount: notes.length,
//                     itemBuilder: (context, index) {
//                       final note = notes[index];
//                       final noteData = note.data() as Map<String, dynamic>;
//                       final noteId = note.id;
//                       final task = noteData['task'] ?? 'No task description';

                      // return Dismissible(
                      //   key: Key(noteId),
                      //   background: Container(
                      //     color: Colors.red,
                      //     alignment: Alignment.centerLeft,
                      //     padding: const EdgeInsets.only(left: 20.0),
                      //     child: Icon(Icons.delete, color: Colors.white),
                      //   ),
                      //   direction: DismissDirection.startToEnd,
                      //   onDismissed: (direction) {
                      //     _deleteNote(noteId);
                      //   },
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//                           title: Text(task),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => NotesAddScreen(
//                                         noteId: noteId,
//                                         noteData: noteData,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () {
//                                   _confirmDelete(noteId);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               )
//             : Center(child: Text('Please log in to see your record')),
//       ),
//     );
//   }
// }

import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/subpages/addnotes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  Future<void> _deleteNote(String noteId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('USERS')
            .doc(user.uid)
            .collection('notes')
            .doc(noteId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Note deleted successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete note')),
        );
      }
    }
  }

  void _confirmDelete(String noteId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Theme.of(context).focusColor)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteNote(noteId);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final customTheme = ThemeData(
      primarySwatch: Colors.blue,
      focusColor: Colors.orange,
     
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.orange,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      iconTheme: IconThemeData(
        color: Colors.blue,
        size: 30,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.blue,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
    );

    return Theme(
      data: customTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notes"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notesadd');
              },
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/customer');
              },
              icon: Icon(Icons.person_add),
            ),
          ],
        ),
        drawer: drawer(context),
        body: user != null
            ? StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('USERS')
                    .doc(user.uid)
                    .collection('notes')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No record found'));
                  }

                  final notes = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      final noteData = note.data() as Map<String, dynamic>;
                      final noteId = note.id;
                      final task = noteData['task'] ?? 'No task description';
return Dismissible(
                        key: Key(noteId),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          _deleteNote(noteId);
                        },

                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                            title: Text(task, style: Theme.of(context).textTheme.bodyLarge),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
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
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _confirmDelete(noteId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : Center(child: Text('Please log in to see your record')),
      ),
    );
  }
}
