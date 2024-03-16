import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';

class MoreItemDivider extends StatelessWidget {
  final double height;
  final double marginHorizontal;
  final bool isVisible;

  const MoreItemDivider({
    Key? key,
    this.height = 1,
    this.marginHorizontal = 16,
    this.isVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Container(
            margin: EdgeInsets.symmetric(
              horizontal: marginHorizontal,
            ),
            height: height,
            color: ColorSchemes.moreDivider,
          )
        : const SizedBox.shrink();
  }
}
