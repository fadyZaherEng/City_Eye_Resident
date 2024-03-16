import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonServiceDetailsCart extends StatelessWidget {
  const SkeletonServiceDetailsCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 16,
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          height: 190,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: const Color.fromRGBO(241, 241, 241, 1), width: 1),
              color: ColorSchemes.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  spreadRadius: 0,
                  blurRadius: 32,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorSchemes.iconBackGround,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(16) , topLeft: Radius.circular(16)),
                ),
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 10,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 20,
                        height: 20,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 10,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: 16,
                                height: 16,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: 16,
                                height: 16,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: 16,
                                height: 16,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: 16,
                                height: 16,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: 16,
                                height: 16,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 32,
                        height: 32,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 32,
                        height: 32,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 1,
                color: ColorSchemes.lightGray,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 10,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
