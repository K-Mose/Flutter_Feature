import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/controller/obs_controller.dart';
import 'package:get_x_test/main.dart';

class ReactiveScreen extends StatefulWidget {
  const ReactiveScreen({super.key});

  @override
  State<ReactiveScreen> createState() => _ReactiveScreenState();
}

class _ReactiveScreenState extends State<ReactiveScreen> {
  final tc = TextEditingController();

  @override
  void initState() {
    Get.put(MyObsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyObsController>();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(width: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return MyText(controller.myCounter.toString());
                },),
                const SizedBox(width: 100,),
                MyText(controller.myCounter.toString()),
                const SizedBox(width: 100,),
                Obx(() {
                  // final controller = Get.find<MyObsController>();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 하나의 Obx에서 여러 개의 값이
                      // MyText(controller.myCounter.toString()),
                      const SizedBox(width: 100,),
                      MyText(controller.myValue.value),
                    ],
                  );
                },),
              ],
            ),
            const SizedBox(height: 30,),
            SizedBox(
              height: 100,
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: tc,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  MyInputButton(tc),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Get.find<MyObsController>().increase,
        child: const Icon(Icons.add),
      ),
    );
  }
}
