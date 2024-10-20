import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class AnimatedPositionedScreen extends StatefulWidget {
  const AnimatedPositionedScreen({super.key});

  @override
  State createState() {
    return _AnimatedPositionedScreenState();
  }
}

class _AnimatedPositionedScreenState extends State<AnimatedPositionedScreen> {
  bool isTop = false;
  final double boxPadding = 16.0;
  final double boxSize = 120.0;
  @override
  Widget build(BuildContext context) {
    print(AppBar().preferredSize.height);
    print(MediaQuery.of(context).padding.top);
    print(MediaQuery.of(context).viewPadding.top);
    print(MediaQuery.of(context).viewInsets.top);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Positioned"),
      ),
      body: Padding(
        padding: EdgeInsets.all(boxPadding),
        child: Stack(
          children: [
            AnimatedPositioned(
              top: 0,
              left: 0,
              duration: const Duration(seconds: 1),
              child: Container(
                width: boxSize,
                height: boxSize,
                color: Colors.transparent,
                child: Image.asset(CHEESE),
              ),
            ),
            AnimatedPositioned(
              top: 0,
              // Screen Width - Image Size - Padding Left - Padding Right
              left: isTop ? 0.0 : MediaQuery.of(context).size.width - boxSize * 2,
              duration: const Duration(seconds: 1),
              child: Container(
                width: boxSize,
                height: boxSize,
                color: Colors.transparent,
                child: Image.asset(JERRY),
              ),
            ),
            AnimatedPositioned(
              top: isTop ? 0.0 : MediaQuery.of(context).size.width / 2,
              left: isTop ? 0.0 : MediaQuery.of(context).size.width / 2,
              duration: const Duration(seconds: 1),
              child: Container(
                width: boxSize,
                height: boxSize,
                color: Colors.transparent,
                child: Image.asset(DOG),
              ),
            ),
            AnimatedPositioned(
              // bottom: 0 = Screen Height - Image Size - Padding Left - Padding Right - AppBar Height - Top Padding(Status Bar Height)
              top: isTop ? 0.0 : MediaQuery.of(context).size.height
                  - boxSize - boxPadding *2
                  - AppBar().preferredSize.height
                  - MediaQuery.of(context).padding.top,
              left: 0,
              duration: const Duration(seconds: 1),
              child: Container(
                width: boxSize,
                height: boxSize,
                color: Colors.transparent,
                child: Image.asset(TOM),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isTop = !isTop;
          });
        },
        child: (isTop) ? const Icon(Icons.arrow_downward) : const Icon(Icons.arrow_upward),
      ),
    );
  }
}