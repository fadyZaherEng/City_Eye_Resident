import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/screens/payment_details/skeleton/payment_details_item_skeleton.dart';
import 'package:city_eye/src/presentation/screens/payment_details/widgets/payment_details_item.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PaymentDetailsWidgetSkeleton extends StatelessWidget {
  const PaymentDetailsWidgetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: SizedBox(width: 20)),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    borderRadius: BorderRadius.circular(10),
                    width: 140,
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        borderRadius: BorderRadius.circular(10),
                        width: 140,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: SizedBox(width: 20)),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    borderRadius: BorderRadius.circular(10),
                    width: 140,
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        borderRadius: BorderRadius.circular(10),
                        width: 140,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: SizedBox(width: 20)),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    borderRadius: BorderRadius.circular(10),
                    width: 140,
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        borderRadius: BorderRadius.circular(10),
                        width: 140,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: SizedBox(width: 20)),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    borderRadius: BorderRadius.circular(10),
                    width: 140,
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        borderRadius: BorderRadius.circular(10),
                        width: 140,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const DottedLine(
              dashColor: ColorSchemes.gray,
              dashGapLength: 4,
              dashLength: 4,
              lineThickness: 1,
              direction: Axis.horizontal,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const PaymentDetailsItemSkeleton();
              },
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 8),
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
            const SizedBox(height: 8),
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
            const SizedBox(height: 8),
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
            const SizedBox(height: 12),
            const DottedLine(
              dashColor: ColorSchemes.gray,
              dashGapLength: 4,
              dashLength: 4,
              lineThickness: 1,
              direction: Axis.horizontal,
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
