# photomanager
[photo_manager](https://pub.dev/packages/photo_manager) 패키지를 사용한 이미지 선택

### Preview 
https://github.com/user-attachments/assets/81db17ab-0606-488a-b0e2-c603fa77c384

### Useage 
**앨범에서 파일 가져오는 단계**
1. `AssetPathEntity`객체로 휴대폰 앨범 리스트를 가져옴
  `List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();`

2. 앨범 리스트에서 선택된 앨범안에서 `AssetEntity`객체의 미디어 리스트를 가져옴
   `final List<AssetEntity> entities = await album.getAssetListPaged(page: page, size: 30);`
   
3. `AssetEntityImageProvider`로 이미지 객체 정보를 가져와서 `FadeImage`로 렌더링
     ```dart 
     FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: AssetEntityImageProvider(
          entity,
          thumbnailSize: const ThumbnailSize.square(500),
          isOriginal: false,
        ),
        fit: BoxFit.cover,
      ),
     ```

### Ref. 
1. [How to Select Photos and Viedos From the Gallery Using Custom Media/Asset Picker ](https://hemanthajay.medium.com/how-to-select-photos-and-videos-from-the-gallery-using-custom-media-asset-picker-a2909b64d8be)
2. [Android 저장소 사용 사례 및 권장사항](https://developer.android.com/training/data-storage/use-cases?hl=ko)
