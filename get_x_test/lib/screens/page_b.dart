import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/constants/path.dart';

class PageB extends StatelessWidget {
  static const routeName = '/b';
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Screen B'),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => Get.toNamed(pageARoute),
                  child: const Text('Page A'),
                ),
                OutlinedButton(
                  onPressed: () => Get.toNamed(pageAARoute),
                  child: const Text('Page AA'),
                ),
                OutlinedButton(
                  onPressed: () => Get.toNamed(pageAAARoute),
                  child: const Text('Page AAA'),
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
