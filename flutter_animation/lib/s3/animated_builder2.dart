import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class AnimatedBuilder2Screen extends StatefulWidget {
  const AnimatedBuilder2Screen({super.key});

  @override
  State<AnimatedBuilder2Screen> createState() => _AnimatedBuilder2ScreenState();
}

class _AnimatedBuilder2ScreenState extends State<AnimatedBuilder2Screen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation _color;

  int value = 1;
  double wh = 200;
  Color color = Colors.yellow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3)
    )..repeat();
    _animation = Tween<double>(
      begin: 10,
      end: 300
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn)
    );
    _color = ColorTween(
      begin: Colors.yellowAccent,
      end: Colors.red
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn)
    );
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
        title: const Text("Positioned Transition Example"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: pi * 10 * _controller.value,
              // 변화하는 애니메이션 값을 주어서 실행시킴
              child: Container(
                height: _animation.value,
                width: _animation.value,
                color: _color.value,
              ),
            );
          },
        ),
      ),
    );
  }
}
