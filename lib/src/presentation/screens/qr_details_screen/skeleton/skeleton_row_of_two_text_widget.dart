import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../config/theme/color_schemes.dart';
import '../../../../core/utils/constants.dart';

class SkeletonRowOfTwoTextWidget extends StatelessWidget {
  const SkeletonRowOfTwoTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: SkeletonLine(
            style: SkeletonLineStyle(height: 10, width: 80),
          ),
        ),
        SizedBox(
          width: 100,
          // child: Expanded(
          child: SkeletonLine(
            style: SkeletonLineStyle(height: 10, width: 80),
          ),
          // ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
