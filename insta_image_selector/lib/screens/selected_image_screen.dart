import 'dart:typed_data';

import 'package:flutter/material.dart';

class SelectedImageScreen extends StatefulWidget {
  final List<Uint8List> datas;
  const SelectedImageScreen({required this.datas, super.key});

  @override
  State<SelectedImageScreen> createState() => _SelectedImageScreenState();
}

class _SelectedImageScreenState extends State<SelectedImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.all(40),
        itemCount: widget.datas.length,
        itemBuilder: (context, index) {
          return Image.memory(widget.datas[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 40,),
      ),
    );
  }
}
