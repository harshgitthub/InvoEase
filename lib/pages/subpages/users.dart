import 'package:cloneapp/pages/auth_service.dart';
import 'package:flutter/material.dart';
class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final AuthService _auth = AuthService();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  List<Map<String, dynamic>> _profiles = [];
  Map<String, dynamic>? _selectedProfile;

  @override
  void initState() {
    super.initState();
    _fetchProfiles();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _fetchProfiles() async {
    List<Map<String, dynamic>> profiles = await _auth.fetchUserProfiles();
    setState(() {
      _profiles = profiles;
    });
  }

  Future<void> _linkAccount() async {
    String email = _email.text.trim();
    String password = _password.text.trim();

    if (email.isEmpty || password.isEmpty) {
      print("Email and password fields cannot be empty");
      return;
    }

    await _auth.linkEmailAndPassword(email, password);
    print("New credentials linked to the current user.");
    _fetchProfiles(); // Refresh profiles
    Navigator.pushNamed(context, "/invoice");
  }

  void _selectProfile(Map<String, dynamic> profile) {
    setState(() {
      _selectedProfile = profile;
    });
    // Perform navigation or other actions based on the selected profile
    Navigator.pushNamed(context, "/invoice", arguments: _selectedProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User Profiles"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: _linkAccount,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: const Text(
                'Link Account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _profiles.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> profile = _profiles[index];
                  String name = profile['name'] ?? 'No Name';
                  String email = profile['email'] ?? 'No Email';

                  return ListTile(
                    title: Text(name),
                    subtitle: Text(email),
                    onTap: () => _selectProfile(profile),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}