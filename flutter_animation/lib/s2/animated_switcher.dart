import 'package:flutter/material.dart';

class AnimatedSwitcherScreen extends StatefulWidget {
  const AnimatedSwitcherScreen({super.key});

  @override
  State createState() {
    return AnimatedSwitcherScreenState();
  }
}

/// AnimatedSwitcher
/// child widget 간에 변화를 애니메이션으로 보여줌
/// transitionBuilder를 통해서 원하는 트렌지션으로 화면 전환 효과를 넣음
/// 캐러셀?
class AnimatedSwitcherScreenState extends State<AnimatedSwitcherScreen> {

  int index = 0;
  List<Widget> widgets = [
    Container(
      key: const ValueKey(1),
      width: 300,
      height: 300,
      color: Colors.red,
    ),
    Container(
      key: const ValueKey(2),
      width: 280,
      height: 280,
      color: Colors.orangeAccent,
    ),
    Container(
      key: const ValueKey(3),
      width: 260,
      height: 260,
      color: Colors.yellow,
    ),
    Container(
      key: const ValueKey(4),
      width: 240,
      height: 240,
      color: Colors.green,
    ),
    Container(
      key: const ValueKey(5),
      width: 220,
      height: 220,
      color: Colors.blue,
    ),
    Container(
      key: const ValueKey(6),
      width: 200,
      height: 200,
      color: Colors.indigo,
    ),
    Container(
      key: const ValueKey(7),
      width: 180,
      height: 180,
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Switcher"),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            index += 1;
          });
        },
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                // opacity: Tween<double>(
                //   begin: 0.0,
                //   end: 1.0
                // ).animate(CurvedAnimation(parent: animation, curve: Curves.linear)),
                opacity: animation,
                child: child
              );
            },
            child: widgets[index%7],
          ),
        ),
      ),
    );
  }
}