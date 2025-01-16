import 'package:flutter/cupertino.dart';

class MyNavigatorObserver extends NavigatorObserver {

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    print('MyNavigatorObserver:: Push :: ${previousRoute?.settings.name} -> ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    print('MyNavigatorObserver:: Pop :: ${route.settings.name} -> ${previousRoute?.settings.name}');
  }
}