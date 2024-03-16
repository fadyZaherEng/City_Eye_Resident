import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ServiceDetailsSkeletonScreen extends StatefulWidget {
  final String title;

  const ServiceDetailsSkeletonScreen({Key? key, required this.title})
      : super(key: key);

  @override
  State<ServiceDetailsSkeletonScreen> createState() =>
      _ServiceDetailsSkeletonScreenState();
}

class _ServiceDetailsSkeletonScreenState
    extends State<ServiceDetailsSkeletonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBarWidget(
          context,
          title: widget.title,
          isHaveBackButton: true,
          onBackButtonPressed: () {},
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            Row(children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  borderRadius: BorderRadius.circular(
                                    50,
                                  ),
                                  height: 48,
                                  width: 48,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 8,
                                  width: 130,
                                ),
                              )
                            ]),
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: ColorSchemes.lightGray,
                            )
                          ],
                        ),
                      );
                    }),
        ));
  }
}
