import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/support/support_service.dart';
import 'package:city_eye/src/presentation/widgets/circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportServiceDetailsCardWidget extends StatelessWidget {
  final HomeSupport supportService;
  final Function(HomeSupport) onTap;
  final Color cardBackgroundColor;
  final Color iconBackgroundColor;
  final Color textColor;

  const SupportServiceDetailsCardWidget({
    Key? key,
    required this.supportService,
    required this.onTap,
    this.cardBackgroundColor = ColorSchemes.white,
    this.iconBackgroundColor = ColorSchemes.otpShadow,
    this.textColor = ColorSchemes.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(supportService),
      child: Container(
        width: 110,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            color: const Color.fromRGBO(241, 241, 241, 1),
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 32,
              color: Color.fromRGBO(0, 0, 0, 0.055),
            ),
          ],
          color: cardBackgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            CircularIcon(
              imagePath: supportService.logo != ""
                  ? supportService.logo
                  : ImagePaths.frame,
              backgroundColor: iconBackgroundColor,
              iconSize: 24,
              isNetworkImage: true,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                  blurRadius: 24,
                  color: Color.fromRGBO(23, 43, 77, 0.16),
                ),
              ],
              iconColor: ColorSchemes.primary,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              supportService.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor,
                    letterSpacing: -0.24,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
