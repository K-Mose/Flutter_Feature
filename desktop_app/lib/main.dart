import 'package:flutter/material.dart';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController(
    text: 'https://example.com',
  );

  bool? _webviewAvailable;
  late Webview _webview;

  // 웹뷰 초기화
  @override
  void initState() {
    super.initState();
    WebviewWindow.isWebviewAvailable().then((value) {
      setState(() {
        _webviewAvailable = value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(controller: _controller),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _webviewAvailable != true ? null : _onTap,
                  child: const Text('Open'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () async {
                    await WebviewWindow.clearAll(
                      userDataFolderWindows: await _getWebViewPath(),
                    );
                    debugPrint('clear complete');
                  },
                  child: const Text('Clear all'),
                ),
                TextButton(onPressed: () {
                  _webview.postWebMessageAsJson("webMessage");
                }, child: const Text("SEND DATA")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() async {

    final webview = await WebviewWindow.create(
      configuration: CreateConfiguration(
        userDataFolderWindows: await _getWebViewPath(),
        windowHeight: 1920,
        windowWidth: 1080,
        title: "Local HTML",
        titleBarHeight: 0,
      ),
    );
    setState(() {
      _webview = webview;
    });
    _webview.registerJavaScriptMessageHandler("name", (name, body) {
      print("name: $name \n body : $body");
    });
    _webview
      ..setBrightness(Brightness.dark)
      ..setApplicationNameForUserAgent(" WebviewExample/1.0.0")
      // ..launch(_controller.text)
      // Local html 로드
      ..launch("file:///C:/developments/flutter/desktop_app/assets/test.html")
      ..addOnUrlRequestCallback((url) {
        debugPrint('url: $url');
        final uri = Uri.parse(url);
        if (uri.path == '/login_success') {
          debugPrint('login success. token: ${uri.queryParameters['token']}');
          _webview.close();
        }
      })
      ..onClose.whenComplete(() {
        debugPrint("on close");
      })
      ..addOnWebMessageReceivedCallback((message) {
        print("web message : $message");
      });
  }
}

Future<String> _getWebViewPath() async {
  final document = await getApplicationDocumentsDirectory();
  print("currnt doucment :: ${document.path}");
  return p.join(
    document.path,
    'desktop_webview_window',
  );
}