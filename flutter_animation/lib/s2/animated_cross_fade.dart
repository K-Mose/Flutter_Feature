import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class AnimatedCrossFadeScreen extends StatefulWidget {
  const AnimatedCrossFadeScreen({super.key});

  @override
  State createState() {
    return _AnimatedCrossFadeScreenState();
  }
}

/// AnimatedCrossFade
/// 두 개의 child widget간의 교체를 cross fade 효과로 보여주는 위젯
/// 주요 파라메터
/// duration: 애니메이션 속도
/// firstChild: 처음에 보여줄 위젯
/// secondChild: 두 번째로 보여줄 위젯
/// crossFadeState: 어떤 위젯을 보여줄지 정하는 상태
class _AnimatedCrossFadeScreenState extends State<AnimatedCrossFadeScreen> {

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Cross Fade"),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            isTapped = !isTapped;
          });
        },
        child: Center(
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 400),
            crossFadeState: !isTapped
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Container(
              height: 200,
              width: 200,
              color: Colors.yellow,
              child: Image.asset(CHEESE),
            ),
            secondChild: Container(
              height: 100,
              width: 100,
              color: Colors.orangeAccent,
              child: Image.asset(JERRY),
            ),
          ),
        ),
      ),
    );
  }
}