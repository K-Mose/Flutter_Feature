import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class AnimatedContainerScreen extends StatefulWidget {
  const AnimatedContainerScreen({super.key});

  @override
  State createState() {
    return AnimatedContainerScreenState();
  }
}

class AnimatedContainerScreenState extends State<AnimatedContainerScreen> {
  bool isSmall = false;
  Color _color = Colors.grey;
  double _radius = 20.0;
  double _width = 100.0;
  double _height = 100.0;

  void _setAnimationValues() {
    setState(() {
      if (isSmall) {
        isSmall = false;
        _color = Colors.orange;
        _radius = 60.0;
        _width = 350.0;
        _height = 350.0;
      } else {
        isSmall = true;
        _color = Colors.grey;
        _radius = 20.0;
        _width = 100.0;
        _height = 100.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Container Example"),),
      body: Center(
        child: GestureDetector(
          onTap: _setAnimationValues,
          // duration 동안 변경된 값들을 애니메이션 형태로 변화를 보여줌
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(_radius)
            ),
            child: Image.asset(CHEESE),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setAnimationValues,
        child: const Icon(Icons.animation),
      ),
    );
  }
}