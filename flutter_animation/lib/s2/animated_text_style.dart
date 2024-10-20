import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedTextStyleScreen extends StatefulWidget {
  const AnimatedTextStyleScreen({super.key});
  @override
  State createState() {
    return _AnimatedTextStyleScreenState();
  }
}

class _AnimatedTextStyleScreenState extends State<AnimatedTextStyleScreen> {

  int value = 3;
  final defaultSize = 8.0;
  double _fontSize = 16;
  Color _color = Colors.grey;

  void _setValues() {
    setState(() {
      _color = (value % 5 == 0) ? Colors.black
          : (value % 5 == 1) ? Colors.yellow
          : (value % 5 == 2) ? Colors.redAccent
          : (value % 5 == 3) ? Colors.indigo
          : (value % 5 == 4) ? Colors.blueAccent : Colors.transparent;
      _fontSize = defaultSize * value;
    });
  }

  void _setRandomValue() {
    setState(() {
      // random color
      _color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      _fontSize = Random().nextInt(80) + 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Text Style"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 새롭게 지정된 TextStyle을 Duration동안 변경시킨다.
          AnimatedDefaultTextStyle(
            style: TextStyle(
              fontSize: _fontSize,
              color: _color,
            ),
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 500),
            child: const Text("Hello World"),
          ),
          const SizedBox(height: 60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {
                if (value < 15) value += 1;
                _setValues();
              }, icon: const Icon(Icons.add)),
              IconButton(onPressed: () {
                if (value > 1) value -= 1;
                _setValues();
              }, icon: const Icon(Icons.remove)),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setRandomValue,
        child: const Icon(Icons.local_pizza),
      ),
    );
  }
}