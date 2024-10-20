import 'package:flutter/widgets.dart';

class MyFab {
  MyFab({required this.icon, required this.color, required this.onPress, required this.description, this.animation});

  final IconData icon;
  final Color color;
  final String description;
  final void Function(BuildContext context) onPress;
  // final VoidCallback onPress;
  Animation<double>? animation;

  set setAnimation(Animation<double> animation) {
    this.animation = animation;
  }
}