import 'package:flutter/material.dart';

class TweenScreen extends StatefulWidget {
  const TweenScreen({super.key});
  @override
  State createState() => _TweenScreenState();
}

class _TweenScreenState extends State<TweenScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4)
    );
    _animation = ColorTween(
      begin: Colors.red,
      end: Colors.blue
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutBack))
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((status) {
      print("Animation status changed: $status");
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Animation Controller value: ${_animationController.value.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Animation value: ${_animation.value.toString()}"//toStringAsFixed(2)}"
                 ,style: TextStyle(fontSize: 20, color: _animation.value),
              ),
            ),
            Container(color: _animation.value, width: 200, height: 200,)
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: () {
            _animationController.forward();
          }, child: Icon(Icons.play_arrow_outlined)),
          ElevatedButton(onPressed: () {
            _animationController.reverse();
          }, child: Icon(Icons.arrow_back))
        ],
      ),
    );
  }
}