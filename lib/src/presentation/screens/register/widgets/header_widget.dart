import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderWidget extends StatelessWidget {
  final Function()? backButtonAction;
  final bool hasBackButton;
  final String title;
  const HeaderWidget({
    Key? key,
    required this.hasBackButton,
    this.backButtonAction,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 64),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: hasBackButton
                    ? backButtonAction
                    : () {
                        Navigator.pop(context);
                      },
                child: SvgPicture.asset(
                  ImagePaths.backArrow,
                  height: 24,
                  matchTextDirection: true,
                ),
              ),
              const SizedBox(width: 29),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorSchemes.black,
                      fontSize: 24,
                      letterSpacing: -0.24,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
