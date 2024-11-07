import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_image_selector/constants/path.dart';
import 'package:insta_image_selector/widgets/widgets.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageItem extends StatelessWidget {
  final AssetEntity asset;
  final bool isSelected;
  final Function() selectAsset;

  const ImageItem({
    super.key,
    required this.asset,
    required this.isSelected,
    required this.selectAsset,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectAsset,
      child: Stack(
        children: [
          _buildAssetWidget(),
          if (isSelected) ..._buildIsSelectedOverlay(),
        ],
      ),
    );
  }

  Widget _buildAssetWidget() {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ImageHolder(asset),
      ),
    );
  }

  List<Widget> _buildIsSelectedOverlay() {
    return [
      Container(
        color: Colors.black.withOpacity(0.4),
      ),
      Positioned(
        bottom: 8,
        right: 8,
        child: Center(
          child: SvgPicture.asset(PATH_CHECKBOX_CHECKED),
        ),
      )
    ];
  }
}
