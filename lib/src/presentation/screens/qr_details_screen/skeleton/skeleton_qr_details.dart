import 'package:city_eye/src/presentation/screens/qr_details_screen/skeleton/skeleton_row_of_two_text_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../config/theme/color_schemes.dart';

class SkeletonQrDetails extends StatelessWidget {
  const SkeletonQrDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    )
                  ]),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                            height: 150,
                            width: 150,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                            height: 20,
                            width: 70,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: SkeletonLine(
                          style: SkeletonLineStyle(
                              height: 34,
                              width: 135,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    thickness: 3,
                    color: ColorSchemes.dividerGrey,
                  ),
                  SizedBox(height: 20),
                  SkeletonRowOfTwoTextWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 0.7,
                      dashLength: 4,
                      dashColor: ColorSchemes.gray,
                      dashGapLength: 3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SkeletonRowOfTwoTextWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 0.7,
                      dashLength: 4,
                      dashColor: ColorSchemes.gray,
                      dashGapLength: 3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SkeletonRowOfTwoTextWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 0.7,
                      dashLength: 4,
                      dashColor: ColorSchemes.gray,
                      dashGapLength: 3,
                    ),
                  ),
                  SizedBox(height: 20),
                  SkeletonRowOfTwoTextWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 0.7,
                      dashLength: 4,
                      dashColor: ColorSchemes.gray,
                      dashGapLength: 3,
                    ),
                  ),
                  SizedBox(height: 20),
                  SkeletonRowOfTwoTextWidget(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonLine(
                style: SkeletonLineStyle(
                    height: 48,
                    width: double.infinity,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
