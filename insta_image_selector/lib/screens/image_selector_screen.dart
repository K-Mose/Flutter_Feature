import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_image_selector/constants/colors.dart';
import 'package:insta_image_selector/state/image_provider.dart';

import 'package:insta_image_selector/widgets/widgets.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageSelectorScreen extends ConsumerStatefulWidget {

  const ImageSelectorScreen({super.key});

  @override
  ConsumerState<ImageSelectorScreen> createState() =>
      _ImageSelectorScreenState();
}

class _ImageSelectorScreenState extends ConsumerState<ImageSelectorScreen> {
  final key = GlobalKey();
  final ScrollController controller = ScrollController();

  late PageController pageViewController;

  void loadMoreMedias() {
    if (controller.position.atEdge && controller.position.pixels != 0) {
      print("loadMoreImage");
      ref.read(imageProvider.notifier).loadImages();
    }
  }

  @override
  void initState() {
    super.initState();
    pageViewController = PageController(initialPage: 0);
    ref.read(imageProvider.notifier).getAlum();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      controller.addListener(loadMoreMedias);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: load Medias
    final image = ref.watch(imageProvider);
    final isFulfilled = image.selectedImageList.isNotEmpty;
    final width = MediaQuery.of(context).size.width - 40;
    print("image.currentImage:: ${image.currentImage}");
    return Scaffold(
        appBar: AppBar(
            title: const Text("Photo Selector"),
            actions: [
              TapGestureDetector(
                onTap: isFulfilled ? () async {
                  // final result = await context.push<bool>(FollowingPostWriteScreenPath, extra: {'images': cubit.state.selectedImages});
                  // if (result != null && result && context.mounted) {
                  //   context.pop(true);
                  // }
                } : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: !isFulfilled ? BG_SECONDARY_COLOR : MAIN_COLOR,
                  ),
                  child: Text("NEXT", style: TextStyle(
                      color: !isFulfilled ? TEXT_SUB_COLOR : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600
                  ),),
                ),
              ),
              const SizedBox(width: 20,),
            ]
        ),
        body: SingleChildScrollView(
          // primary: false,
          padding: const EdgeInsets.all(20),
          physics: const ClampingScrollPhysics(),
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: width,
                width: width,
                color: BG_COLOR,
                child: (image.selectedImageList.isNotEmpty) ? Focus(
                  onFocusChange: (value) {
                    print("onFocusChange:: $value");
                  },
                  child: InteractiveViewer(
                    key: key,
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: AssetEntityImageProvider(
                        image.currentImage!,
                        // thumbnailSize: const ThumbnailSize.square(500),
                        isOriginal: false,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ) : Container(),
              ),
              const SizedBox(height: 32,),
              CommonDropdownWidget(
                items: image.albumList.map((album) => album.name).toList(),
                onTap: (album) async {
                  final selectedAlbum  = image.albumList.firstWhere((a) => a.name == album);
                  ref.read(imageProvider.notifier)
                      ..selectedAlbum = selectedAlbum
                      ..loadImages();
                },
              ),
              const SizedBox(height: 20,),
              const ImageGridView(),
            ],
          ),
        ),
    );
  }
}
