import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SetupPinScreen extends StatefulWidget {
  const SetupPinScreen({super.key});

  @override
  _SetupPinScreenState createState() => _SetupPinScreenState();
}

class _SetupPinScreenState extends State<SetupPinScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final TextEditingController _pinController = TextEditingController();

  Future<void> _savePin() async {
    await _secureStorage.write(key: 'lockType', value: 'PIN');
    await _secureStorage.write(key: 'lockValue', value: _pinController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup PIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pinController,
              decoration: const InputDecoration(
                labelText: 'Enter PIN',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePin,
              child: const Text('Save PIN'),
            ),
          ],
        ),
      ),
    );
  }
}
