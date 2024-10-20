import 'package:flutter/material.dart';

class PageScaleTransition extends PageRouteBuilder {
  final dynamic page;

  PageScaleTransition(this.page) : super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        double begin = animation.status == AnimationStatus.reverse ? 0.0 : 10.0;
        double end = 1.0;
        return ScaleTransition(
            scale: Tween<double>(
              begin: begin,
              end: end,
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
