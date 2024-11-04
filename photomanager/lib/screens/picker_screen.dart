import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photomanager/models/media.dart';
import 'package:photomanager/service/fetch_albums.dart';
import 'package:photomanager/service/fetch_medias.dart';
import 'package:photomanager/widgets/media_grid_view.dart';

class PickerScreen extends StatefulWidget {
  final List<Media> selectedMedias;
  const PickerScreen(this.selectedMedias, {super.key});

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  final List<Media> _selectedMedias = [];

  AssetPathEntity? _currentAlbum;
  List<AssetPathEntity> _albums = [];

  void _loadAlbums() async {
    List<AssetPathEntity> albums = await fetchAlbums();
    print("_loadAlbums:: $albums");
    if (albums.isNotEmpty) {
      setState(() {
        _currentAlbum = albums.first;
        print("_currentAlbum:: $_currentAlbum");
        _albums = albums;
      });

      // Load Media items for the current album
      _loadMedias();
    }
  }
  
  final List<Media> _medias = [];
  int _lastPage = 0;
  int _currentPage = 0;
  
  void _loadMedias() async {
    _lastPage = _currentPage;
    if (_currentAlbum != null) {
      List<Media> medias = await fetchMedias(album: _currentAlbum!, page: _currentPage);

      setState(() {
        _medias.addAll(medias);
      });
    }
  }

  @override
  void initState() {
    _selectedMedias.addAll(widget.selectedMedias);
    _loadAlbums();
    super.initState();
    _scrollController.addListener(_loadMoreMedias);
  }

  final ScrollController _scrollController = ScrollController();

  // Method to load more media items when scrolling
  void _loadMoreMedias() {
    if (_scrollController.position.pixels / _scrollController.position.maxScrollExtent > 0.33) {
      if (_currentPage != _lastPage) {
        _loadMedias();
      }
    }
  }

  void _selectMedia(Media media) {
    bool isSelected = _selectedMedias.any((e) => e.assetEntity.id == media.assetEntity.id);
    print("_selectMedia:: ${media.assetEntity.title} // $isSelected");
    setState(() {
      if (isSelected) {
        _selectedMedias.removeWhere((e) => e.assetEntity.id == media.assetEntity.id);
      } else {
        _selectedMedias.add(media);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build:: _currentAlbum :: $_currentAlbum");
    print("build:: _album :: $_albums");
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<AssetPathEntity>(
          borderRadius: BorderRadius.circular(16.0),
          value: _currentAlbum,
          items: _albums
              .map(
                (e) => DropdownMenuItem<AssetPathEntity>(
              value: e,
              child: Text(e.name.isEmpty ? "0" : e.name),
            ),
          )
              .toList(),
          onChanged: (value) {
            setState(() {
              _currentAlbum = value;
              _currentPage = 0;
              _lastPage = 0;
              _medias.clear();
            });
            // Load media items  for the selected album
            _loadMedias();
            _scrollController.jumpTo(0.0);
          },
        ),
      ),
      body: Container(
        child: MediaGridView(
          medias: _medias,
          selectedMedias: _selectedMedias,
          selectMedia: _selectMedia,
          scrollController: _scrollController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context, _selectedMedias),
        child: const Icon(Icons.check_rounded),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreMedias);
    _scrollController.dispose();
    super.dispose();
  }
}
