import 'package:flutter/material.dart';
import 'package:insta_image_selector/widgets/widgets.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageGridView extends StatelessWidget {
  final List<AssetEntity> images;
  const ImageGridView({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    // final cubit = context.watch<FollowingAlbumCubit>();
    return images.isNotEmpty ? GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8
      ),
      itemBuilder: (context, index) {
        return ImageItem(
          asset: images[index],
          // TODO
          isSelected: false,//cubit.state.selectedImages.contains(images[index]),
          selectAsset: () {},//=> cubit.selectImage(images[index]),
        );
      },
    ) : Text("앨범에 사진이 없습니다.");
  }
}
