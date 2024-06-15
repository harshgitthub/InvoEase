import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      if (kDebugMode) {
        print("Something went wrong: $e");
      }
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      if (kDebugMode) {
        print("Something went wrong: $e");
      }
      return null;
    }
  }

  void checkCurrentUserAndReload(Function reload) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      reload();
    }
  }




  // Future<void> addUserProfile(String uid, String name, String email) async {
  //   try {
  //     await _firestore.collection('users').doc(uid).set({
  //       'name': name,
  //       'email': email,
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Something went wrong while adding user profile: $e");
  //     }
  //   }
  // }
 Future<void> addUserProfile(String name, String email ,String password) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('USERS').doc(currentUser.uid).collection('profiles').add({
          'name': name,
          'email': email,
          'password':password,
        });
      }
    } catch (e) {
      print("Error adding user profile: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserProfiles() async {
    try {
      User? currentUser = _auth.currentUser;
      List<Map<String, dynamic>> profiles = [];

      if (currentUser != null) {
        QuerySnapshot profilesSnapshot = await _firestore.collection('USERS').doc(currentUser.uid).collection('profiles').get();
        profiles = profilesSnapshot.docs.map((doc) => {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        }).toList();
      }

      return profiles;
    } catch (e) {
      print("Error fetching user profiles: $e");
      return [];
    }
  }

  Future<void> linkEmailAndPassword(String email, String password) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
        await user.linkWithCredential(credential);
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print("Error linking credentials: $e");
    }
  }
}