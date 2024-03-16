import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CommunityRequestSkeleton extends StatelessWidget {
  const CommunityRequestSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(8),
              height: 20,
              width: 100,
            ),
          ),
          const SizedBox(height: 16),
          SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(12),
              height: 160,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  borderRadius: BorderRadius.circular(8),
                  height: 16,
                  width: 200,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(8),
              height: 20,
              width: 100,
            ),
          ),
          const SizedBox(height: 12),
          SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(12),
              height: 55,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 20),
          SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(8),
              height: 20,
              width: 100,
            ),
          ),
          const SizedBox(height: 12),
          SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(12),
              height: 55,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 20),
          SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(8),
              height: 20,
              width: 100,
            ),
          ),
          const SizedBox(height: 16),
          SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(12),
              height: 160,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 20),
          SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(8),
              height: 20,
              width: 100,
            ),
          ),
          const SizedBox(height: 12),
          SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(12),
              height: 55,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
