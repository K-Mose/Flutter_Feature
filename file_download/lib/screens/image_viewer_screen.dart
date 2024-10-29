import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:file_download/functions/extensions.dart';
import 'package:file_download/widgets/load_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';

class ImageViewerScreen extends StatefulWidget {
  const ImageViewerScreen({super.key});

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  OverlayEntry? overlayEntry;

  void createOverlay() {
    removeOverlay();
    overlayEntry = OverlayEntry(
      builder: (context) => Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.black.withAlpha(100),
          child: const LoadWidget(),
      ),
    );
    Overlay.of(context).insert(overlayEntry!);
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
  final tcImageUrl = TextEditingController();

  String imageUrl = "https://cdn.pixabay.com/photo/2017/12/03/22/11/winter-landscape-2995987_640.jpg";

  void _saveNetworkImage() async {
    createOverlay();
    try {
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
      print(result);
    } catch (e) {
      print(e);
    } finally {
      removeOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: _saveNetworkImage,
            icon: const Icon(Icons.download),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close_sharp,
                color: Colors.black,
              ),
            )
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: InteractiveViewer(
          child: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const LoadWidget(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tcImageUrl.text = '';
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: const Text("이미지 주소를 입력하세요", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
              content: TextField(
                controller: tcImageUrl,
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('확인'),
                  onPressed: () {
                    if (tcImageUrl.text.isNotEmpty) {
                      setState(() {
                        imageUrl = tcImageUrl.text;
                      });
                    } else {
                      tcImageUrl.text = '';
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },);
        },
        child: const Icon(Icons.image),
      ),
    );
  }
}
