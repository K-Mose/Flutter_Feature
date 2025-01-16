import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/constants/path.dart';

class PageC extends StatelessWidget {
  static const routeName = '/c';
  const PageC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Screen C'),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => Get.toNamed(pageARoute),
                  child: const Text('Page A'),
                ),
                OutlinedButton(
                  onPressed: () => Get.toNamed(pageBRoute),
                  child: const Text('Page B'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
