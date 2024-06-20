import 'package:cloneapp/pages/auth_service.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _currentUser;
  List<Map<String, dynamic>> _linkedAccounts = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      Map<String, dynamic>? currentUser = await _authService.fetchCurrentUser();
      List<Map<String, dynamic>> linkedAccounts = await _authService.fetchLinkedAccounts();

      setState(() {
        _currentUser = currentUser;
        _linkedAccounts = linkedAccounts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching user data: $e';
      });
    }
  }

  void _selectProfile(Map<String, dynamic> profile) {
    Navigator.pushNamed(context, "/home", arguments: profile);
  }

  void _navigateToLinkAccountScreen() {
    Navigator.pushNamed(context, "/link_account").then((_) {
      _fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Switch User"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_currentUser != null) ...[
                        ListTile(
                          title: Text(_currentUser!['email'] ?? 'No Email'),
                          subtitle: Text(_currentUser!['name'] ?? 'No Name'),
                          onTap: () => _selectProfile(_currentUser!),
                        ),
                        Divider(),
                      ],
                      if (_linkedAccounts.isNotEmpty) ...[
                        Text('Linked Accounts:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ..._linkedAccounts.map((account) => Column(
                              children: [
                                ListTile(
                                  title: Text(account['email'] ?? 'No Email'),
                                  subtitle: Text(account['name'] ?? 'No Name'),
                                  onTap: () => _selectProfile(account),
                                ),
                                if (account != _linkedAccounts.last) Divider(),
                              ],
                            )),
                      ],
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToLinkAccountScreen,
        child: Icon(Icons.add),
      ),
    );
  }
}
