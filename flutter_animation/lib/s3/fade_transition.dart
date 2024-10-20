import 'package:flutter/material.dart';

class FadeTransitionScreen extends StatefulWidget {
  const FadeTransitionScreen({super.key});

  @override
  State<FadeTransitionScreen> createState() => _FadeTransitionScreenState();
}

class _FadeTransitionScreenState extends State<FadeTransitionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 1,
      end: 0
    ).animate(_controller);
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
        title: const Text("Fade Transition Example"),
      ),
      body: GestureDetector(
        onTap: () {
          if (!_controller.isAnimating) {
            _controller.status == AnimationStatus.dismissed
                ? _controller.forward()
                : _controller.reverse();
          }
        },
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Container(
              height: 250,
              width: 250,
              color: Colors.teal,
              alignment: Alignment.center,
              child: const Text(
                "Fade Transition",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
