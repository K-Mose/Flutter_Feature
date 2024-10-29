import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatefulWidget {
  const ImageViewerScreen({super.key});

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  final tcImageUrl = TextEditingController();

  String imageUrl = "https://cdn.pixabay.com/photo/2017/12/03/22/11/winter-landscape-2995987_640.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
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
