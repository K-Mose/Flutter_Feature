import 'package:flutter/material.dart';
import 'package:photomanager/models/media.dart';
import 'package:photomanager/widgets/media_item.dart';

class MediaGridView extends StatelessWidget {
  final List<Media> medias;
  final List<Media> selectedMedias;
  final Function(Media) selectMedia;

  final ScrollController scrollController;

  const MediaGridView({
    required this.medias,
    required this.selectedMedias,
    required this.selectMedia,
    required this.scrollController,
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: GridView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: medias.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3
        ),
        itemBuilder: (context, index) {
          return MediaItem(
            media: medias[index],
            isSelected: selectedMedias.any((e) => e.assetEntity.id == medias[index].assetEntity.id,),
            selectMedia: selectMedia,
          );
        },
      ),
    );
  }
}