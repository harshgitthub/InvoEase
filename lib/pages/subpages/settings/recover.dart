import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  _RecoverPasswordScreenState createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final TextEditingController _securityAnswerController = TextEditingController();
  String? _storedSecurityQuestion;

  @override
  void initState() {
    super.initState();
    _loadSecurityQuestion();
  }

  Future<void> _loadSecurityQuestion() async {
    String? question = await _secureStorage.read(key: 'securityQuestion');
    setState(() {
      _storedSecurityQuestion = question;
    });
  }

  Future<void> _verifySecurityAnswer() async {
    String? storedAnswer = await _secureStorage.read(key: 'securityAnswer');
    if (_securityAnswerController.text == storedAnswer) {
      await _secureStorage.delete(key: 'lockType');
      await _secureStorage.delete(key: 'lockValue');
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect security answer')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recover Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _storedSecurityQuestion ?? 'No security question set',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _securityAnswerController,
              decoration: const InputDecoration(
                labelText: 'Enter your answer',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifySecurityAnswer,
              child: const Text('Verify Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
