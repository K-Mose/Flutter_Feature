import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotScreen extends StatefulWidget {
  const ScreenshotScreen({super.key});

  @override
  State<ScreenshotScreen> createState() => _ScreenshotScreenState();
}

class _ScreenshotScreenState extends State<ScreenshotScreen> {
  final ScreenshotController controller = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Screenshot(
            controller: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height:100, width:100, color: Colors.black,),
                Container(height:100, width:100, color: Colors.yellow,),
                Container(height:100, width:100, color: Colors.teal,),
                Container(height:100, width:100, color: Colors.orange,),
                const SizedBox(height: 120,),
                OutlinedButton(
                  onPressed: () async {
                    final data = await controller.capture();
                    if (data == null) return;
                    showDialog(context: context, builder: (context) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black)
                      ),
                      child: Image.memory(data),
                    ),);
                  },
                  child: const Text("SHOTT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
