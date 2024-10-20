import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  static const routeName = "/map_screen";

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapState();
}

class _MapState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("어느 스테이션?"),
      ),
      body: const Center(child: Text("지도"),),
    );
  }
}