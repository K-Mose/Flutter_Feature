import 'package:flutter/material.dart';
import 'package:parallax_scroll_demo/data.dart';
import 'package:parallax_scroll_demo/list_item_widget.dart';

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final locationData in LocationData.getLocationData())
            ListItemWidget(locationData: locationData),
        ],
      ),
    );
  }
}
