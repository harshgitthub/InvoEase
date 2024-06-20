import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SetupPasswordScreen extends StatefulWidget {
  const SetupPasswordScreen({super.key});

  @override
  State<SetupPasswordScreen> createState() => _SetupPasswordScreenState();
}

class _SetupPasswordScreenState extends State<SetupPasswordScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final TextEditingController _passwordController = TextEditingController();

  Future<void> _savePassword() async {
    await _secureStorage.write(key: 'lockType', value: 'Password');
    await _secureStorage.write(key: 'lockValue', value: _passwordController.text);
    Navigator.pop(context);
  }

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Animated Loader')),
        body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.blue,
            size: 50,
          ),
        ),
      ),
    );
  }
}
