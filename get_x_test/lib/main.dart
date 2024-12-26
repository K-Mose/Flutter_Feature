import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/controller/obs_controller.dart';
import 'package:get_x_test/screens/reactive_screen.dart';
import 'package:get_x_test/screens/simple_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(onPressed: () => Get.to(const SimpleScreen()), child: const Text("Simple")),
            const SizedBox(height: 20,),
            OutlinedButton(onPressed: () => Get.to(const ReactiveScreen()), child: const Text("Reactive")),
          ],
        ),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  final String value;
  const MyText(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("MyText is Build!! :: $value");
    return Text(value);
  }
}

class MyInputButton extends StatelessWidget {
  final TextEditingController tc;
  const MyInputButton(this.tc, {super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("MyInputButton is Build!!");
    return OutlinedButton(
      onPressed: () =>
          Get.find<MyObsController>().updateValue(tc.text),
      child: const MyText("입력"),
    );
  }
}

