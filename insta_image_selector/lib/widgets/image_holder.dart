import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageHolder extends StatelessWidget {
  final AssetEntity entity;
  const ImageHolder(this.entity, {super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      image: AssetEntityImageProvider(
        entity,
        thumbnailSize: const ThumbnailSize.square(500),
        isOriginal: false,
      ),
      fit: BoxFit.cover,
    );
  }
}
