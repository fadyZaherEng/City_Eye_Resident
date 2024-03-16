import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/support/support_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonSupportServiceCardWidget extends StatelessWidget {
  const SkeletonSupportServiceCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: ColorSchemes.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                  blurRadius: 32,
                  color: Color.fromRGBO(0, 0, 0, 0.12))
            ],
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border: Border.fromBorderSide(
              BorderSide(
                color: Color.fromRGBO(222, 222, 222, 1),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  shape: BoxShape.circle,
                  maxHeight: 20,
                  maxWidth: 20,
                  width: 20,
                  height: 20),
            ),
          ),
        ),
        const SizedBox(
          height: 8
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 5,
                width: 70,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 5,
                width: 50,
                alignment: Alignment.center,
              ),
            ),
          ],
        )
      ],
    );
  }
}
