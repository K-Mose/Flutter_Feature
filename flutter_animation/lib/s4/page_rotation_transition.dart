import 'package:flutter/material.dart';

class PageRotationTransition extends PageRouteBuilder {
  final dynamic page;

  PageRotationTransition(this.page) : super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        double begin = 0.0;
        double end = 1.0;
        return RotationTransition(
          turns: Tween<double>(
            begin: begin,
            end: end,
          ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.linear,
              )
          ),
          child: child,
        );
      }
  );
}
