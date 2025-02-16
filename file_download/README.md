# file_download
### ImageGallerySaver와 Dio를 이용한 파일 다운로드

<details>
<summary>1. 이미지 다운로드</summary>

이미지 다운로드는 `image_gallery_saver`만 사용하여 할 수 있다.

`Dio`를 사용해서 이미지의 바이너리 데이터를 변수에 저장한 뒤 `ImageGallerySaver`의 `saveImage`메소드를 이용해서 이미지를 저장한다.

e.g.)
```dart
final response = await Dio().get(
    imageUrl,
    options: Options(responseType: ResponseType.bytes),
    onReceiveProgress: (count, total) {
      print("download :: ${(count/total * 100).getSmaller(100.0).toStringAsFixed(2)}%");
    },
);
final format = DateFormat("yyyy_MM_dd_HHmmss");
final name = "FILE_DOWNLOAD_DEMO_${format.format(DateTime.now())}";
final result = await ImageGallerySaver.saveImage(
  Uint8List.fromList(response.data),
  quality: 100,
  name: name,
);
```


</details>

<details>
<summary>2. 동영상 다운로드</summary>

동영상 다운로드는 `dio`와 `image_gallery_saver`의 기능이 둘 다 필요하다.
</details>


**사용 Library**
- [image_gallery_saver](https://pub.dev/packages/image_gallery_saver)
- [dio](https://pub.dev/packages/dio)
- [video_player](https://pub.dev/packages/video_player) ([videoplayer](https://github.com/K-Mose/Flutter_Feature/tree/master/videoplayer) 작업 사용)

### 참고
[DIO를 이용한 Progress Percentage 표시](https://medium.com/@masoud.saeedi.dev/file-upload-progress-percentage-using-flutter-retrofit-6836439772d7)

```dart
ProgressCallback = void Function(
	int count,
	int total
)
```

**ProgressCallback:** 데이터의 송수신을 리스닝하는 콜백 타입

count: 송수신 된 데이터의 길이를 표시

total: 송수신 될 데이터의 총 길이를 표시

진행률은 `count / total` 표시할 수 있음

e.g.) `double get percentage => ((total <= 0) ? 0.0 : count / total).getSmaller(1.0);`