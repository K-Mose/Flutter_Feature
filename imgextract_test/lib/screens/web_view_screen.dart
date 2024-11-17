import 'package:flutter/material.dart';
import 'package:imgextract_test/widgets/image_cropper_widget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final ScreenshotController controller = ScreenshotController();
  final WebViewController webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final uri = Uri.parse('https://dart.dev/guides');
      webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          print("url:: $url");
        },
      ))
      ;
      await webViewController.loadRequest(uri);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: controller,
        child: WebViewWidget(
          controller: webViewController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await controller.capture();
          if (data == null || !context.mounted) return;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageCropperWidget(data),));
        },
        child: const Icon(Icons.crop),
      ),
    );
  }
}
