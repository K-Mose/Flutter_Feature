import 'package:flutter/material.dart';

class LoadWidget extends StatelessWidget {
  const LoadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
