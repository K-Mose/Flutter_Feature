import 'package:flutter/material.dart';

class PageMixSizeFadeTransition extends PageRouteBuilder {
  final dynamic page;

  PageMixSizeFadeTransition(this.page) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return Align(
        alignment: Alignment.center,
        child: SizeTransition(
          axis: Axis.horizontal,
          axisAlignment: 0,
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: child
          ),
        ),
      );
    }
  );
}