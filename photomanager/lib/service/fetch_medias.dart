import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:photomanager/models/media.dart';
import 'package:photomanager/service/grant_permission.dart';
import 'package:transparent_image/transparent_image.dart';

Future<List<Media>> fetchMedias({
  required AssetPathEntity albums,
  required int page,
}) async {
  // List to hold the fetched media items
  List<Media> medias = [];

  try {
    // Get a list of asset entities from the specified album and page
    final List<AssetEntity> entities = await albums.getAssetListPaged(page: page, size: 30);

    // Loop through each asset entity and create corresponding Media objects
    for (var entity in entities) {
      Media media = Media(
        assetEntity: entity,
        widget: FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: AssetEntityImageProvider(
            entity,
            thumbnailSize: const ThumbnailSize.square(500),
            isOriginal: false,
          ),
          fit: BoxFit.cover,
        ),
      );

      // ADd tge created Media object to the list
      medias.add(media);
    }
  } catch (e) {
    debugPrint('Error fetching Media: $e');
  }
  return medias;
}