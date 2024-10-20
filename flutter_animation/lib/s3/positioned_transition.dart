import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class PositionedTransitionScreen extends StatefulWidget {
  const PositionedTransitionScreen({super.key});

  @override
  State<PositionedTransitionScreen> createState() => _PositionedTransitionScreenState();
}

class _PositionedTransitionScreenState
    extends State<PositionedTransitionScreen>
    // controller를 하나만 사용하기 때문에 SingleTickerProvider 사용
    with SingleTickerProviderStateMixin {

  // 1. animation controller, animation 등록
  late AnimationController _controller;
  // 하나의 컨트롤러에 3개 애니메이션 등록
  late Animation<RelativeRect> _jerryAnimation;
  late Animation<RelativeRect> _tomAnimation;
  late Animation<RelativeRect> _spikeAnimation;

  // 2. initialize controller / animation
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _jerryAnimation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(250.0, 250.0, 0.0, 0.0),
    ).animate(_controller);
    _tomAnimation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(150.0, 150.0, 0.0, 0.0),
    ).animate(_controller);
    _spikeAnimation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(50.0, 50.0, 0.0, 0.0),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Positioned Transition Example"),
      ),
      body: Stack(
        children: [
          PositionedTransition(
            // rect: RelativeRect Animation
            rect: _spikeAnimation,
            // child Widget
            child: Container(
              color: Colors.blueGrey,
              width: 100,
              height: 100,
              child: Image.asset(DOG),
            )
          ),
          PositionedTransition(
            rect: _tomAnimation,
            child: Container(
              color: Colors.grey,
              width: 100,
              height: 100,
              child: Image.asset(TOM),
            )
          ),
          PositionedTransition(
            rect: _jerryAnimation,
            child: Container(
              color: Colors.orange,
              width: 100,
              height: 100,
              child: Image.asset(JERRY),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _startAnimation,
                  child: const Icon(Icons.double_arrow_outlined)
                ),
                ElevatedButton(
                  onPressed: _reversAnimation,
                  child: const Icon(Icons.close)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _startAnimation() {
    // 애니애이션을 돌리기 전에 reset
    _controller.reset();
    _controller.forward();
  }

  void _reversAnimation() {
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
