import 'package:flutter/material.dart';

class PageSlideTransition extends PageRouteBuilder {
  final dynamic page;

  PageSlideTransition(this.page) : super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0), // 왼쪽에서 오른쪽으로
              // begin: const Offset(1.0, 0.0), // 오른쪽에서 왼쪽으로
              // begin: const Offset(0.0, 1.0), // 위에서 아래로
              // begin: const Offset(0.0, -1.0), // 아래서 위로
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )
            ),
            child: child,
        );
      }
  );
}
