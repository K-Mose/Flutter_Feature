import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:path/path.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();


  WindowOptions windowOptions = const WindowOptions(
    size: Size(400, 300),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State createState() => _MainState();
}

class _MainState extends State<MainScreen> {

  String selectedFilePath = "";
  String selectedFolderPath = "";

  String destinationPath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Test"),
      ),
      body: Container(
        width: double.maxFinite,
        color: Colors.white,
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    )
                  ),
                  onPressed: () async {
                    final selectedFile =
                      await FilePicker.platform.pickFiles();
                    setState(() {
                      selectedFilePath = selectedFile?.paths[0] ?? "";
                    });
                  },
                  child: const Text("choose the file"),
                ),
                const SizedBox(width: 10,),
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    )
                  ),
                  onPressed: () async {
                    final directoryPath = await
                    FilePicker.platform.getDirectoryPath();
                    print("directoryPath: $directoryPath");
                    setState(() {
                      destinationPath = directoryPath ?? "";
                    });
                  },
                  child: const Text("choose destination"),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Text("Path: $selectedFilePath"),
            const SizedBox(height: 8,),
            Row(
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      )
                  ),
                  onPressed: () async {
                    final baseName = path.basename(selectedFilePath);
                    print(selectedFilePath);
                    print(destinationPath);
                    print(baseName);
                    File(selectedFilePath).copy("$destinationPath\\$baseName");
                  },
                  child: const Text("copy"),
                ),
                const SizedBox(width: 10,),
                OutlinedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      )
                  ),
                  onPressed: () async {
                    final directoryPath = await
                    FilePicker.platform.getDirectoryPath();
                    print("directoryPath: $directoryPath");
                    setState(() {
                      selectedFolderPath = directoryPath ?? "";
                    });
                  },
                  child: const Text("delete the copied file"),
                ),
              ],
            ),
            Text("Copied Path: $destinationPath"),
          ],
        ),
      ),
    );
  }
}