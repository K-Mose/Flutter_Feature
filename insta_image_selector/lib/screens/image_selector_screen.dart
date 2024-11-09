import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_image_selector/constants/colors.dart';
import 'package:insta_image_selector/screens/selected_image_screen.dart';
import 'package:insta_image_selector/state/image_provider.dart';
import 'package:screenshot/screenshot.dart';

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
  final ScrollController controller = ScrollController();
  // final List<ScreenshotController> ssControllers = [];

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
    final image = ref.watch(imageProvider);
    final isFulfilled = image.selectedImageList.isNotEmpty;
    final width = MediaQuery.of(context).size.width - 40;
    return Scaffold(
        appBar: AppBar(
            title: const Text("Photo Selector"),
            actions: [
              TapGestureDetector(
                onTap: isFulfilled ? () async {
                  final datas = await ref.read(imageProvider.notifier).captureImages();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return SelectedImageScreen(datas: datas);
                  },));
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
        body: Column(
          children: [
            Container(
              height: width,
              width: width,
              color: BG_COLOR,
              child: IndexedStack(
                index: ref.read(imageProvider.notifier).index,
                children: [
                  for (final img in image.selectedImageList)
                    img.widget,
                ],
              ),
            ),
            const SizedBox(height: 12,),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerStart,
              child: CommonDropdownWidget(
                items: image.albumList.map((album) => album.name).toList(),
                onTap: (album) async {
                  final selectedAlbum  = image.albumList.firstWhere((a) => a.name == album);
                  ref.read(imageProvider.notifier)
                    ..selectedAlbum = selectedAlbum
                    ..loadImages();
                },
              ),
            ),
            const SizedBox(height: 8,),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                physics: const ClampingScrollPhysics(),
                controller: controller,
                child: const ImageGridView(),
              ),
            ),
          ],
        ),
    );
  }
}
