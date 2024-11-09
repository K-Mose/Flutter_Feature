import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_image_selector/constants/colors.dart';
import 'package:insta_image_selector/constants/path.dart';
import 'package:insta_image_selector/state/image_provider.dart';

class CommonDropdownWidget extends ConsumerWidget {
  const CommonDropdownWidget({required this.items, this.onTap, this.width = 124, super.key,});

  final List<String> items;
  final void Function(String value)? onTap;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(imageProvider);
    final items = images.albumList;
    return SizedBox(
      child: DropdownMenu<String>(
        initialSelection: images.albumList.firstOrNull?.name,
        trailingIcon: SvgPicture.asset(PATH_ICON_ARROW_DOWN, width: 16, fit: BoxFit.fitWidth,),
        selectedTrailingIcon: SizedBox(height: 16, child: SvgPicture.asset(PATH_ICON_ARROW_UP, width: 16, fit: BoxFit.fitWidth,)),
        inputDecorationTheme: InputDecorationTheme(
          constraints: const BoxConstraints(maxHeight: 32, minHeight: 32),
          fillColor: BG_COLOR,
          contentPadding: const EdgeInsets.symmetric(vertical:8, horizontal: 12),
          border: OutlineInputBorder(
            // borderSide: const BorderSide(color: DIVIDER_COLOR),
            borderRadius: BorderRadius.circular(100)
          )
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        menuStyle: MenuStyle( 
          backgroundColor: MaterialStateProperty.all(BG_COLOR),
          surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(DIVIDER_COLOR),
          elevation: MaterialStateProperty.all(5),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        ),
        dropdownMenuEntries: [
          for (final item in items)
            DropdownMenuEntry(
              value: item.name,
              label: item.name,
              labelWidget: Container(
                color: BG_COLOR,
                child: Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
        onSelected: (value) {
          if (value != null && onTap != null) {
            onTap!(value);
          }
        },
      ),
    );
  }
}
