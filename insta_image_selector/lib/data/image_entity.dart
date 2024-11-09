import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:screenshot/screenshot.dart';

class ImageEntity {
  const ImageEntity({
    required this.image,
    required this.widget,
    required this.screenshotController,
  });

  final AssetEntity image;
  final Widget widget;
  final ScreenshotController screenshotController;
}