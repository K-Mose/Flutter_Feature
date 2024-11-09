import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_image_selector/state/image_provider.dart';
import 'package:insta_image_selector/widgets/widgets.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageGridView extends ConsumerWidget {
  // final List<AssetEntity> images;
  const ImageGridView({super.key/*, required this.images*/});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(imageProvider);
    return images.imageList.isNotEmpty ? GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.imageList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8
      ),
      itemBuilder: (context, index) {
        final image = images.imageList[index];
        final notifier = ref.read(imageProvider.notifier);
        return ImageItem(
          asset: image,
          // TODO
          isSelected: notifier.isSelected(image),
          selectAsset: () => notifier.selectImage(image),
        );
      },
    ) : Text("앨범에 사진이 없습니다.");
  }
}
