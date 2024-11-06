import 'package:flutter/material.dart';

class TapGestureDetector extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;

  const TapGestureDetector({
    this.onTap,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onTap,
      onLongPress: onTap,
      child: child,
    );
  }
}

class TapInkWell extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  final bool splash;

  const TapInkWell({
    this.onTap,
    required this.child,
    this.splash = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onTap,
      onLongPress: onTap,
      splashColor: Colors.transparent,
      splashFactory: splash ? null : NoSplash.splashFactory,
      child: child,
    );
  }
}
