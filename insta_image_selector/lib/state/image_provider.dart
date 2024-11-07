import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_image_selector/data/image_selector_entity.dart';
import 'package:photo_manager/photo_manager.dart';

class Image extends Notifier<ImageSelectorEntity> {

  @override
  ImageSelectorEntity build() {
    ref.onDispose(() {

    });
    return ImageSelectorEntity.empty();
  }

  @override
  set state(ImageSelectorEntity newState) => super.state = newState;

  void getAlum() async {
    print("getAlum");
    final req = await PhotoManager.requestPermissionExtend();
    print(req);
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();
    if (albums.isNotEmpty) {
      state = state.copyWith(
        albumList: albums
      );
    }
  }

  void loadImages() async {
    if (state.selectedAlbum != null ) {
      _fetchImages();
    }
  }

  void _fetchImages() async {
    try {
      final List<AssetEntity> imageList = await state.selectedAlbum!.getAssetListPaged(page: state.currentPage, size: 30);
      print("state.selectedAlbum:: ${state.selectedAlbum} // ${state.currentPage}");
      print("_fetchImages:: $imageList");
      state = state.copyWith(
        imageList: [...state.imageList, ...imageList],
        currentPage: state.currentPage + 1,
      );
    } catch (e) {
      debugPrint('Error fetching Media: $e');
    }
  }

  set selectedAlbum(AssetPathEntity albumn) => state = state.copyWith(selectedAlbum: albumn, currentPage: 0, imageList: []);

  void selectImage(AssetEntity image) {
    state = state.copyWith(
      selectedImageList: [...state.selectedImageList, image]
    );
  }

  void removeImage(AssetEntity image) {
    state = state.copyWith(
      selectedImageList: state.selectedImageList.where((i) => i != image).toList(),
    );
  }
}

final imageProvider = NotifierProvider<Image, ImageSelectorEntity> (Image.new);