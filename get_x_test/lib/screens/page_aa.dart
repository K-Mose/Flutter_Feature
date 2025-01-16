import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/constants/path.dart';

class PageAA extends StatelessWidget {
  static const routeName = '/aa';
  const PageAA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Screen AA'),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => Get.toNamed(pageAAARoute),
                  child: const Text('Page AAA'),
                ),
                OutlinedButton(
                  onPressed: () => Get.toNamed(pageBRoute),
                  child: const Text('Page B'),
                ),
                OutlinedButton(
                  onPressed: () => Get.toNamed(pageCRoute),
                  child: const Text('Page C'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
