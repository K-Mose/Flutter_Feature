import 'package:flutter/material.dart';

class AnimatedPhysicalModelScreen extends StatefulWidget {
  const AnimatedPhysicalModelScreen({super.key});

  @override
  State createState() {
    return _AnimatedPhysicalModelScreenState();
  }
}

/// AnimatedPhysicalModel
/// color, shadow(elevated), border가 입력된 값에 따라서 duration안 애니메이션으로 변화하는 위젯
/// shape는 애니메이션으로 변화하지 않는다.
class _AnimatedPhysicalModelScreenState extends State<AnimatedPhysicalModelScreen> {

  void _toggleElevation() {
    setState(() {
      _isPressed = !_isPressed;
      _shape = (_isPressed) ? BoxShape.circle : BoxShape.rectangle;
      _color = (_isPressed) ? Colors.yellow : Colors.red;
    });
  }

  bool _isPressed = false;
  BoxShape _shape = BoxShape.rectangle;
  Color _color = Colors.white;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Physical Model"),),
      body: Center(
        child: GestureDetector(
          onTap: _toggleElevation,
          child: AnimatedPhysicalModel(
            shape: _shape,
            elevation: _isPressed ? 60 : 0,
            color: _color,
            shadowColor: Colors.lightBlue,
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceInOut,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38)
              ),
            ),
          ),
        ),
      ),
    );
  }
}