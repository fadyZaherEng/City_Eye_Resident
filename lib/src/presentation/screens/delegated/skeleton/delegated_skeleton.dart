import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class DelegatedSkeleton extends StatelessWidget {
  const DelegatedSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorSchemes.border,
                        offset: Offset(0, 0),
                        blurRadius: 15),
                  ],
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SkeletonLine(
                            style: SkeletonLineStyle(
                          height: 20,
                          width: 100,
                        )),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                            height: 20,
                            width: 20,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                height: 20,
                                width: 20,
                              )),
                              SizedBox(width: 8),
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                height: 20,
                                width: 100,
                              )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                            height: 20,
                            width: 20,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 20,
                                )),
                            SizedBox(width: 8),
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorSchemes.border,
                        offset: Offset(0, 0),
                        blurRadius: 15),
                  ],
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SkeletonLine(
                            style: SkeletonLineStyle(
                          height: 20,
                          width: 100,
                        )),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                            height: 20,
                            width: 20,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                height: 20,
                                width: 20,
                              )),
                              SizedBox(width: 8),
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                height: 20,
                                width: 100,
                              )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                            height: 20,
                            width: 20,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 20,
                                )),
                            SizedBox(width: 8),
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorSchemes.border,
                        offset: Offset(0, 0),
                        blurRadius: 15),
                  ],
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 20,
                              width: 100,
                            )),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 20,
                                width: 20,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 20,
                                    width: 20,
                                  )),
                              SizedBox(width: 8),
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 20,
                                    width: 100,
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 20,
                                width: 20,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 20,
                                )),
                            SizedBox(width: 8),
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorSchemes.border,
                        offset: Offset(0, 0),
                        blurRadius: 15),
                  ],
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 20,
                              width: 100,
                            )),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 20,
                                width: 20,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 20,
                                    width: 20,
                                  )),
                              SizedBox(width: 8),
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 20,
                                    width: 100,
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 20,
                                width: 20,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 20,
                                )),
                            SizedBox(width: 8),
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorSchemes.border,
                        offset: Offset(0, 0),
                        blurRadius: 15),
                  ],
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 20,
                              width: 100,
                            )),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 20,
                                width: 20,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 20,
                                    width: 20,
                                  )),
                              SizedBox(width: 8),
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 20,
                                    width: 100,
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 20,
                                width: 20,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 20,
                                )),
                            SizedBox(width: 8),
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorSchemes.border,
                        offset: Offset(0, 0),
                        blurRadius: 15),
                  ],
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 20,
                              width: 100,
                            )),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 20,
                                width: 20,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 20,
                                    width: 20,
                                  )),
                              SizedBox(width: 8),
                              SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 20,
                                    width: 100,
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: const SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 20,
                                width: 20,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 20,
                                )),
                            SizedBox(width: 8),
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 20,
                                  width: 150,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
