import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter_test/srceen1.dart';
import 'package:gorouter_test/srceen1_1.dart';
import 'package:gorouter_test/srceen1_1_1.dart';
import 'package:gorouter_test/srceen2.dart';



/*
  Go Router
  https://www.youtube.com/watch?v=b6Z885Z46cU

Navigation :
GoRouteInformationProvider
- go : 기존 라우트 스택을 초기화시키고 해당 location 페이지로 이동
- goNamed : 기존 라우트 스택을 초기화시키고 해당 name 페이지로 이동
- push : routes에서 location으로 지정된 라우트로 이동, 라우트 스택에 추가
- pushNamed : routes에서 name으로 지정된 라우트로 이동, 라우트 스택에 추가
- pushReplacement : 스택에서 최상위 라우트를 주어진 location으로 교체,
  ex) a > b > c 에서 pushReplacement(b) 호출 : a > b > b

SubRoute
- sub route 이동은 path, name 등록 후
*/
void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: MyHomePage.routeName,
  routes: [
    GoRoute(
      name: MyHomePage.routeName,
      path: MyHomePage.routeName,
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      name: Screen1.routeName,
      path: Screen1.routeName,
      builder: (context, state) => Screen1(),
      routes: [
        GoRoute(
          name: "screen1-1",
          path: Screen1_1.routeName,
          builder: (context, state) => Screen1_1(),
          routes: [
            GoRoute(
                name: "screen1-1-1",
                path: Screen1_1_1.routeName,
                builder: (context, state) => Screen1_1_1(),
            )
          ]
        )
      ]
    ),
    GoRoute(
      path: Screen2.routeName,
      builder: (context, state) => Screen2(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const routeName = "/";
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    print("HOME:: ${router.namedLocation(routeName)}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Go Router!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
                GoRouter.of(context).push(Screen1.routeName);
              },
              child: const Text("button1")
            ),
            OutlinedButton(
              onPressed: () {
                context.go(Screen2.routeName);
              },
              child: const Text("button2")
            ),
          ],
        ),
      )
    );
  }
}
