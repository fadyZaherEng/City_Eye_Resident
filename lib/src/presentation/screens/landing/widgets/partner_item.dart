import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PartnerItem extends StatelessWidget {
  final String image;

  const PartnerItem({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.network(
          image,
          height: 40,
          color: ColorSchemes.primary,
        ),
        // Image.network(
        //   image,
        //   fit: BoxFit.scaleDown,
        //   height: 40,
        //   errorBuilder: (context, error, stackTrace) {
        //     return Image.asset(
        //       ImagePaths.one,
        //       fit: BoxFit.scaleDown,
        //       height: 40,
        //     );
        //   },
        // ),
        const SizedBox(
          width: 24,
        ),
      ],
    );
  }
}
