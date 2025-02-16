import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/constants/path.dart';

class PageAAA extends StatelessWidget {
  static const routeName = '/aaa';
  const PageAAA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Screen AAA'),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  // / -> /a -> /aa -> /aaa 상태에서 /->/aa로 변경
                  onPressed: () => Get.offNamedUntil(pageARoute, (route) {
                    return route.settings.name == '/';
                  },),
                  child: const Text('Page A'),
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
