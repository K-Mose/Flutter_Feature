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
    final size = MediaQuery.of(context).size.width - 40;
    // orientatedSize: 회전된 화면에대한 사이즈, size와 반대로 나올 수 있다.
    final width = image.orientatedWidth > image.orientatedHeight ? null : size;
    final height = image.orientatedWidth > image.orientatedHeight ? size : null;
    return Container(
      height: size,
      width: size,
      color: Colors.black,
      child: Screenshot(
        controller: controller,
        child: InteractiveViewer(
          maxScale: 3,
          minScale: 0.1,
          constrained: false,
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Image(image: AssetEntityImageProvider(image),),
          ),
        ),),
    );
  }
}
