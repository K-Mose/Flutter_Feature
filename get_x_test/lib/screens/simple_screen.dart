import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/controller/simple_controller.dart';
import 'package:get_x_test/main.dart';

class SimpleScreen extends StatefulWidget {
  const SimpleScreen({super.key});

  @override
  State<SimpleScreen> createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {

  final tc = TextEditingController();

  @override
  void initState() {
    Get.put(MySimpleController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GetBuilder(
          init: MySimpleController(),
          builder: (controller) {
            return Column(
              children: [
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
                      _MyInputButton(tc),
                    ],
                  ),
                ),
                MyText('${controller.counter} /// ${controller.myValue}'),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.find<MySimpleController>().increase(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _MyInputButton extends StatelessWidget {
  final TextEditingController tc;
  const _MyInputButton(this.tc, {super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("MyInputButton is Build!!");
    return OutlinedButton(
      onPressed: () =>
          Get.find<MySimpleController>().updateValue(tc.text),
      child: const MyText("입력"),
    );
  }
}

