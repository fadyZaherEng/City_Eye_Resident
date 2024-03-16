import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar buildAppBarWidget(
  BuildContext context, {
  required String title,
  required bool isHaveBackButton,
  Function()? onBackButtonPressed,
  Color backgroundColor = ColorSchemes.white,
  Color textColor = ColorSchemes.black,
  Widget actionWidget = const SizedBox.shrink(),
  String imagePath = "",
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    title: imagePath.isEmpty
        ? Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                letterSpacing: -0.24,
                fontWeight: FontWeight.w600,
                color: textColor),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        : SvgPicture.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
    centerTitle: true,
    actions: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          actionWidget,
        ],
      )
    ],
    leading: isHaveBackButton
        ? InkWell(
            onTap: onBackButtonPressed ?? () {},
            child: SvgPicture.asset(
              ImagePaths.backArrow,
              matchTextDirection: true,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
              color: textColor,
            ),
          )
        : const SizedBox.shrink(),
  );
}
