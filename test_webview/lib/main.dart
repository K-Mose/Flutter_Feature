import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_mode/kiosk_mode.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // https://pub.dev/packages/kiosk_mode
  await startKioskMode();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // https://pub.dev/packages/webview_flutter/example
  final controller = WebViewController();

  Future<String> getDeviceId() async {
    final uuid = await UniqueIdentifier.serial;
    print("uuid:: $uuid");
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final deviceId = androidInfo.androidId ?? "null";
    print("deviceId :: $deviceId");
    controller.clearLocalStorage();
    await controller.runJavaScript("window.localStorage.setItem('deviceId', '$deviceId')");
    await controller.runJavaScript("alert('deviceId :: ' + localStorage.getItem('deviceId'))");
    print("deviceId :: $deviceId");
    return deviceId;
  }
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack, overlays: []);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..addJavaScriptChannel("tablet", onMessageReceived: (message) {
        
      })
      ..loadRequest(Uri.parse("https://dev-oms.seobuk.kr/tablet/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getDeviceId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          print("snapshot.data:: ${snapshot.data}");
          return Stack(
            children: [
              WebViewWidget(
                controller: controller
              )
            ],
          );
        }
      ),
    );
  }
}
