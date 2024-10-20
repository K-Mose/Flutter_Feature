import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photomanager/screens/home_screen.dart';

// https://hemanthajay.medium.com/how-to-select-photos-and-videos-from-the-gallery-using-custom-media-asset-picker-a2909b64d8be
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}