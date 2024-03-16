import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PaymentDetailsItemSkeleton extends StatelessWidget {
  const PaymentDetailsItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                borderRadius: BorderRadius.circular(10),
                width: 120,
                height: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                borderRadius: BorderRadius.circular(10),
                width: 90,
                height: 20,
              ),
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                borderRadius: BorderRadius.circular(10),
                width: 90,
                height: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                borderRadius: BorderRadius.circular(10),
                width: 90,
                height: 20,
              ),
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                borderRadius: BorderRadius.circular(10),
                width: 90,
                height: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SkeletonLine(
          style: SkeletonLineStyle(
            borderRadius: BorderRadius.circular(10),
            width: double.infinity,
            height: 20,
          ),
        ),
        const SizedBox(height: 4),
        SkeletonLine(
          style: SkeletonLineStyle(
            borderRadius: BorderRadius.circular(10),
            width: double.infinity,
            height: 20,
          ),
        ),
        const SizedBox(height: 16),
        const DottedLine(
          dashColor: ColorSchemes.gray,
          dashGapLength: 4,
          dashLength: 4,
          lineThickness: 1,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}
