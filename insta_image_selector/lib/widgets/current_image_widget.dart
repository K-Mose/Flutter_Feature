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
    // indexed stack에서 리스트 삭제 시 오류 발생, ValueKey 주기
    final key = ValueKey(image.id);
    final size = MediaQuery.of(context).size.width - 40;
    // orientatedSize: 회전된 화면에대한 사이즈, size와 반대로 나올 수 있다.
    // final width = image.orientatedWidth > image.orientatedHeight
    //     ? null
    //     : image.orientatedWidth > size ? size : image.orientatedWidth * 1.0;
    // final height = image.orientatedWidth > image.orientatedHeight
    //     ? image.orientatedHeight > size ? size : image.orientatedHeight * 1.0
    //     : null;
    final ratio = image.orientatedWidth < image.orientatedHeight ? image.orientatedHeight / image.orientatedWidth : image.orientatedWidth / image.orientatedHeight;
    final width = image.orientatedWidth > image.orientatedHeight ? size * ratio : size * 1.0;
    final height = image.orientatedWidth > image.orientatedHeight ? size * 1.0: size * ratio;
    return Container(
      key: key,
      height: size,
      width: size,
      color: Colors.black,
      child: Screenshot(
        controller: controller,
        child: InteractiveViewer(
          maxScale: 6,
          minScale: 0.1,
          constrained: false,
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Image(image: AssetEntityImageProvider(image), height: size, fit: BoxFit.fill,),
          ),
        ),),
    );
  }
}
