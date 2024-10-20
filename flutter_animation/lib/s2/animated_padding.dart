import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class AnimatedPaddingScreen extends StatefulWidget {
  const AnimatedPaddingScreen({super.key});

  @override
  State createState() {
    return _AnimatedPaddingScreenState();
  }
}

/// Animated Padding
/// 주어진 padding 값에 따라서 duration 동안 애니메이션이 발생함
class _AnimatedPaddingScreenState extends State<AnimatedPaddingScreen> {

  List<String> characters = [
    TOM,
    JERRY,
    CHEESE,
    DOG,
  ];

  double _paddingValue = 10.0;
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Padding"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children:
          characters.map((c) => AnimatedPadding(
            padding: EdgeInsets.all(_paddingValue),
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
              child: Image.asset(c)
            ),
          )
          ).toList()
        ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _paddingValue = (_isExpanded) ? 50 : 10;
          _isExpanded = !_isExpanded;
        }),
        child: (_isExpanded) ? const Icon(Icons.expand)
            : const Icon(Icons.expand_less),
      ),
    );
  }
}