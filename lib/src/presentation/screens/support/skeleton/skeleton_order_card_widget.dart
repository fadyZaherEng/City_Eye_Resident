import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonOrderCardWidget extends StatelessWidget {
  const SkeletonOrderCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorSchemes.cardSelected,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 16,
            spreadRadius: 0,
            color: Color.fromRGBO(0, 0, 0, 0.12),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 100,
                        alignment: Alignment.center,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorSchemes.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorSchemes.gray.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: const Row(
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                shape: BoxShape.circle,
                                maxHeight: 22,
                                maxWidth: 22,
                                width: 22,
                                height: 22),
                          ),
                          SizedBox(width: 8),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 5,
                              width: 50,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 50,
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(width: 8),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 100,
                        alignment: Alignment.center,
                      ),
                    ),
                    Spacer(),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 50,
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(width: 8),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 100,
                        alignment: Alignment.center,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                shape: BoxShape.circle,
                                maxHeight: 32,
                                maxWidth: 32,
                                width: 32,
                                height: 32,
                              ),
                            ),
                            Positioned(
                              bottom: -20,
                              child: SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 5,
                                  width: 50,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 5,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                shape: BoxShape.circle,
                                maxHeight: 32,
                                maxWidth: 32,
                                width: 32,
                                height: 32,
                              ),
                            ),
                            Positioned(
                              bottom: -20,
                              child: SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 5,
                                  width: 50,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 5,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                shape: BoxShape.circle,
                                maxHeight: 32,
                                maxWidth: 32,
                                width: 32,
                                height: 32,
                              ),
                            ),
                            Positioned(
                              bottom: -20,
                              child: SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 5,
                                  width: 50,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
          Container(
            height: 1.5,
            color: ColorSchemes.border,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconTextWidget(),
                _footerDivider(),
                _buildIconTextWidget(),
                _footerDivider(),
                _buildIconTextWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIconTextWidget() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            shape: BoxShape.circle,
            maxHeight: 24,
            maxWidth: 24,
            width: 24,
            height: 24,
          ),
        ),
        SizedBox(width: 8),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 5,
            width: 50,
            alignment: Alignment.center,
          ),
        )
      ],
    );
  }

  Container _footerDivider() {
    return Container(
      height: 50,
      width: 1,
      color: ColorSchemes.gray,
    );
  }
}
