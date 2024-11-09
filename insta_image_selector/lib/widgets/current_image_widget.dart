import 'package:flutter/material.dart';
import 'package:insta_image_selector/constants/colors.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:transparent_image/transparent_image.dart';

class CurrentImageWidget extends StatelessWidget {
  final AssetEntity image;
  final ScreenshotController controller;
  const CurrentImageWidget({required this.image,required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 100;
    return Container(
      height: width,
      width: width,
      color: BG_COLOR,
      child: Screenshot(
        controller: controller,
        child: InteractiveViewer(
          child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: AssetEntityImageProvider(
              image,
              isOriginal: true,
            ),
            fit: BoxFit.contain,
          ),
        ),),
    );
  }
}
