import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SetupPatternScreen extends StatefulWidget {
  const SetupPatternScreen({super.key});

  @override
  _SetupPatternScreenState createState() => _SetupPatternScreenState();
}

class _SetupPatternScreenState extends State<SetupPatternScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> _savePattern() async {
    // This should be replaced with actual pattern input and storage
    await _secureStorage.write(key: 'lockType', value: 'Pattern');
    await _secureStorage.write(key: 'lockValue', value: 'dummy_pattern');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Pattern'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _savePattern,
          child: const Text('Save Pattern (Dummy)'),
        ),
      ),
    );
  }
}
