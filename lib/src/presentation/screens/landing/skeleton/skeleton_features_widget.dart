import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonFeaturesWidget extends StatelessWidget {
  const SkeletonFeaturesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SkeletonLine(
            style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(0),
              height: 10,
              width: 100,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 16,
              mainAxisExtent: 155,
            ),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration:  const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 24,
                      spreadRadius: 0,
                      color: ColorSchemes.lightGray,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 50,
                        height: 50,
                        shape: BoxShape.circle,
                      )
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        borderRadius: BorderRadius.circular(0),
                        height: 7,
                        width: 100,
                        alignment: Alignment.center,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: 132,
                      child: SkeletonLine(
                        style: SkeletonLineStyle(
                          borderRadius: BorderRadius.circular(0),
                          height: 5,
                          width: 120,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    SizedBox(
                      width: 132,
                      child: SkeletonLine(
                        style: SkeletonLineStyle(
                          borderRadius: BorderRadius.circular(0),
                          height: 5,
                          width: 90,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
