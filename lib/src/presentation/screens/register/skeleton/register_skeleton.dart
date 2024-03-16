import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/screens/register/skeleton/footer_skeleton.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class RegisterSkeleton extends StatelessWidget {
  const RegisterSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(
                title: S.of(context).createYourAccount,
                hasBackButton: true,
                backButtonAction: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: ColorSchemes.lightGray,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 40,
                              width: 40,
                              shape: BoxShape.circle
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 40,
                              width: 40,
                              shape: BoxShape.circle
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 40,
                              width: 40,
                              shape: BoxShape.circle
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 4,
                color: ColorSchemes.lightGray,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [

                    const SizedBox(height: 16,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 16,
                            width: 100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 35,
                            width: 60,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 35,
                            width: 60,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 35,
                            width: 60,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 50,
                        width: double.infinity,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 50,
                        width: double.infinity,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        const FooterSkeleton(),
      ],
    );
  }
}
