import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class DelegatedStepsSkeleton extends StatelessWidget {
  const DelegatedStepsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  color: ColorSchemes.lightGray,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 40,
                          width: 40,
                          shape: BoxShape.circle
                      ),
                    ),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 40,
                          width: 40,
                          shape: BoxShape.circle
                      ),
                    ),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 40,
                          width: 40,
                          shape: BoxShape.circle
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 12,
                      width: 60,
                  ),
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 12,
                      width: 60,
                  ),
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 12,
                      width: 60,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 4,
            color: ColorSchemes.lightGray,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 50,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 50,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 50,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 50,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 180,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 16,
                width: 180,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 16,
                width: 120,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 50,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 50,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
