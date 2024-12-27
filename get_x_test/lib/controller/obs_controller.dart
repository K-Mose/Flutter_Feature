import 'package:get/get.dart';

class MyObsController extends GetxController {
  // GetX내의 Rx Implement package 안에서
  // StringExtension을 통해서 RxString 객체를 생성한다.
  var myValue = ''.obs;
  var myCounter = 0.obs;

  void updateValue(String value) => myValue.value = value; // 값 항당 시 UI 업데이트
  void increase() => myCounter++;
  void increaseUpdate() => {myCounter++, update()};
}