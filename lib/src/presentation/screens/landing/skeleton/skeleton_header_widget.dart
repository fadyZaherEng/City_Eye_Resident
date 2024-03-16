import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonHeaderWidget extends StatelessWidget {
  const SkeletonHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
        start: 16,
      ),
      decoration: BoxDecoration(
        color: ColorSchemes.primary.withOpacity(0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16,),
          SkeletonLine(
            style: SkeletonLineStyle(
              width: 100,
              height: 10,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SkeletonLine(
            style: SkeletonLineStyle(
              width: 100,
              height: 5,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 80,
                  height: 40,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(
                width: 32,
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                  width: 80,
                  height: 10,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
