import 'package:flutter/material.dart';

class PositionedDirectionalTransitionScreen extends StatefulWidget {
  const PositionedDirectionalTransitionScreen({super.key});

  @override
  State<PositionedDirectionalTransitionScreen> createState() =>
      _PositionedDirectionalTransitionScreenState();
}

class _PositionedDirectionalTransitionScreenState
    extends State<PositionedDirectionalTransitionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<RelativeRect> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2)
    );
    _animation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(250.0, 250.0, 0.0, 0.0),
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
        title: const Text("Positioned Directional Transition Example"),
      ),
      body: Stack(
        children: [
          // PositionTransition과 달리 animation을 받는 변수가 없기 때문에 수동으로 처리해야 함
          // AnimatedBuilder로 감싸서 실행시킴
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return PositionedDirectional(
                top: _animation.value.top,
                start: _animation.value.left,
                end: _animation.value.right,
                bottom: _animation.value.bottom,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.indigo,
                )
              );
            }
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller
            ..reset()
            ..forward();
        },
        child: const Icon(Icons.play_circle),
      ),
    );
  }
}
