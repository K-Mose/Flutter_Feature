import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class AnimatedAlignScreen extends StatefulWidget {
  const AnimatedAlignScreen({super.key});

  @override
  State createState() => _AnimatedAlignScreenState();
}

class _AnimatedAlignScreenState  extends State<AnimatedAlignScreen> {
  int jerryAligned = 0;
  double x = 0.0;
  double y = 0.0;
  bool isStarted = false;
  late Timer _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Align Example"),),
      body: Stack(
        children: [
          // alignment에서 받은 값으로 duration 동안 이동함
            AnimatedAlign(
              alignment: getNextAlignment(jerryAligned),
              duration: const Duration(milliseconds: 500,),
              child: Container(
                height: 100,
                width: 100,
                // color: Colors.blueAccent,
                child: Image.asset(JERRY),
              ),
            ),
            AnimatedAlign(
              alignment: Alignment(x,y),
              duration: const Duration(milliseconds: 500,),
              child: Container(
                height: 100,
                width: 100,
                // color: Colors.redAccent,
                child: Image.asset(TOM),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (isStarted) ? () {
          print("123");
          setState(() {
            try {
              isStarted = false;
              _timer.cancel();
            } catch (_) {
              print("error");
            }
          });
        } : () {
          print("qwe");
          isStarted = true;
          _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
            setState(() {
              jerryAligned = jerryAligned > 7 ? 0 : jerryAligned + 1;
              x = (Random().nextInt(200)-100)/100;
              y = (Random().nextInt(200)-100)/100;
            });
          });
        },
        child: const Icon(Icons.animation),
      ),
    );
  }

  Alignment getNextAlignment(int _jerryAligned) {
    switch(_jerryAligned) {
      case 1:
        return Alignment.topLeft;
      case 2:
        return Alignment.topCenter;
      case 3:
        return Alignment.topRight;
      case 4:
        return Alignment.centerLeft;
      case 5:
        return Alignment.center;
      case 6:
        return Alignment.centerRight;
      case 7:
        return Alignment.bottomLeft;
      case 8:
        return Alignment.bottomCenter;
      default:
        return Alignment.bottomRight;
    }
  }
}