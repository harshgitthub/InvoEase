// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<User?> createUserWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       return cred.user;
//     } catch (e) {
//       if (kDebugMode) {
//         print("Something went wrong: $e");
//       }
//       return null;
//     }
//   }

//   Future<User?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return cred.user;
//     } catch (e) {
//       if (kDebugMode) {
//         print("Something went wrong: $e");
//       }
//       return null;
//     }
//   }

//   void checkCurrentUserAndReload(Function reload) {
//     User? currentUser = _auth.currentUser;
//     if (currentUser != null) {
//       reload();
//     }
//   }


// //  Future<void> addUserProfile(String name, String email ,String password) async {
// //     try {
// //       User? currentUser = _auth.currentUser;
// //       if (currentUser != null) {
// //         await _firestore.collection('USERS').doc(currentUser.uid).collection('profiles').add({
// //           'name': name,
// //           'email': email,
// //           'password':password,
// //         });
// //       }
// //     } catch (e) {
// //       print("Error adding user profile: $e");
// //     }
// //   }


// Future<void> addUserProfile(String name, String email, String password) async {
//   try {
//     User? currentUser = _auth.currentUser;
//     if (currentUser != null) {
//       await _firestore.collection('USERS').doc(currentUser.uid).collection('profiles').add({
//         'name': name,
//         'email': email,
//         'password': password,
//       });
//     }
//   } catch (e) {
//     print("Error adding user profile: $e");
//   }
// }


//   // Future<List<Map<String, dynamic>>> fetchUserProfiles() async {
//   //   try {
//   //     User? currentUser = _auth.currentUser;
//   //     List<Map<String, dynamic>> profiles = [];

//   //     if (currentUser != null) {
//   //       QuerySnapshot profilesSnapshot = await _firestore.collection('USERS').doc(currentUser.uid).collection('profiles').get();
//   //       profiles = profilesSnapshot.docs.map((doc) => {
//   //         'id': doc.id,
//   //         ...doc.data() as Map<String, dynamic>,
//   //       }).toList();
//   //     }

//   //     return profiles;
//   //   } catch (e) {
//   //     print("Error fetching user profiles: $e");
//   //     return [];
//   //   }
//   // }
// Future<void> _fetchUserData() async {
//   try {
//     User? currentUser = await _auth.fetchCurrentUser();
//     List<Map<String, dynamic>> linkedAccounts = await _auth.fetchLinkedAccounts(currentUser?.uid ?? '');

//     setState(() {
//       _currentUser = currentUser != null ? {
//         'uid': currentUser.uid,
//         'email': currentUser.email,
//         // Add other user-related data as needed
//       } : null;
//       _linkedAccounts = linkedAccounts;
//     });
//   } catch (e) {
//     print('Error fetching user data: $e');
//     // Handle error as needed
//   }
// }


//   // Future<void> linkEmailAndPassword(String email, String password) async {
//   //   try {
//   //     User? user = _auth.currentUser;
//   //     if (user != null) {
//   //       AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
//   //       await user.linkWithCredential(credential);
//   //     } else {
//   //       print("No user is currently signed in.");
//   //     }
//   //   } catch (e) {
//   //     print("Error linking credentials: $e");
//   //   }
//   // }

// Future<User?> fetchCurrentUser() async {
//     try {
//       return _auth.currentUser;
//     } catch (e) {
//       print("Error fetching current user: $e");
//       return null;
//     }
//   }

//   Future<void> linkEmailAndPassword(String email, String password) async {
//   try {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
//       await user.linkWithCredential(credential);
//     } else {
//       print("No user is currently signed in.");
//     }
//   } catch (e) {
//     print("Error linking credentials: $e");
//   }
// }


// Future<List<Map<String, dynamic>>> fetchLinkedAccounts() async {
//     try {
//       User? currentUser = _auth.currentUser;
//       List<Map<String, dynamic>> linkedAccounts = [];

//       if (currentUser != null) {
//         QuerySnapshot linkedAccountsSnapshot = await _firestore
//             .collection('users')
//             .doc(currentUser.uid)
//             .collection('linked_accounts')
//             .get();

//         linkedAccounts = linkedAccountsSnapshot.docs.map((doc) => {
//           'id': doc.id,
//           ...doc.data() as Map<String, dynamic>,
//         }).toList();
//       }

//       return linkedAccounts;
//     } catch (e) {
//       print("Error fetching linked accounts: $e");
//       return [];
//     }
//   }

// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to create a new user with email and password
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      if (kDebugMode) {
        print("Error creating user: $e");
      }
      return null;
    }
  }

  // Method to sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in: $e");
      }
      return null;
    }
  }

  // Method to fetch the current authenticated user
   Future<Map<String, dynamic>?> fetchCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Convert User object to a Map<String, dynamic>
        Map<String, dynamic> userData = {
          'uid': user.uid,
          'email': user.email,
          // Add other user-related data as needed
        };
        return userData;
      } else {
        return null; // Return null if no user is signed in
      }
    } catch (e) {
      print("Error fetching current user: $e");
      return null;
    }
  }

  // Method to link email and password to current user
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

  // Method to fetch linked accounts from Firestore
 Future<List<Map<String, dynamic>>> fetchLinkedAccounts() async {
  try {
    User? currentUser = _auth.currentUser;
    List<Map<String, dynamic>> linkedAccounts = [];

    if (currentUser != null) {
      QuerySnapshot linkedAccountsSnapshot = await _firestore
          .collection('USERS')
          .doc(currentUser.uid)
          .collection('profiles')
          .get();

      linkedAccounts = linkedAccountsSnapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      }).toList();
    }

    return linkedAccounts;
  } catch (e) {
    print("Error fetching linked accounts: $e");
    return [];
  }
}


  // Method to add a user profile to Firestore
  Future<void> addUserProfile(String name, String email, String password) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('USERS').doc(currentUser.uid).collection('profiles').add({
          'name': name,
          'email': email,
          'password': password,
        });
      }
    } catch (e) {
      print("Error adding user profile: $e");
    }
  }

  // Utility method to check current user and execute a function
  void checkCurrentUserAndReload(Function reload) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      reload();
    }
  }

  Future<void> sendEmailverificationLink() async{
    try{
      await _auth.currentUser?.sendEmailVerification();
    }
  catch(e){
    print(e.toString());
  }
  }
}
