import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photomanager/service/grant_permission.dart';

Future<List<AssetPathEntity>> fetchAlbums() async {
  try {
    await granPermissions();

    // fetch the list of asset path
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();

    return albums;
  } catch (e) {
    debugPrint('Error fetching albums: $e');
    return [];
  }
}