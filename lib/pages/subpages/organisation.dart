import 'package:cloneapp/pages/open.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteUser extends StatelessWidget {
  const DeleteUser({Key? key}) : super(key: key);

  Future<void> _deleteUserAccount(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Delete user document from Firestore and user from Firebase Authentication
        WriteBatch batch = FirebaseFirestore.instance.batch();
        DocumentReference userDoc = FirebaseFirestore.instance.collection('USERS').doc(user.uid);
        
        batch.delete(userDoc);

        await batch.commit();
        await user.delete();
 Navigator.push(context, MaterialPageRoute(builder: (context)=> const Open()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: const Text('User account deleted successfully')),
        );

        // Navigate to the open screen
       
      } else {
         Navigator.push(context, MaterialPageRoute(builder: (context)=> const Open()));
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('No user is currently logged in')),
        // );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You need to re-login before deleting your account')),
        );
        Navigator.pushNamed(context, '/login');
        // You can add logic here to prompt the user to re-authenticate
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting user account: ${e.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Open())); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteUserAccount(context); // Proceed with account deletion
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete User Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _showConfirmationDialog(context),
              child: const Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}
