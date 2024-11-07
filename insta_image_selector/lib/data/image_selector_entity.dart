import 'package:photo_manager/photo_manager.dart';

class ImageSelectorEntity {
  const ImageSelectorEntity({
    required this.albumList,
    required this.selectedAlbum,
    required this.imageList,
    required this.selectedImageList,
    required this.currentPage,
  });

  final List<AssetPathEntity> albumList;
  final AssetPathEntity? selectedAlbum;
  final List<AssetEntity> imageList;
  final List<AssetEntity> selectedImageList;
  final int currentPage;

  factory ImageSelectorEntity.empty() =>
      const ImageSelectorEntity(
        albumList: [],
        selectedAlbum: null,
        imageList: [],
        selectedImageList: [],
        currentPage: 0,
      );

  ImageSelectorEntity copyWith({
    List<AssetPathEntity>? albumList,
    AssetPathEntity? selectedAlbum,
    List<AssetEntity>? imageList,
    List<AssetEntity>? selectedImageList,
    int? currentPage,
  }) {
    return ImageSelectorEntity(
      albumList: albumList ?? this.albumList,
      selectedAlbum: selectedAlbum ?? this.selectedAlbum,
      imageList: imageList ?? this.imageList,
      selectedImageList: selectedImageList ?? this.selectedImageList,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}