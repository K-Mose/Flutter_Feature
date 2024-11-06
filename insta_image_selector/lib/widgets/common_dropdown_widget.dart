import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heartfield/constants/colors.dart';
import 'package:heartfield/constants/path.dart';
import 'package:heartfield/constants/text_style.dart';
import 'package:heartfield/presentation/common/widgets/widgets.dart';

class CommonDropdownWidget extends StatefulWidget {
  const CommonDropdownWidget({required this.items, this.onTap, this.width = 124, super.key,});

  final List<String> items;
  final void Function(String value)? onTap;
  final double width;

  @override
  State<CommonDropdownWidget> createState() => _CommonDropdownWidgetState();
}

class _CommonDropdownWidgetState extends State<CommonDropdownWidget> {
  String value = '';
  @override
  void initState() {
    super.initState();
    value = widget.items.first;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownMenu<String>(
        initialSelection: widget.items.first,
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
        textStyle: hfTextStyle.copyWith(
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
          for (final item in widget.items)
            DropdownMenuEntry(
              value: item,
              label: item,
              labelWidget: Container(
                color: BG_COLOR,
                child: HFText(item, style: hfTextStyle.copyWith(
                  fontSize: 12,
                )),
              ))
        ],
        onSelected: (value) {
          setState(() {
            if (value != null) {
              this.value = value;
              if (widget.onTap != null) {
                widget.onTap!(value);
              }
            }
          });
        },
      ),
    );
  }
}
