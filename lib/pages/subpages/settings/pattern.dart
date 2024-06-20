// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SetupPatternScreen extends StatefulWidget {
//   const SetupPatternScreen({super.key});

//   @override
//   _SetupPatternScreenState createState() => _SetupPatternScreenState();
// }

// class _SetupPatternScreenState extends State<SetupPatternScreen> {
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   Future<void> _savePattern() async {
//     // This should be replaced with actual pattern input and storage
//     await _secureStorage.write(key: 'lockType', value: 'Pattern');
//     await _secureStorage.write(key: 'lockValue', value: 'dummy_pattern');
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Setup Pattern'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _savePattern,
//           child: const Text('Save Pattern (Dummy)'),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Custom Animated Loader')),
        body: Center(
          child: CustomLoader(),
        ),
      ),
    );
  }
}

class CustomLoader extends StatefulWidget {
  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 6.3, // 2 * pi (approximately)
          child: child,
        );
      },
      child: Icon(
        Icons.refresh,
        size: 50,
        color: Colors.blue,
      ),
    );
  }
}
