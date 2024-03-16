import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonMySubscriptionItemWidget extends StatelessWidget {
  const SkeletonMySubscriptionItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 15,
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.12),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: SkeletonLine(
                        style: SkeletonLineStyle(height: 10, width: 100),
                      )),
                  const Divider(
                    thickness: 1,
                    color: ColorSchemes.lightGray,
                    height: 1,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 20,
                              width: 20,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                            child: SkeletonLine(
                          style: SkeletonLineStyle(height: 8, width: 150),
                        )),
                        const SizedBox(
                            width: 80,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(height: 8, width: 80),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 20,
                              width: 20,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                            child: SkeletonLine(
                          style: SkeletonLineStyle(height: 8, width: 150),
                        )),
                        const SizedBox(
                            width: 80,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(height: 8, width: 80),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 15,
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.12),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: SkeletonLine(
                        style: SkeletonLineStyle(height: 10, width: 100),
                      )),
                  const Divider(
                    thickness: 1,
                    color: ColorSchemes.lightGray,
                    height: 1,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 20,
                              width: 20,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                            child: SkeletonLine(
                          style: SkeletonLineStyle(height: 8, width: 150),
                        )),
                        const SizedBox(
                            width: 80,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(height: 8, width: 80),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 20,
                              width: 20,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                            child: SkeletonLine(
                          style: SkeletonLineStyle(height: 8, width: 150),
                        )),
                        const SizedBox(
                            width: 80,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(height: 8, width: 80),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 15,
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.12),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: SkeletonLine(
                        style: SkeletonLineStyle(height: 10, width: 100),
                      )),
                  const Divider(
                    thickness: 1,
                    color: ColorSchemes.lightGray,
                    height: 1,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 20,
                              width: 20,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                            child: SkeletonLine(
                          style: SkeletonLineStyle(height: 8, width: 150),
                        )),
                        const SizedBox(
                            width: 80,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(height: 8, width: 80),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 20,
                              width: 20,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                            child: SkeletonLine(
                          style: SkeletonLineStyle(height: 8, width: 150),
                        )),
                        const SizedBox(
                            width: 80,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(height: 8, width: 80),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 15,
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.12),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: SkeletonLine(
                        style: SkeletonLineStyle(height: 10, width: 100),
                      )),
                  const Divider(
                    thickness: 1,
                    color: ColorSchemes.lightGray,
                    height: 1,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 20,
                              width: 20,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                            child: SkeletonLine(
                          style: SkeletonLineStyle(height: 8, width: 150),
                        )),
                        const SizedBox(
                            width: 80,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(height: 8, width: 80),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 20,
                              width: 20,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                            child: SkeletonLine(
                          style: SkeletonLineStyle(height: 8, width: 150),
                        )),
                        const SizedBox(
                            width: 80,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(height: 8, width: 80),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
