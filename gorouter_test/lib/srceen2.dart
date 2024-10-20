import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter_test/srceen1.dart';
import 'package:gorouter_test/srceen1_1_1.dart';

class Screen2 extends StatelessWidget {
  static const routeName = "/screen2";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen2!"),
      ),
      body: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {
              },
              child: const Text("go sub route")
            ),
            OutlinedButton(
                onPressed: () {
                  context.pushReplacement(
                      Screen1.routeName
                  );
                },
                child: const Text("pushReplacement to screen1")
            ),
            OutlinedButton(
                onPressed: () {
                  context.replace(Screen1.routeName);
                },
                child: const Text("replace screen1")
            ),
            OutlinedButton(
                onPressed: () {
                  context.pushNamed(Screen1_1_1.routeName);
                },
                child: const Text("push 1-1-1")
            ),
          ],
        ),
      ),
    );
  }
}