import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../../config/theme/color_schemes.dart';

class SkeletonNotificationScreen extends StatelessWidget {
  const SkeletonNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
                color: ColorSchemes.white,
                borderRadius: BorderRadiusDirectional.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  )
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: ClipOval(
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 50,
                          width: 50,
                          borderRadius: BorderRadius.circular(16),
                          shape: BoxShape.circle),
                    ),
                  ),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 10,
                                width: 80,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 10,
                              width: 50,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: 180,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
                color: ColorSchemes.white,
                borderRadius: BorderRadiusDirectional.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  )
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: ClipOval(
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 50,
                          width: 50,
                          borderRadius: BorderRadius.circular(16),
                          shape: BoxShape.circle),
                    ),
                  ),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 10,
                                width: 80,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 10,
                              width: 50,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: 180,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
                color: ColorSchemes.white,
                borderRadius: BorderRadiusDirectional.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  )
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: ClipOval(
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 50,
                          width: 50,
                          borderRadius: BorderRadius.circular(16),
                          shape: BoxShape.circle),
                    ),
                  ),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 10,
                                width: 80,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 10,
                              width: 50,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: 180,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
                color: ColorSchemes.white,
                borderRadius: BorderRadiusDirectional.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  )
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: ClipOval(
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 50,
                          width: 50,
                          borderRadius: BorderRadius.circular(16),
                          shape: BoxShape.circle),
                    ),
                  ),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 10,
                                width: 80,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 10,
                              width: 50,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: 180,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
                color: ColorSchemes.white,
                borderRadius: BorderRadiusDirectional.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  )
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: ClipOval(
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 50,
                          width: 50,
                          borderRadius: BorderRadius.circular(16),
                          shape: BoxShape.circle),
                    ),
                  ),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 10,
                                width: 80,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 10,
                              width: 50,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: 180,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
