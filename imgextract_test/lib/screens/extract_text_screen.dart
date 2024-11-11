import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ExtractTextScreen extends StatefulWidget {
  const ExtractTextScreen({super.key});

  @override
  State<ExtractTextScreen> createState() => _ExtractTextScreenState();
}

class _ExtractTextScreenState extends State<ExtractTextScreen> {

  String extractedText = '';
  File? selectedImage;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedImage == null) {
      return;
    } else if (mounted) {
      final image = File(pickedImage.path);
      selectedImage = image;
      setState(() {});
      extractText(image);
    }
  }

  void extractText(File image) async {
    try {
      // script에 번역할 언어 설정.
      TextRecognizer textRecognizer = TextRecognizer(script: TextRecognitionScript.korean);
      // textRecognizer에서 추출을 실행
      final process = await textRecognizer.processImage(InputImage.fromFile(image));
      extractedText = process.text;
      setState(() {});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Extract Image"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.white,
              alignment: Alignment.center,
              child: selectedImage != null ? Image.file(selectedImage!) : null,
            ),
            const SizedBox(height: 40,),
            OutlinedButton(
              onPressed: _pickImage,
              child: const Text("Select Image"),
            ),
            const SizedBox(height: 40,),
            Text(extractedText),
          ],
        ),
      ),
    );
  }
}
