# Explicit Animation
1. [Positioned Transition](https://api.flutter.dev/flutter/widgets/PositionedTransition-class.html)
  - Animation<RelativeRect>를 애니메이션으로 받는 트랜지션
  - RelativeRect는 Stack 안에서 top,left,right,bottom로 상대적 위치를 잡음 
  - RelativeRectTween으로 start ~ end 처리
  - <details>
    <summary>e.g</summary>
    
    ```dart
    late Animation<RelativeRect> _myAnimation;
    void initAnimation() {
      _myAnimation = RelativeRectTween(
        begin: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
        end: const RelativeRect.fromLTRB(250.0, 250.0, 0.0, 0.0),
      ).animate(_controller);
    }
    ```
    
    </details>
2. [Size Transition](https://api.flutter.dev/flutter/widgets/SizeTransition-class.html)
   - Animation<double>을 애니메이션으로 받는 트랜지션
   - SizeTransition의 부모 위젯이 크기를 갖게 되면 아래와 같은 문제가 생긴다.
     > Like most widgets, SizeTransition will conform to the constraints it is given, so be sure to put it in a context where it can change size. For instance, if you place it into a Container with a fixed size, then the SizeTransition will not be able to change size, and will appear to do nothing.
   - 위젯을 wrap 하거나 axis를 줘서 해결 가능하다. 
   - <details>
     <summary>e.g</summary>
   
     ```dart
     late Animation<double> _sizeAnimation;
    
     void init() {
       _sizeAnimation = Tween(
         begin: 0.0,
         end: 1.0
       ).animate(
         CurvedAnimation(
           parent: _controller,
           curve: Curves.bounceInOut
         )
       );
     }
    
     ```
   </details>

3. [Rotation Transition](https://api.flutter.dev/flutter/widgets/RotationTransition-class.html)
   - Animation<RelativeRect>를 애니메이션으로 받는 트랜지션
   - `Tween` end 값에 따라서 회전하는 수가 달라진다. 
   - <details>
     <summary>e.g.</summary>
     
     ```dart
     late AnimationController _controller;
     late Animation<double> _animation;
    
     @override
     void initState() {
       super.initState();
       _controller = AnimationController(
         vsync: this,
         duration: const Duration(seconds: 1)
       );
       _animation = Tween<double>(
         begin: 0,
         end: 7 // 정수 배수만큼 회전이 들어감. 여기선 7배
       ).animate(_controller);
     }
     ```
  
     </details>
  
4. [Animated Builder](https://api.flutter.dev/flutter/widgets/AnimatedBuilder-class.html)
   - 주어진 animation 값을 listening 하여서 값에 따라 위젯에 애니메이션을 적용함
   - builder 안에는 애니메이션을 실행할 위젯이 들어감
   - 애니메이션 위젯이 `Aniamtion`을 직접 받지 않아서 혼자 애니메이션을 컨트롤 할 능력이 없으면 상위 위젯으로 `AnimationBuilder`를 사용하여 동작시켜야 한다. 
   - <details>
     <summary>Transform 위젯을 이용한 방법</summary>
     
     ```dart
       AnimatedBuilder(
         // Listenable 타입의 객체로 ChangeNotifier 같은 역할을 한다.
         animation: _controller,
         builder: (context, child) {
           // _controller.value는 0.0 ~ 1.0 까지 제공된 duration 동안 변경된다
           // flip 
           return Transform.flip(
             // filpX/Y이 bool 값에 따라서 뒤집힘
             flipX: _controller.value > 0.5,
             flipY: _controller.value < 0.3 || _controller.value < 0.8,
             child: Container(
               width: 250,
               height: 250,
               color: Colors.transparent,
               child: Image.asset(CHEESE),
             ),
           );

           // translate
           return Transform.translate(
             // 화면의 중앙을 기점으로 (0.0)으로 시작해서 움직임
             // 이미지도 중앙이 기점임
             offset: Offset(_controller.value * 200, _controller.value * 100),
             child: Container(
               width: 250,
               height: 250,
               color: Colors.transparent,
               child: Image.asset(CHEESE),
             ),
           );

           // scale
           return Transform.scale(
             // scale 값에 들어가는 실수만큼 배율이 됨
             // scaleX / scaleY로 해당 축만 키울 수 있음
             scaleX: 2 * _controller.value,
             child: Container(
               width: 250,
               height: 250,
               color: Colors.transparent,
               child: Image.asset(CHEESE),
             ),
           );

           // rotate
           return Transform.rotate(
             // 2pi 가 1바퀴
             angle: 2 * pi * _controller.value,
             child: Container(
               width: 250,
               height: 250,
               color: Colors.transparent,
               child: Image.asset(CHEESE),
             ),
           );
         },
       ),
     ```
     </details>
     - [일반 위젯 사용](animated_builder2.dart) - 애니메이션이 들어갈 위치에 Animation 값을 넣어서 동작하게 한다.
5. [Fade Transition](https://api.flutter.dev/flutter/widgets/FadeTransition-class.html)
  - Animation<double>을 애니메이션으로 받는 트랜지션
  - 0 ~ 1 값이 기본이지만 1보다 큰 값을 넣으면 갑자기 사라지는 효과를 넣을 수 있다. 
  - `FadeTransition`은 opacity에 `Animation`값을 넣어 FadeIn/Out 효과를 낸다. 
6. [Posotioned Directional Transition](https://api.flutter.dev/flutter/widgets/PositionedDirectional-class.html)
  - `PositionedTransition`과 같은 작업을 하지만 animation을 받지 않는다. 그렇기 때문에 위젯 자체는 애니메이션 효과를 줄 능력이 없어서 부모 위젯으로 `AniamatedBuilder`같은 위젯을 준다. 

7. [Tween Animation Builder](https://api.flutter.dev/flutter/widgets/TweenAnimationBuilder-class.html)
  - `Animation`, `AnimationController`없이 `Tween`으로만 애니메이션을 작동시키는 빌더
```dart
TweenAnimationBuilder(
  tween: ,
  duration: ,
  builder: (context, value, child) {
     return AnimationWidget()
  }
)
```
[암시적으로 움직이는 위젯과 움직이는 위젯의 관계](https://api.flutter.dev/flutter/widgets/TweenAnimationBuilder-class.html#relationship-to-implicitlyanimatedwidgets-and-animatedwidgets) 에서 보면 `TweenAnimationBuilder`는 `implicitlyanimatedwidget`을 상속하고 값을 지정해서 쉽게 애니메이션을 구현할 수 있다. 
모든 `implicitlyanimatedwidget`은 내부에서 `AnimationController`를 통해 관리되고 다른 값들(traget value, duration, curve 등)을 지정하여 조정할 수 있다.
`AnimationBuilder`는 `TweenAnimationBuilder`와 다르게 explicit 하므로 외부에서 관리가 필요하다.

8. [Default Text Style Transition](https://api.flutter.dev/flutter/widgets/DefaultTextStyleTransition-class.html)
  - 입력되는 `TextStyle`를 애니메이션 형태로 전환 위젯
  - style에 `Animation<TextStyle>` 타입을 받으며 `TextStyleTween`으로 정의한다. 
    <details>
    <summary>e.g.</summary>
    
    ```dart
    class _DefaultTextStyleTransitionScreenState extends State<DefaultTextStyleTransitionScreen> with SingleTickerProviderStateMixin {
      late AnimationController _controller;
      late Animation<TextStyle> _animation;
    
      TextStyle style1 = const TextStyle(...);
      TextStyle style2 = const TextStyle(...);
    
      @override
      void initState() {
        super.initState();
        _controller = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 2)
        )..repeat(reverse: true);
        _animation = TextStyleTween(begin: style1, end: style2).animate(_controller);
      }
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Center(
            child: DefaultTextStyleTransition(
              style: _animation,
              child: const Text("Changing Default Text Style"),
            ),
          ),
        );
      }
    }
    ```
  </details>
    
9. [Indexed Stack](https://api.flutter.dev/flutter/widgets/IndexedStack-class.html)
   - children 내의 위젯 리스트들을 주어진 index에 맞게 보여주는 위젯
   - `IndexedStack`자체는 애니메이션 위젯이 아니지만 stack에서 순서를 바꿀 때 전환 벤트를 주기 위해서 추가됐다.
   ```dart
    children: [
      ScaleTransition(
        scale: _scaledAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.yellow,
            child: Image.asset(CHEESE),
          ),
        ),
      ),
      ScaleTransition(
        scale: _scaledAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.orange,
            child: Image.asset(JERRY),
          ),
        ),
      ),
    ]
    ```
   자식 위젯에 컨트롤러를 통해서 explicit animation을 주면 화면이 전환 되면서 애니메이션이 발생한다. 

  전환 시에 애니메이션의 초기화/실행은 필수
  ```dart
    setState(() {
      currentIndex = ++currentIndex%4;
      _controller.reset();
      _controller.forward();
    });
  ```
