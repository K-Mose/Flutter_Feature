import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class AnimatedPositionedDirectionalScreen extends StatefulWidget {
  const AnimatedPositionedDirectionalScreen({super.key});

  @override
  State createState() {
    return _AnimatedPositionedDirectionalScreenState();
  }
}

/// AnimatedPositionedDirectional
/// PositionedDirectional에서 Animation이 추가된 것
/// PositionedDirectional은 사이즈가 변경되면 자식을 재배치 시킴
class _AnimatedPositionedDirectionalScreenState extends State<AnimatedPositionedDirectionalScreen> {

  final double boxSize = 120.0;
  final double step = 100.0;
  double _start = 0;
  double _top = 0;

  void _moveLeft() {
    setState(() {
      if (_start > 0) {
        _start -= step;
      } else {
        _start = 0;
      }
    });
  }

  void _moveRight() {
    setState(() {
      if (_start < MediaQuery.of(context).size.width - boxSize) {
        _start += step;
      }
    });
  }

  void _moveUp() {
    setState(() {
      if (_top > 0) {
        _top -= step;
      } else {
        _top = 0;
      }
    });
  }

  void _moveDown() {
    setState(() {
      if (_top < MediaQuery.of(context).size.height
          - boxSize
          - AppBar().preferredSize.height
          - MediaQuery.of(context).padding.top
      ) {
        _top += step;
      } else {
        _top = MediaQuery.of(context).size.height
            - boxSize
            - AppBar().preferredSize.height
            - MediaQuery.of(context).padding.top;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Positioned Directional"),
      ),
      body: Stack(
        children: [
          AnimatedPositionedDirectional(
            top: _top,
            start: _start,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: boxSize,
              height: boxSize,
              color: Colors.transparent,
              child: Image.asset(CHEESE),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _moveLeft,
                  child: const Icon(Icons.arrow_circle_left_outlined)
                ),
                ElevatedButton(
                  onPressed: _moveRight,
                  child: const Icon(Icons.arrow_circle_right_outlined)
                ),
                ElevatedButton(
                  onPressed: _moveUp,
                  child: const Icon(Icons.arrow_circle_up_outlined)
                ),
                ElevatedButton(
                  onPressed: _moveDown,
                  child: const Icon(Icons.arrow_circle_down_outlined)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}