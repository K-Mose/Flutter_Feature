import 'package:get/get.dart';

class MySimpleController extends GetxController {
  int counter = 0;
  String myValue = '';

  void increase() {
    counter++;
    update();
  }
  void updateValue(String value) {
    myValue = value;
    update();
  }
}