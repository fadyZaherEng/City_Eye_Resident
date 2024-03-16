import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class EventDetailsSkeleton extends StatelessWidget {
  const EventDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: const SkeletonLine(
                      style: SkeletonLineStyle(
                    width: double.infinity,
                    height: 250,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  )),
                ),
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 2, // Spread radius of the shadow
                        blurRadius: 4, // Blur radius of the shadow
                        offset: const Offset(0, 2), // Offset of the shadow
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 63),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: SkeletonLine(
                            style: SkeletonLineStyle(
                          width: 24,
                          height: 24,
                        )),
                      ),
                      SkeletonLine(
                          style: SkeletonLineStyle(
                        width: 90,
                        height: 24,
                      )),
                      InkWell(
                        child: SkeletonLine(
                            style: SkeletonLineStyle(
                          width: 24,
                          height: 24,
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLine(
                    style: SkeletonLineStyle(
                  width: 120,
                  height: 20,
                )),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 24,
                              height: 20,
                            )),
                        SizedBox(width: 8),
                        SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 60,
                              height: 20,
                            )),
                      ]
                    ),
                    Row(
                        children: [
                          SkeletonLine(
                              style: SkeletonLineStyle(
                                width: 24,
                                height: 20,
                              )),
                          SizedBox(width: 8),
                          SkeletonLine(
                              style: SkeletonLineStyle(
                                width: 60,
                                height: 20,
                              )),
                        ]
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const SkeletonLine(
                        style: SkeletonLineStyle(
                      width: 24,
                      height: 20,
                    )),
                    const SizedBox(width: 8),
                    const SkeletonLine(
                        style: SkeletonLineStyle(
                      width: 60,
                      height: 20,
                    )),
                    const SizedBox(
                      width: 24,
                    ),
                    Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                        color: ColorSchemes.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  children: [
                    SkeletonLine(
                        style: SkeletonLineStyle(
                          width: 24,
                          height: 20,
                        )),
                    SizedBox(width: 8),
                    SkeletonLine(
                        style: SkeletonLineStyle(
                          width: 90,
                          height: 20,
                        )),
                  ]
                ),
                const SizedBox(
                  height: 16,
                ),
                const SkeletonLine(
                    style: SkeletonLineStyle(
                  width: double.infinity,
                  height: 18,
                )),
                const SizedBox(height: 4),
                const SkeletonLine(
                    style: SkeletonLineStyle(
                      width: double.infinity,
                      height: 18,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: ColorSchemes.border,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SkeletonLine(
                        style: SkeletonLineStyle(
                      width: 20,
                      height: 20,
                    )),
                    SizedBox(
                      width: 8,
                    ),
                    SkeletonLine(
                        style: SkeletonLineStyle(
                      width: 100,
                      height: 20,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 1,
                          width: 8,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const SkeletonLine(
                            style: SkeletonLineStyle(
                          width: 100,
                          height: 20,
                        )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          height: 1,
                          width: 8,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const SkeletonLine(
                            style: SkeletonLineStyle(
                          width: 100,
                          height: 20,
                        )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          height: 1,
                          width: 8,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 100,
                              height: 20,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: ColorSchemes.border,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                color: ColorSchemes.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: SkeletonLine(
                                  style: SkeletonLineStyle(
                                    width: 100,
                                    height: 30,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    )
                                  )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                color: ColorSchemes.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: 100,
                                        height: 30,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                color: ColorSchemes.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: 100,
                                        height: 30,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                color: ColorSchemes.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: 100,
                                        height: 30,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
