import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_image_selector/data/image_selector_entity.dart';
import 'package:photo_manager/photo_manager.dart';

class Image extends Notifier<ImageSelectorEntity> {

  bool isSelected(AssetEntity image) => state.selectedImageList.contains(image);

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
        albumList: albums,
        selectedAlbum: albums.first,
      );
      loadImages();
    }
  }

  void loadImages() async {
    print("state.selectedAlbum:: ${state.selectedAlbum}");
    if (state.selectedAlbum != null ) {
      _fetchImages();
    }
  }

  void _fetchImages() async {
    try {
      final List<AssetEntity> imageList = await state.selectedAlbum!.getAssetListPaged(page: state.currentPage, size: 9);
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

  void selectImage(AssetEntity image) =>
    (state.selectedImageList.contains(image) && state.currentImage == image)
        ? _removeImage(image)
        : (!state.selectedImageList.contains(image))
        ? state = state.copyWith(
            selectedImageList: [...state.selectedImageList, image],
            currentImage: image,
          )
        : state = state.copyWith(currentImage: image);


  void _removeImage(AssetEntity image) =>
      {
        state = state.copyWith(
          selectedImageList:
              state.selectedImageList.where((i) => i != image).toList(),
        ),
        _setCurrentImage()
      };

  void _setCurrentImage() =>
    state = state.copyWith(
        currentImage: state.selectedImageList.contains(state.currentImage) ? state.currentImage : state.selectedImageList.last
    );

}

final imageProvider = NotifierProvider<Image, ImageSelectorEntity> (Image.new);