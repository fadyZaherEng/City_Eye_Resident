import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SelectCompoundSkeletonScreen extends StatefulWidget {
  const SelectCompoundSkeletonScreen({Key? key}) : super(key: key);

  @override
  State<SelectCompoundSkeletonScreen> createState() =>
      _SelectCompoundSkeletonScreenState();
}

class _SelectCompoundSkeletonScreenState
    extends State<SelectCompoundSkeletonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).selectCompound,
        isHaveBackButton: true,
        onBackButtonPressed: () {},
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 50,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SizedBox(
                height: 35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 8.0,
                        ),
                        child: SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 40,
                            width: 70,
                          ),
                        ),
                      );
                    }),
              )),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            color: ColorSchemes.lightGray,
            height: 1.7,
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 20,
                            width: 80,
                          ),
                        ),
                      ),
                      GridView.builder(
                          itemCount: 2,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 170,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: SizedBox(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: const BoxDecoration(
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
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        SkeletonAvatar(
                                          style: SkeletonAvatarStyle(
                                              height: 50,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                50,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const SkeletonLine(
                                          style: SkeletonLineStyle(
                                            height: 6,
                                            width: 150,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const SkeletonLine(
                                          style: SkeletonLineStyle(
                                            height: 6,
                                            width: 100,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          })
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
