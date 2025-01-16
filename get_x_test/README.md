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

```dart
GetBuilder(
  init: MyStateController(),
  builder: (controller) {
    return MyText(controller.myValue);   
  }
)
```
`GetBuilder`는 init에 등록된 컨트롤러를 관찰하고, 컨트롤러에서 `update`가 호출되면 포함하는 위젯 전체를 rebuild 한다.



### Reactive State Management
Rx<T> 타입을 사용하여 값을 관찰한다. 타입별 extension이 있어서 값에 obs를 붙여서 rx 객체를 생성한다. 

```dart
class MyStateController extends GetXController {
  var myValue = ''.obs;

  void setString(String value) {
    myValue.value = value; // 값 할당 시 UI 업데이트가 된다. 
  }
} 
```

**Obx() 내의 변수 업데이트**
Reactive state management의 값을 변경하기 위해서는 관찰할 값을 `Obx()`으로 감싸줘야 한다.   
```dart
Obx(() {
  final myStateController = Get.find<MyStateController>();
  return Text(myStateController.myValue);
})
```

`Obx`는 관찰하는 값들 중에서 하나라도 변하면 위젯을 업데이트 시킨다. 
```dart
1.
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Obx(() {
        final controller = Get.find<MyObsController>();
        return MyText(controller.myCounter.toString());
      },),
      const SizedBox(width: 100,),
      Obx(() {
        final controller = Get.find<MyObsController>();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 100,),
            MyText(controller.myValue.value),
          ],
        );
      },),
    ],
  ),

  //////////////////////
2. 
  Obx(() {
    final controller = Get.find<MyObsController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ 
        MyText(controller.myCounter.toString()),
        const SizedBox(width: 100,),
        MyText(controller.myValue.value),
      ],
    );
},),
```
위 두 코드는 둘 다 `myCounter`와 `myValue` 값의 변화를 관찰 하지만, 1번 코드는 `Obx`를 따로 나눴기 때문에 `myCounter`의 변화가 `myValue`의 위젯에 영향을 주지 않는다. 

2번 코드는 하나의 `Obx`가 두 값을 관찰하고있기 때문에 어느 한 값이 변하면 `Obx` 내부의 전체 위젯이 업데이트 된다.

UI의 업데이트를 최소화 하려면 변하는 위젯에만 `Obx`를 사용하면 된다. 

## GetX Routing 
- 라우팅 히스토리 : https://stackoverflow.com/questions/78315456/flutter-getx-how-to-obtain-routes-in-stack-aka-routing-history

GetX에서 페이지 라우팅은 `GetMaterialApp`의 `getPages`에 `List<GetPage>` 타입의 라우팅 테이블을 작성하면 된다. 
※ `getPage`에 라우팅 테이블을 작성하지 않아도 `Get.to`은 사용 가능하나 `Get.toNamed`는 사용 불가능하다. (`Could not find a generator for route RouteSettings("/path", null) in the _WidgetsAppState.`)

<details>
<summary>codes</summary>

```dart 
// main
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
      navigatorObservers: [MyNavigatorObserver()],
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      getPages: Routes.routes,
    );
  }
}
```

```dart 
// Routes
class Routes {
  static final routes = [
    GetPage(
        name: PageA.routeName,
        page: () => const PageA(),
        children: [
          GetPage(
              name: PageAA.routeName, // gorouter와 달리 하위 페이지의 routeName도 '/'로 시작해야 한다.
              page: () => const PageAA(),  
              children: [
                GetPage(
                  name: PageAAA.routeName,
                  page: () => const PageAAA(),
                ),
              ]
          ),
        ]
    ),
    GetPage(
      name: PageB.routeName,
      page: () => const PageB(),
    ),
    GetPage(
      name: PageC.routeName,
      page: () => const PageC(),
    ),
  ];
}
```

</details>