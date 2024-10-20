import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class AnimatedOpacityScreen extends StatefulWidget {
  const AnimatedOpacityScreen({super.key});

  @override
  State createState() {
    return _AnimatedOpacityScreenState();
  }
}

/// AnimatedOpacity
/// opacity 변화를 duration 동안 애니메이션으로 작동한다
/// curve를 통해서 애니메이션의 효과를 변경할 수 있다.
class _AnimatedOpacityScreenState extends State<AnimatedOpacityScreen> {

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Opacity"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedOpacity(
              opacity: (isVisible) ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.decelerate,
              child: const Text(
                "Animated Opacity Example",
                style: TextStyle(
                  fontSize: 32
                ),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: AnimatedOpacity(
              opacity: (isVisible) ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1200),
              curve: Curves.fastOutSlowIn,
              child: Image.asset(JERRY),
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: AnimatedOpacity(
              opacity: (isVisible) ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 2200),
              curve: Curves.easeInBack,
              child: Image.asset(TOM),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          isVisible = !isVisible;
        }),
        child: (isVisible) ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      ),
    );
  }
}