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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Obx(() {
              final controller = Get.find<MyObsController>();
              return MyText(controller.myValue.value);
            },),
            const SizedBox(height: 80,),
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
    );
  }
}
