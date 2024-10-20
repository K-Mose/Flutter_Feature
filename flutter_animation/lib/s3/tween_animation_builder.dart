import 'package:flutter/material.dart';

class TweenAnimationBuilderScreen extends StatefulWidget {
  const TweenAnimationBuilderScreen({Key? key}) : super(key: key);

  @override
  State<TweenAnimationBuilderScreen> createState() => _TweenAnimationBuilderScreenState();
}

class _TweenAnimationBuilderScreenState extends State<TweenAnimationBuilderScreen> with SingleTickerProviderStateMixin {
  double opacityLevel = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Positioned Directional Transition Example"),
      ),
      body: Container(
        color: Colors.black26,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: opacityLevel),
                duration: const Duration(seconds: 2),
                // child: 애니메이션 적용할 위젯, chile에 정의된 위젯이 자동으로 들어감
                builder: (context, value, child) {
                  print("value :: $value");
                  return Opacity(
                    opacity: value,
                    child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(value * 100)
                        )
                    ),
                  );
                },
                // child:
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
                  });
                },
                child: const Text("Animate")
              )
            ],
          ),
        ),
      ),
    );
  }
}
