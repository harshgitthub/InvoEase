import 'package:cloneapp/pages/subpages/settings/password.dart';
import 'package:cloneapp/pages/subpages/settings/pattern.dart';
import 'package:cloneapp/pages/subpages/settings/pin.dart';
import 'package:cloneapp/pages/subpages/settings/recover.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MaterialApp(
    home: Applock(),
  ));
}

class Applock extends StatefulWidget {
  const Applock({super.key});

  @override
  _ApplockState createState() => _ApplockState();
}

class _ApplockState extends State<Applock> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String? _selectedLockType;
  bool _isLockEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkLockStatus();
  }

  Future<void> _checkLockStatus() async {
    String? lockType = await _secureStorage.read(key: 'lockType');
    setState(() {
      _selectedLockType = lockType;
      _isLockEnabled = lockType != null;
    });
  }

  Future<void> _enableFingerprint() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to enable fingerprint lock',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      // Handle authentication errors here
    }

    if (isAuthenticated) {
      await _secureStorage.write(key: 'lockType', value: 'Fingerprint');
      setState(() {
        _selectedLockType = 'Fingerprint';
        _isLockEnabled = true;
      });
    }
  }

  void _enablePIN() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SetupPinScreen()),
    ).then((value) => _checkLockStatus());
  }

  void _enablePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SetupPasswordScreen()),
    ).then((value) => _checkLockStatus());
  }

  void _enablePattern() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SetupPatternScreen()),
    ).then((value) => _checkLockStatus());
  }

  void _disableLock() async {
    await _secureStorage.delete(key: 'lockType');
    await _secureStorage.delete(key: 'lockValue');
    setState(() {
      _selectedLockType = null;
      _isLockEnabled = false;
    });
  }

  void _forgetLock() {
    _disableLock();
  }

  void _recoverPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RecoverPasswordScreen()),
    ).then((value) => _checkLockStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Lock'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Fingerprint'),
            trailing: _isLockEnabled && _selectedLockType == 'Fingerprint'
                ? const Icon(Icons.check)
                : null,
            onTap: _enableFingerprint,
          ),
          ListTile(
            title: const Text('PIN'),
            trailing: _isLockEnabled && _selectedLockType == 'PIN'
                ? const Icon(Icons.check)
                : null,
            onTap: _enablePIN,
          ),
          ListTile(
            title: const Text('Password'),
            trailing: _isLockEnabled && _selectedLockType == 'Password'
                ? const Icon(Icons.check)
                : null,
            onTap: _enablePassword,
          ),
          ListTile(
            title: const Text('Pattern'),
            trailing: _isLockEnabled && _selectedLockType == 'Pattern'
                ? const Icon(Icons.check)
                : null,
            onTap: _enablePattern,
          ),
          const Divider(),
          ListTile(
            title: const Text('Forget Lock'),
            onTap: _isLockEnabled ? _forgetLock : null,
          ),
          ListTile(
            title: const Text('Disable Lock'),
            onTap: _isLockEnabled ? _disableLock : null,
          ),
          ListTile(
            title: const Text('Recover Password'),
            onTap: _recoverPassword,
          ),
        ],
      ),
    );
  }
}
