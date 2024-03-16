import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ProfileScreenSkeleton extends StatelessWidget {
  const ProfileScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 2,
                      width: double.infinity,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 10,
                            width: 40,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 10,
                            width: 40,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 10,
                            width: 40,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 10,
                            width: 40,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 10,
                            width: 40,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 4,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      shape: BoxShape.circle,
                      width: 64,
                      height: 64,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 20,
                    width: 100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 55,
                width: MediaQuery.of(context).size.width,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 55,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 55,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 180,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Divider(
                height: 1,
                color: ColorSchemes.gray,
              ),
            ),
            Row(
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 25,
                    width: 60,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 25,
                    width: 60,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Divider(
                height: 1,
                color: ColorSchemes.gray,
              ),
            ),
            Row(
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 25,
                    width: 60,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 25,
                    width: 60,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 25,
                    width: 60,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Divider(
                height: 1,
                color: ColorSchemes.gray,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 55,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
