import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/open.dart';
import 'package:cloneapp/pages/subpages/pdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final currentuser  = FirebaseAuth.instance.currentUser;

  String selectedEmoji = '';

  Future<void> signout() async {
  try {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    // Navigate to login screen or any other post-logout action
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Open()),
    );
  } catch (e) {
    // Handle sign-out errors
    print('Error signing out: $e');
    // Optionally, show an error message to the user
    // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign out')));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("Settings"),
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
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
      drawer: drawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Subheadings
            ListTile(
              leading: const Icon(Icons.rule),
              title: const Text('Organisation Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
             ListTile(
              leading: const Icon(Icons.my_library_add),
                title: const Text("Invoice Template"),
                onTap: (){
                    Navigator.pushNamed(context, '/invoicetemplate');
                },
              ),
            // ListTile(
            //   leading: const Icon(Icons.switch_access_shortcut),
            //   title: const Text('Switch Organisation'),
            //   onTap: () {
            //     // Add functionality for this list tile
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.person),
            //   title: const Text('Users'),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/delete');
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.room_preferences),
            //   title: const Text('Preferences'),
            //   onTap: () {
            //    Navigator.pushNamed(context, '/preference');
            //   },
            // ),
          // ListTile(
          //   leading: const Icon(Icons.security),
          //   title: const Text('Privacy & Security'),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/security');
          //   },
          // ),
          const Divider(),
        ListTile(
      leading: const Icon(Icons.feedback),
      title: const Text('Feedback'),
      onTap: _launchEmail,
    
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () async {
              await FlutterShare.share(
                title: 'Amazing Flutter App', 
                text: 'Check out this awesome app: https://example.com/app-link', // replace by Playstore link
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.rate_review),
            title: const Text('Rate App'),
            onTap: () {
             _showReviewDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
             Navigator.pushNamed(context, '');
            },
          ),
const Divider(),
         ListTile(
  contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
  leading: const Icon(Icons.delete_forever, color: Colors.red),
  title: const Text('Delete User', style: TextStyle(color: Colors.red)),
  subtitle: const Text('This action cannot be undone.All the user details would be completely deleted.'),
  trailing: const Icon(Icons.warning, color: Colors.red),
  onTap:   () => _showConfirmationDialog(context),
),
const SizedBox(height: 50,),

       
      ]),
    ));
  }
void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Do you really want to sign out?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              signout(); // Call your signout function here
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}


  void _showReviewDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Feedback'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Select an emoji:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.sentiment_very_satisfied),
                    onPressed: () {
                      setState(() {
                        selectedEmoji = '😊';
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.sentiment_satisfied),
                    onPressed: () {
                      setState(() {
                        selectedEmoji = '😄';
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.sentiment_neutral),
                    onPressed: () {
                      setState(() {
                        selectedEmoji = '😐';
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  // Handle the submission logic
                  Text('Selected Emoji: ${selectedEmoji}');
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }
 void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'harshchoprajpr@gmail.com',
      query: 'subject=Feedback&body=Your feedback here',
    );

    // Using launchUrl() to open mailto link
    try {
      if (!await launchUrl(emailLaunchUri)) {
        _showErrorDialog('Could not launch email app.');
      }
    } catch (e) {
      _showErrorDialog('Error: $e');
    }
  }

  void _showErrorDialog(String message) {
    // Implement a way to show the error message in the UI, for example:
    print(message); // You can replace this with a more appropriate UI response
  }
}
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User account deleted successfully')),
      );

      // Navigate to the Open screen after successful deletion
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Open()),
        (Route<dynamic> route) => false,
      );
    } else {
      // Navigate to the Open screen if no user is logged in
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Open()),
        (Route<dynamic> route) => false,
      );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You need to re-login before deleting your account')),
      );
      Navigator.pushNamed(context, '/login');
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
              Navigator.of(context).pop(); // Close the dialog
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

 
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: [
        //       _buildSettingItem(
        //         icon: Icons.,
        //         title: 'Themes',
        //         onTap: () {
        //           // Handle theme selection
        //         },
        //       ),
        //       _buildSettingItem(
        //         icon: Icons.notifications,
        //         title: 'Notifications',
        //         onTap: () {
        //           // Handle notifications setting
        //         },
        //       ),
        //       _buildSettingItem(
        //         icon: Icons.help_outline,
        //         title: 'Help & FAQ',
        //         onTap: () {
        //           // Handle help & faq
        //         },
        //       ),
        //       _buildSettingItem(
        //         icon: Icons.contact_mail,
        //         title: 'Contact Us',
        //         onTap: () {
        //           // Handle contact us
        //         },
        //       ),
        //       _buildSettingItem(
        //         icon: Icons.star,
        //         title: 'Rate us on Google Play',
        //         onTap: () {
        //           // Handle rating on Google Play
        //         },
        //       ),
        //       _buildSettingItem(
        //         icon: Icons.privacy_tip,
        //         title: 'Terms and Privacy',
        //         onTap: () {
        //           // Handle terms and privacy
        //         },
        //       ),
        //     ],
        //   ),
        // ),
