import 'package:flutter/material.dart';
import 'package:imgextract_test/screens/extract_text_screen.dart';
import 'package:imgextract_test/screens/resizable_rect_screen.dart';
import 'package:imgextract_test/screens/screenshot_screen.dart';

void main() {
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
      home: const HomeScreen(),
    );
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 120,),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResizableRectScreen(),));
              },
              child: const Text("Resizable Rectangle"),
            ),
            const SizedBox(height: 120,),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ScreenshotScreen(),));
              },
              child: const Text("Screenshot"),
            ),
            const SizedBox(height: 120,),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ExtractTextScreen(),));
              },
              child: const Text("ExtractText"),
            ),
          ],
        ),
      ),
    );
  }
}
