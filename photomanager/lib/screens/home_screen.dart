import 'package:flutter/material.dart';
import 'package:photomanager/models/media.dart';
import 'package:photomanager/screens/picker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Media> _selectedMedias = [];

  Future<void> _handleFloatingActionButton() async {
    // Navigate to the picker Screen
    final List<Media>? result = await Navigator.push <List<Media>>(context,
      MaterialPageRoute(
        builder: (context) => PickerScreen(_selectedMedias),
      ),
    );

    if (result != null) {
      _updateSelectedMedias(result);
    }
  }

  _updateSelectedMedias(List<Media> result) {
    setState(() {
      _selectedMedias.clear();
      _selectedMedias.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Picker'),
      ),
      body: ListView.builder(
        itemCount: _selectedMedias.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _selectedMedias[index].widget,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleFloatingActionButton,
        child: const Icon(Icons.image_rounded),
      ),
    );
  }
}
