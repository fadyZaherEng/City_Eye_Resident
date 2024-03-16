import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CartListItemSkeleton extends StatelessWidget {
  const CartListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DottedLine(
          dashColor: ColorSchemes.gray,
          dashGapLength: 4,
          dashLength: 4,
          lineThickness: 1,
        ),
        const SizedBox(height: 16),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 16,
            width: 150,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 16,
            width: double.infinity,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 2),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 16,
            width: double.infinity,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 2),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 16,
            width: double.infinity,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 16,
                    width: 120,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 16,
                    width: 120,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 16,
                    width: 60,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 16,
                    width: 100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
