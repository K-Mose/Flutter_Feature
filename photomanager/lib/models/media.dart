import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

// DATA class
class Media {
  // photoManager로 관리되는 객체
  final AssetEntity assetEntity;
  // asset이 표시될 위젯
  final Widget widget;

  const Media({
    required this.assetEntity,
    required this.widget,
  });
}