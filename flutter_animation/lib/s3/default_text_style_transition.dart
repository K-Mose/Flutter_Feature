import 'package:flutter/material.dart';

class DefaultTextStyleTransitionScreen extends StatefulWidget {
  const DefaultTextStyleTransitionScreen({Key? key}) : super(key: key);

  @override
  State<DefaultTextStyleTransitionScreen> createState() => _DefaultTextStyleTransitionScreenState();
}

class _DefaultTextStyleTransitionScreenState extends State<DefaultTextStyleTransitionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<TextStyle> _animation;

  TextStyle style1 = const TextStyle(
    fontSize: 22.0,
    color: Colors.red,
    fontWeight: FontWeight.w700
  );

  TextStyle style2 = const TextStyle(
    fontSize: 52.0,
    color: Colors.blue,
    fontWeight: FontWeight.w200
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2)
    )..repeat(reverse: true);
    _animation = TextStyleTween(begin: style1, end: style2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Default Text Style Transition Example"),
      ),
      body: Center(
        child: DefaultTextStyleTransition(
          style: _animation,
          child: const Text("Changing Default Text Style"),
        ),
      ),
    );
  }
}
