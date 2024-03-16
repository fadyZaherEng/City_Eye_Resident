import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonSurveyCardWidget extends StatelessWidget {
  const SkeletonSurveyCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorSchemes.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: ColorSchemes.lightGray,
            blurRadius: 32,
            offset: (Offset(0, 4)),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 10,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
          ),
          _defaultSize(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 24,
                      width: 24,
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.circle),
                ),
                const SizedBox(width: 5),
                const SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 5,
                    width: 50,
                  ),
                ),
                const SizedBox(width: 16),
                const SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 5,
                    width: 100,
                  ),
                ),
              ],
            ),
          ),
          _defaultSize(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Divider(
              color: ColorSchemes.lightGray,
              height: 1,
            ),
          ),
          _defaultSize(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 30,
                      width: 80,
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle),
                ),
                const SizedBox(width: 32),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 30,
                      width: 80,
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle),
                ),
                const SizedBox(width: 32),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 30,
                      width: 80,
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  SizedBox _defaultSize() {
    return const SizedBox(height: 13);
  }
}
