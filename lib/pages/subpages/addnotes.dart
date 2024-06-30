import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// class NotesAddScreen extends StatefulWidget {
//   final String? noteId;
//   final Map<String, dynamic>? noteData;

//   const NotesAddScreen({super.key, this.noteId, this.noteData});

//   @override
//   _NotesAddScreenState createState() => _NotesAddScreenState();
// }

// class _NotesAddScreenState extends State<NotesAddScreen> {
//   final TextEditingController _noteController = TextEditingController();
  

//   @override
//   void initState() {
//     super.initState();
//     if (widget.noteData != null) {
//       // If editing existing note, pre-fill data
//       _noteController.text = widget.noteData!['task'];
      
//     }
//   }
//   Future<void> _saveTask() async {
//     // if (_taskController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
//      if (_noteController.text.isNotEmpty ){
//       User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         final String note = _noteController.text;
        

//         try {
//           if (widget.noteId != null) {
//             // Update existing note
//             await FirebaseFirestore.instance
//                 .collection('USERS')
//                 .doc(user.uid)
//                 .collection('notes')
//                 .doc(widget.noteId)
//                 .update({
//               'note': note,
//               // 'dateTime': dateTime,
//             });
//           } else {
//             // Add new note
//             await FirebaseFirestore.instance
//                 .collection('USERS')
//                 .doc(user.uid)
//                 .collection('notes')
//                 .add({
//               'note': note,
//               // 'dateTime': dateTime,
//             });
//           }
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Note ${widget.noteId != null ? 'updated' : 'saved'} successfully!')),
//           );
//           Navigator.of(context).pop(); // Return to previous screen
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to ${widget.noteId != null ? 'update' : 'save'} task')),
//           );
//         }
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter all details')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.noteId != null ? 'Edit note' : 'Add note'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextField(
//               controller: _noteController,
//               decoration: const InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//               ),
//             ),
            
//             const SizedBox(height: 32.0),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _saveTask,
//                 child: Text(widget.noteId != null ? 'Update note' : 'Save note'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class NotesAddScreen extends StatefulWidget {
  final String? noteId;
  final Map<String, dynamic>? noteData;

  const NotesAddScreen({super.key, this.noteId, this.noteData});

  @override
  _NotesAddScreenState createState() => _NotesAddScreenState();
}

class _NotesAddScreenState extends State<NotesAddScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.noteData != null && widget.noteData!['task'] != null) {
      // If editing existing note, pre-fill data
      _noteController.text = widget.noteData!['task'];
    }
  }

  Future<void> _saveTask() async {
    if (_noteController.text.isNotEmpty) {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final String note = _noteController.text;

        try {
          if (widget.noteId != null) {
            // Update existing note
            await FirebaseFirestore.instance
                .collection('USERS')
                .doc(user.uid)
                .collection('notes')
                .doc(widget.noteId)
                .update({
              'task': note,
            });
          } else {
            // Add new note
            await FirebaseFirestore.instance
                .collection('USERS')
                .doc(user.uid)
                .collection('notes')
                .add({
              'task': note,
            });
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Note ${widget.noteId != null ? 'updated' : 'saved'} successfully!')),
          );
          Navigator.of(context).pop(); // Return to previous screen
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to ${widget.noteId != null ? 'update' : 'save'} task')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteId != null ? 'Edit note' : 'Add note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: _saveTask,
                child: Text(widget.noteId != null ? 'Update note' : 'Save note'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
