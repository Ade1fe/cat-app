import 'package:flutter/material.dart';

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Another Screen")),
      body: Row(
        children: [
          Container(
            height: 100,
            color: Colors.red[600],
            child: const Text('one'),
          ),
          Container(
            height: 200,
            color: Colors.blue[600],
            child: const Text('two'),
          ),
          Container(
            height: 300,
            color: Colors.green[600],
            child: const Text('three'),
          ),
        ],
      ),
    );
  }
}
