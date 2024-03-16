import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class StaffSkeletonScreen extends StatefulWidget {
  const StaffSkeletonScreen({Key? key}) : super(key: key);

  @override
  State<StaffSkeletonScreen> createState() => _StaffSkeletonScreenState();
}

class _StaffSkeletonScreenState extends State<StaffSkeletonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).staff,
        isHaveBackButton: true,
        onBackButtonPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
          top: 16,
        ),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                          height: 93,
                          width: 93,
                          borderRadius: BorderRadius.circular(
                            60,
                          ),
                        ))),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 7,
                                  width: 100,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 20,
                                      width: 20,
                                      borderRadius: BorderRadius.circular(
                                        6,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 7,
                                      width: 140,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 11,
                              ),
                              Row(
                                children: [
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 20,
                                      width: 20,
                                      borderRadius: BorderRadius.circular(
                                        6,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 7,
                                      width: 140,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 24,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: ColorSchemes.lightGray,
                  )
                ],
              );
            }),
      ),
    );
  }
}
