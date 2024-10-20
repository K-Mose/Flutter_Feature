import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter_test/srceen1_1.dart';
import 'package:gorouter_test/srceen2.dart';

class Screen1 extends StatelessWidget {
  static const routeName = "/screen1";
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    print("Screen1:: ${router.namedLocation(routeName)}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop();
            context.pop();
            // context.go("/");
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text("Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                context.go(Screen1_1.routeName);
              },
              child: const Text("go sub route")
            ),
            OutlinedButton(
              onPressed: () {
                context.pushNamed(Screen1_1.routeName);
              },
              child: const Text("push sub route")
            ),
            OutlinedButton(
                onPressed: () {
                  context.push(
                      Screen2.routeName
                  );
                },
                child: const Text("push screen2")
            ),
            OutlinedButton(
              onPressed: () {
                context.pushReplacement(
                  Screen2.routeName
                );
              },
              child: const Text("go sub route With pushReplacement to home")
            ),
            OutlinedButton(
              onPressed: () {
                context.replace(Screen2.routeName);
              },
              child: const Text("replace screen2")
            )
          ],
        ),
      ),
    );
  }
}