import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/constants/path.dart';

class PageA extends StatelessWidget {
  static const routeName = '/a';
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Screen A'),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => Get.toNamed(pageAARoute),
                  child: const Text('Page AA'),
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