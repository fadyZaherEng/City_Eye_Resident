import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/screens/my_cart/skeleton/cart_list_item_skeleton.dart';
import 'package:city_eye/src/presentation/screens/my_cart/widgets/cart_list_item.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletons/skeletons.dart';

class MyCartSkeleton extends StatefulWidget {
  const MyCartSkeleton({super.key});

  @override
  State<MyCartSkeleton> createState() => _MyCartWidgetState();
}

class _MyCartWidgetState extends State<MyCartSkeleton> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 40,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 75,
                        width: 75,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 20,
                              width: 150,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 20,
                              width: 60,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 12,
                              width: 100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return const CartListItemSkeleton();
                  },
                ),
              ],
            ),
          ),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 2,
              width: double.infinity,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 20,
                    width: 150,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 24),
                disCountWidget(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 2,
              width: double.infinity,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 20,
                    width: 200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 16,
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 16,
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
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
                        height: 16,
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 16,
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
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
                        height: 16,
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 16,
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
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
                        height: 16,
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 16,
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
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
                        height: 16,
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 16,
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 2,
              width: double.infinity,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 28,
                        width: 28,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 20,
                        width: 60,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 20,
                    width: 120,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 50,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget disCountWidget() {
    return SkeletonLine(
      style: SkeletonLineStyle(
        height: 50,
        width: double.infinity,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
