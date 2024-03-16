import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsItemWidget extends StatelessWidget {
  final String image;
  final String text;
  final Function() onTap;
  final bool haveLeading;
  final Widget? leading;
  final Color? textColor;

  const SettingsItemWidget({
    Key? key,
    required this.image,
    required this.text,
    required this.onTap,
    this.haveLeading = false,
    this.leading,
    this.textColor = ColorSchemes.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
        ),
        const SizedBox(
          width: 12,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: textColor,
                ),
          ),
        ),
        const Spacer(),
        haveLeading == true && leading != null ? leading! : const SizedBox()
      ],
    );
  }
}
