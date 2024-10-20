import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class SizeTransitionScreen extends StatefulWidget {
  const SizeTransitionScreen({super.key});

  @override
  State createState() => _SizeTransitionScreenState();
}

class _SizeTransitionScreenState extends State<SizeTransitionScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    // double 값을 받기 때문에 기본 tween 사용
    _sizeAnimation = Tween(
      begin: 0.0,
      end: 1.0
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut
      )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Size Transition Example"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: _startAnimation,
          child: Container(
            height: 200,
            // width: 200,
            color: Colors.blue,
            /*
            SizeTransition가 height, width가 주어진 Container의 바로 하위 위젯이기 때문에
            SizeTransition이 Container의 사용 가능한 공간을 다 차지하려고 해서 작동을 안한다.
            ```
            Like most widgets, SizeTransition will conform to the constraints it is given,
            so be sure to put it in a context where it can change size.
            For instance, if you place it into a Container with a fixed size,
            then the SizeTransition will not be able to change size,
            and will appear to do nothing.
            ```
            SizeTransition이 갖을 공간을 확실히 줘야 한다.

            상위 위젯의 Container가 heigh만 갖을 때는 SizeTransition axis에 vertical을,
            width만 갖을 때는 axis를 horizontal을 줘서 해결할 수 있다.
            */
            child: SizeTransition(
              sizeFactor: _sizeAnimation,
              axis: Axis.vertical,
              child: Container(
                height: 100,
                width: 100,
                color: Colors.yellowAccent,
                child: Image.asset(CHEESE)
              )
            ),
          ),
        ),
      ),
    );
  }

  void _startAnimation() {
    print("animationStart");
    _controller.reset();
    _controller.forward();
  }
}