import 'package:insta_image_selector/data/image_entity.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageSelectorEntity {
  const ImageSelectorEntity({
    required this.albumList,
    this.selectedAlbum,
    required this.imageList,
    required this.selectedImageList,
    this.currentImage,
    required this.currentPage,
  });

  final List<AssetPathEntity> albumList;
  final AssetPathEntity? selectedAlbum;
  final List<AssetEntity> imageList;
  final List<ImageEntity> selectedImageList;
  final ImageEntity? currentImage;
  final int currentPage;

  factory ImageSelectorEntity.empty() =>
      const ImageSelectorEntity(
        albumList: [],
        selectedAlbum: null,
        imageList: [],
        selectedImageList: [],
        currentImage: null,
        currentPage: 0,
      );

  ImageSelectorEntity copyWith({
    List<AssetPathEntity>? albumList,
    AssetPathEntity? selectedAlbum,
    List<AssetEntity>? imageList,
    List<ImageEntity>? selectedImageList,
    ImageEntity? currentImage,
    int? currentPage,
  }) {
    return ImageSelectorEntity(
      albumList: albumList ?? this.albumList,
      selectedAlbum: selectedAlbum ?? this.selectedAlbum,
      imageList: imageList ?? this.imageList,
      selectedImageList: selectedImageList ?? this.selectedImageList,
      currentImage: currentImage ?? this.currentImage,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}