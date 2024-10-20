## Page Transitions Animation

### [Animate a page route transition](https://docs.flutter.dev/cookbook/animation/page-route-animation)
화면간 이동에서 애니메이션을 적용하기 위해서 `PageRouteBuilder`를 사용한다.
`PageRouteBuilder`는 `Animation` 객체를 제공해서 `Tween`과 `Curves`로 애니메이션의 트랜지션을 커스텀 할 수 있다. 
위 예시는 5단계로 페이지 트렌지션을 구성한다. 
1. `PageRouteBuilder`생성
2. `Tween` 생성
3. `AnimationWidget` 추가
4. `CurveTween` 사용
5. 두 `Tween`들 결합

## PageRouteBuilder
콜백에 의해서 단일 라우팅이 정의되는 유틸리티 클래스

### pageBuilder
호출자에 의해서 `PageRouteBuilder`에 반드시 정의되어야 하는 라우팅의 주요 내용
- context: 생성되는 경로의 context
- animation: 메인 라우팅 트랜지션의 에니메이션
- secondaryAnimation: 경로에서 가장 맨 위로 보내지는 화면에 들어가고 나오는 트랜지션 

### transitionBuilder
트랜지션을 적용하기 위해서 정의되는 함수
- context
- animation
- secondaryAnimation
- child: `pageBuilder`에서 반환하는 child widget
e.g **Enter with RotationTransition & Exit With FadeTransition**
```dart
PageFadeTransition(this.page) : super(
 pageBuilder: (context, animation, secondaryAnimation) => page,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
   // AnimationStatus의 상태가 reverse일 때 화면에서 나옴
    if (animation.status == AnimationStatus.reverse) {
      return FadeTransition(
        opacity: animation,
        child: child
      );
    }
    return RotationTransition(
      turns: Tween<double>(
      begin: 0.0,
      end: 5.0
    ).animate(animation),
      child: child,
    );
  }
);
```



1. Page Fade Transition
   - `FadeTransition`을 사용한 라우팅 
2. Page Scale Transition
   - `ScaleTransition`을 사용한 라우팅
3. Page Rotation Transition
   - `RotationTransition`을 사용한 라우팅
4. Page Slide Transition
   - `SlideTransition`을 사용한 라우팅
5. Page Size Transition
   - `SizeTransition`을 사용한 라우팅
   - [**Flutter**는 `SizeTransition`로 화면을 어떻게 채울지 몰라서 `Align` 위젯으로 감싸야한다.](https://stackoverflow.com/questions/50670250/flutter-sizetransition-and-pageroutebuilder-not-working)  
   - `SizeTransition`은 `axis`으로 사이즈 변환 축을 정하고, `axisAlignment`으로 축의 중심의 위치를 정한다. 애니메이션의 시작점은 `Align`위젯의 `alignment`에 center / ~right / ~left 값에 따라서 달라진다.
6. Page Mix Size Fade Transition 
   - `SizeTransition`와 `FadeTransition`을 섞은 라우팅 
   - transitionBuilder 안에서 사용할 애니메이션을 순차적으로 적용시켜주면 된다.
7Page Mix Size Fade Transition 
   - `ScaleTransition`와 `RotationTransition`을 섞은 라우팅  
