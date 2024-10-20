import 'package:flutter/material.dart';

// https://stackoverflow.com/questions/60924384/creating-resizable-view-that-resizes-when-pinch-or-drag-from-corners-and-sides-i
class ResizableRectScreen extends StatefulWidget {
  const ResizableRectScreen({super.key});

  @override
  State<ResizableRectScreen> createState() => _ResizableRectScreenState();
}

class _ResizableRectScreenState extends State<ResizableRectScreen> {
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          const SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
          ),
          Positioned(
            top: top,
            left: left,
            child: GestureDetector(
              onPanStart: _handleDrag,
              onPanUpdate: _handleUpdate,
              child: Container(
                height: height,
                width: width,
                color: Colors.grey,
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
              child: TapCorner(
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
              child: TapCorner(
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
              child: TapCorner(
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
              child: TapCorner(
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
    );
  }
}

class TapCorner extends StatefulWidget {
  final Function(double dx, double dy) onDrag;
  const TapCorner({required this.onDrag, super.key});

  @override
  State<TapCorner> createState() => _TapCornerState();
}

class _TapCornerState extends State<TapCorner> {
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
