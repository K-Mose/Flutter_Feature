import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';

class ImageCropperWidget extends StatefulWidget {
  final Uint8List image;
  const ImageCropperWidget(this.image, {super.key});

  @override
  State<ImageCropperWidget> createState() => _ImageCropperWidgetState();
}

class _ImageCropperWidgetState extends State<ImageCropperWidget> {

  double height = 100;
  double width = 100;

  double top = 100;
  double left = 100;

  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    setState(() {
      // setState(() {
      top = top + dy;
      left = left + dx;
    });
    // });
  }

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: _width,
        height: _height,
        child: Stack(
          children: [
            Image.memory(widget.image, fit: BoxFit.contain,),
            Positioned(
                top: top,
                left: left,
                child: GestureDetector(
                  onPanStart: _handleDrag,
                  onPanUpdate: _handleUpdate,
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        width: 2,
                        color: Colors.redAccent,
                      )
                    ),
                  ),
                )
            ),
            // Top left
            Positioned(
              top: top - 5,
              left: left -5 ,
              child: Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black, width: 2),
                    left: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: _TapCorner(
                  onDrag: (dx, dy) {
                    double newHeight = height - dy;
                    double newWidth = width - dx;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                      top = top + dy;
                      left = left + dx;
                    });
                  },
                ),
              ),
            ),
            // top right
            Positioned(
              top: top - 5,
              left: left + width -5 ,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black, width: 2),
                    right: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: _TapCorner(
                  onDrag: (dx, dy) {
                    double newHeight = height - dy;
                    double newWidth = width + dx;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                      top = top + dy;
                      left = left;
                    });
                  },
                ),
              ),
            ),
            // bottom left
            Positioned(
              top: top + height - 5,
              left: left - 5 ,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 2),
                    left: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: _TapCorner(
                  onDrag: (dx, dy) {;
                  var newHeight = height + dy;
                  var newWidth = width - dx;

                  setState(() {
                    height = newHeight > 0 ? newHeight : 0;
                    width = newWidth > 0 ? newWidth : 0;
                    top = top;
                    left = left + dx;
                  });
                  },
                ),
              ),
            ),
            // bottom right
            Positioned(
              top: top + height - 5,
              left: left + width - 5,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 2),
                    right: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: _TapCorner(
                  onDrag: (dx, dy) {
                    double newHeight = height + dy;
                    double newWidth = width + dx;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                      top = top;
                      left = left;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final _width = MediaQuery.of(context).size.width;
          final _height = MediaQuery.of(context).size.height;
          print("initX//initY:: $initX // $initY}");
          print("top // left:: $top // $left}");
          print("top // left:: ${top.toInt()} // ${left.toInt()}}");
          print("height // width:: $height // $width}");
          print("height // width:: ${height.toInt()} // ${width.toInt()}}");
          final src = img.decodePng(widget.image,);
          if (src == null) return;
          print("size:: width // height:: ${src.width} // ${src.height}}");
          final wRatio = src.width / _width;
          final hRatio = src.height / _height;
          print("ratio:: $wRatio // $hRatio}");
          print((left + 2) * hRatio);
          print((top + 5) * wRatio);
          print(width * wRatio);
          print(height * hRatio);
          final i = img.copyCrop(src,
              x: ((left) * wRatio).toInt(),
              y: ((top) * wRatio).toInt(),
              width: (width * wRatio).toInt(),
              height: ((height) * wRatio).toInt());
          final _image = Image.memory(img.encodePng(i, singleFrame: true));
          print("image");
          print(i.width);
          print(i.height);
          showDialog(context: context, builder: (context) => Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.black)
            ),
            child: _image,
          ),);
        },
        child: const Icon(Icons.abc),
      ),
    );
  }
}

class _TapCorner extends StatefulWidget {
  final Function(double dx, double dy) onDrag;
  const _TapCorner({required this.onDrag, super.key});

  @override
  State<_TapCorner> createState() => _TapCornerState();
}

class _TapCornerState extends State<_TapCorner> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: 10,
        height: 10,
        color: Colors.transparent,
      ),
    );
  }
}
