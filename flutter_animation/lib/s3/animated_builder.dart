import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class AnimatedBuilderScreen extends StatefulWidget {
  const AnimatedBuilderScreen({super.key});

  @override
  State<AnimatedBuilderScreen> createState() => _AnimatedBuilderScreenState();
}

class _AnimatedBuilderScreenState extends State<AnimatedBuilderScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2)
    )..repeat(reverse: true);
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
          // Listenable 타입의 객체로 ChangeNotifier 같은 역할을 한다.
          animation: _controller,
          builder: (context, child) {
            // _controller.value는 0.0 ~ 1.0 까지 제공된 duration 동안 변경된다

            // flip
            return Transform.flip(
              // filpX/Y이 bool 값에 따라서 뒤집힘
              flipX: _controller.value > 0.5,
              flipY: _controller.value < 0.3 || _controller.value < 0.8,
              child: Container(
                width: 250,
                height: 250,
                color: Colors.transparent,
                child: Image.asset(CHEESE),
              ),
            );

            // translate
            return Transform.translate(
              // 화면의 중앙을 기점으로 (0.0)으로 시작해서 움직임
              // 이미지도 중앙이 기점임
              offset: Offset(_controller.value * 200, _controller.value * 100),
              child: Container(
                width: 250,
                height: 250,
                color: Colors.transparent,
                child: Image.asset(CHEESE),
              ),
            );

            // scale
            return Transform.scale(
              // scale 값에 들어가는 실수만큼 배율이 됨
              // scaleX / scaleY로 해당 축만 키울 수 있음
              scaleX: 2 * _controller.value,
              child: Container(
                width: 250,
                height: 250,
                color: Colors.transparent,
                child: Image.asset(CHEESE),
              ),
            );

            // rotate
            return Transform.rotate(
              // 2pi 가 1바퀴
              angle: 2 * pi * _controller.value,
              child: Container(
                width: 250,
                height: 250,
                color: Colors.transparent,
                child: Image.asset(CHEESE),
              ),
            );
          },
        ),
      ),
    );
  }
}
