import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextWithIconWidget extends StatelessWidget {
  final String text;
  final String imagePath;

  const TextWithIconWidget({
    Key? key,
    required this.text,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          imagePath,
          fit: BoxFit.scaleDown,
          width: 20,
          height: 20,
          color: ColorSchemes.gray,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            letterSpacing: -0.24,
            color: ColorSchemes.gray,
          ),
        ),
      ],
    );
  }
}
