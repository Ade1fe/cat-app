import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Coffe App"),
          // backgroundColor: Colors.brown[300],
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.brown[300],
              child: const Text('i love my coffe brown'),
            ),
            Container(
              color: Colors.green[700],
              padding: const EdgeInsets.all(16),
              child: const Text('Coffee prefs'),
            )
          ],
        ));
  }
}
