import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonMyServiceScreen extends StatefulWidget {
  const SkeletonMyServiceScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SkeletonMyServiceScreen> createState() =>
      _SkeletonMyServiceScreenState();
}

class _SkeletonMyServiceScreenState extends State<SkeletonMyServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(
              16,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 120,
                      borderRadius: BorderRadius.circular(
                        12,
                      )),
                ),
                const SizedBox(
                  height: 32,
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 50,
                      borderRadius: BorderRadius.circular(
                        16,
                      )),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: 16,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 327,
                    childAspectRatio: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 13,
                    mainAxisExtent: 140,
                  ),
                  itemCount: 6,
                  itemBuilder: (BuildContext ctx, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                            boxShadow: [  BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 24,
                              spreadRadius: 0,
                              color: ColorSchemes.lightGray,
                              blurStyle: BlurStyle.outer,
                            )],
                            color: Colors.white,
                          ),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      height: 50,
                                      borderRadius: BorderRadius.circular(
                                        50,
                                      ))),
                              const SizedBox(
                                height: 8,
                              ),
                              const SkeletonLine(
                                style: SkeletonLineStyle(height: 6, width: 150,padding: EdgeInsets.symmetric(horizontal: 50)),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const SkeletonLine(
                                style: SkeletonLineStyle(height: 6, width: 100,padding: EdgeInsets.symmetric(horizontal: 50)),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
  }
}
