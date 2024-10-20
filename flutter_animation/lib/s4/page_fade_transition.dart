import 'package:flutter/material.dart';
import 'package:flutter_animation/s4/second_page.dart';

class PageFadeTransition extends PageRouteBuilder {
  final dynamic page;

  PageFadeTransition(this.page) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child
      );
    }
  );
}

class PageFadeTransitionScreen extends StatelessWidget {
  const PageFadeTransitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page Transition"),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).push(
              PageFadeTransition(const SecondPageScreen())
            );
          },
          child: const Text("Go Back"),
        ),
      ),
    );
  }
}
