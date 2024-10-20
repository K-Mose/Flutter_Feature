import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class IndexedStackScreen extends StatefulWidget {
  const IndexedStackScreen({Key? key}) : super(key: key);

  @override
  State<IndexedStackScreen> createState() => _IndexedStackScreenState();
}

class _IndexedStackScreenState extends State<IndexedStackScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaledAnimation;
  late Animation<double> _opacityAnimation;

  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800)
    );
     _scaledAnimation = Tween<double>(begin: 0.5, end: 1.0)
         .animate(_controller);
     _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
         .animate(_controller);

     _controller.forward();
     _timer = Timer.periodic(
       const Duration(seconds: 1),
       (timer) {
         setState(() {
           currentIndex = ++currentIndex%4;
           _controller.reset();
           _controller.forward();
         });
       }
     );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Indexed Stack Example"),
      ),
      body: IndexedStack(
        // 보여줄 화면의 인덱스
        index: currentIndex,
        children: [
          ScaleTransition(
            scale: _scaledAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.yellow,
                child: Image.asset(CHEESE),
              ),
            ),
          ),
          ScaleTransition(
            scale: _scaledAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.orange,
                child: Image.asset(JERRY),
              ),
            ),
          ),
          ScaleTransition(
            scale: _scaledAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.grey,
                child: Image.asset(TOM),
              ),
            ),
          ),
          ScaleTransition(
            scale: _scaledAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.blueGrey,
                child: Image.asset(DOG),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
