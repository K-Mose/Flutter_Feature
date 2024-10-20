import 'package:flutter/material.dart';

class SecondPageScreen extends StatelessWidget {
  const SecondPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Second Page"),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Go Back"),
        ),
      ),
    );
  }
}
