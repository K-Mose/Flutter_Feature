import 'package:flutter/material.dart';
import 'package:flutter_animation/const.dart';

class RotationTransitionScreen extends StatefulWidget {
  const RotationTransitionScreen({super.key});

  @override
  State<RotationTransitionScreen> createState() => _RotationTransitionScreenState();
}

class _RotationTransitionScreenState
    extends State<RotationTransitionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    );
    _animation = Tween<double>(
      begin: 0,
      end: 7 // 정수 배수만큼 회전이 들어감. 여기선 7배
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    print("start:: ${_controller.status}");
    switch (_controller.status) {
      case AnimationStatus.completed:
        _controller.reverse();
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        _controller.isAnimating ? _controller.stop() : _controller.reset();
        break;
      case AnimationStatus.dismissed:
      default:
        _controller.forward();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Positioned Transition Example"),
      ),
      body: Center(
        child: RotationTransition(
          turns: _animation,
          child: Container(
            height: 150,
            width: 150,
            color: Colors.grey,
            child: Image.asset(CHEESE),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startAnimation,
        child: const Icon(Icons.play_arrow_outlined),
      ),
    );
  }
}
