# get_x_test
[GetX](https://pub.dev/packages/get#the-three-pillars)
## GetX Test
- State Management
- Routing


## GetX State Management
GetX를 이용한 상태 관리는 크게 2가지로 나뉜다. 
1. Simple State Management
2. Reactive State Management

### Simple State Management
**Simple State Management**는 `GetBuilder`를 사용해서 UI를 업데이트 시킨다.
```dart
class MyStateController extends GetXController {
  var myValue = '';
  
  void setString(String value) {
    myValue = value;
    update(); // update를 해야 UI 업데이트가 된다. 
  }
}
```

### Reactive State Management
```dart
class MyStateController extends GetXController {
  var myValue = ''.obs;

  void setString(String value) {
    myValue.value = value; // 값 할당 시 UI 업데이트가 된다. 
  }
} 
```