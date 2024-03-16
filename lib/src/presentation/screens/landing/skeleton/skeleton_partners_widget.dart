import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonPartnersWidget extends StatelessWidget {
  const SkeletonPartnersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorSchemes.searchBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonLine(
                  style: SkeletonLineStyle(
                borderRadius: BorderRadius.circular(0),
                height: 10,
                width: 100,
              ),),),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      shape: BoxShape.rectangle,
                      height: 50,
                      width: 80,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      shape: BoxShape.rectangle,
                      height: 50,
                      width: 80,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  const SizedBox(
                    width: 24,
                  ),
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      shape: BoxShape.rectangle,
                      height: 50,
                      width: 80,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  const SizedBox(
                    width: 24,
                  ),
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      shape: BoxShape.rectangle,
                      height: 50,
                      width: 80,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  const SizedBox(
                    width: 24,
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
