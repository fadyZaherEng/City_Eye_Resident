import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonHomeWidget extends StatelessWidget {
  const SkeletonHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 48,
                      width: 48,
                      borderRadius: BorderRadius.circular(16),
                      shape: BoxShape.rectangle),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 50,
                      ),
                    ),
                    SizedBox(height: 10),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 100,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: const SizedBox()),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 40,
                      width: 40,
                      borderRadius: BorderRadius.circular(16),
                      shape: BoxShape.circle),
                )
              ],
            ),
            const SizedBox(height: 28),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  height: 160,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(32),
                  shape: BoxShape.rectangle),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 8,
                      width: 8,
                      borderRadius: BorderRadius.circular(32),
                      shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 8,
                      width: 8,
                      borderRadius: BorderRadius.circular(32),
                      shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 8,
                      width: 8,
                      borderRadius: BorderRadius.circular(32),
                      shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 8,
                      width: 8,
                      borderRadius: BorderRadius.circular(32),
                      shape: BoxShape.circle),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: ColorSchemes.borderGray,
                  width: 1,
                ),
              ),
              height: 111,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 10,
                            width: 200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 8,
                            width: 200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 8,
                            width: 180,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 100,
                          width: 90,
                          borderRadius: BorderRadius.circular(22),
                          shape: BoxShape.rectangle),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 33),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 10,
                width: 100,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 50,
                                width: 50,
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(height: 16),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 8,
                              width: 50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 50,
                                width: 50,
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(height: 16),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 8,
                              width: 50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 50,
                                width: 50,
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(height: 16),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 8,
                              width: 50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 50,
                                width: 50,
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(height: 16),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 8,
                              width: 50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 50,
                                width: 50,
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(height: 16),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 8,
                              width: 50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 50,
                                width: 50,
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(height: 16),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 8,
                              width: 50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 50,
                                width: 50,
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(height: 16),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 8,
                              width: 50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 50,
                                width: 50,
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(height: 16),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 8,
                              width: 50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                    ],
                  ),
                )),
            const SizedBox(height: 33),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 10,
                width: 100,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 32,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.12))
                      ],
                      color: ColorSchemes.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 70,
                              width: 70,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 10,
                              width: 100,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.rectangle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 10,
                              width: 150,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.rectangle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 32,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.12))
                      ],
                      color: ColorSchemes.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 70,
                              width: 70,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 10,
                              width: 100,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.rectangle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 10,
                              width: 150,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.rectangle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 32,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.12))
                      ],
                      color: ColorSchemes.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 70,
                              width: 70,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 10,
                              width: 100,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.rectangle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 10,
                              width: 150,
                              borderRadius: BorderRadius.circular(32),
                              shape: BoxShape.rectangle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
