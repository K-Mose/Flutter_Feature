import 'package:flutter/material.dart';

class PageMixScaleRotationTransition extends PageRouteBuilder {
  final dynamic page;

  PageMixScaleRotationTransition(this.page) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: animation,
        child: RotationTransition(
          turns: animation  ,
          child: child
        ),
      );
    }
  );
}