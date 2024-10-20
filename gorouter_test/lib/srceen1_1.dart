import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter_test/main.dart';
import 'package:gorouter_test/srceen1_1_1.dart';

class Screen1_1 extends StatelessWidget {
  static const routeName = "screen1-1";
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    print("Screen1-1:: ${router.namedLocation(routeName)}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
            // Navigator.of(context).pop();
            // context.push("/");
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text("Screen 1-1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  context.go(Screen1_1_1.routeName);
                },
                child: const Text("go sub route")
            ),
            OutlinedButton(
                onPressed: () {
                  context.pushNamed(Screen1_1_1.routeName);
                },
                child: const Text("push sub route")
            ),
            OutlinedButton(
              onPressed: () {
                context.go(MyHomePage.routeName);
              },
              child: const Text("go to Main using go")
            ),
          ],
        ),
      ),
    );
  }
}