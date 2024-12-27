import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/controller/obs_controller.dart';
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
    // Get.put(MySimpleController());
    Get.put(MyObsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("_SimpleScreenState Builder!!");
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          MyText('GetBuilder 외부 위젯'),
          Center(
            child: GetBuilder(
              init: MyObsController(),
              builder: (controller) {
                return Column(
                  children: [
                    MyText('GetBuilder 외부 위젯1'),
                    MyText('Obs :: ${controller.myCounter}'),
                  ],
                );
              }
            ,),
          ),
          Center(
            child: GetBuilder(
              init: MySimpleController(),
              builder: (controller) {
                return Column(
                  children: [
                    MyText('GetBuilder 내부 위젯2'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText('Simple :: ${controller.counter}'),
                        const SizedBox(width: 100,),
                        MyText('Simple :: ${controller.myValue}'),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(Get.find<MyObsController>().myCounter);
          Get.find<MyObsController>().increaseUpdate();
        },
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

