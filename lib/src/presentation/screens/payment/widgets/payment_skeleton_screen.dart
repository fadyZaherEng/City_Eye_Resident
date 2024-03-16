import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PaymentSkeletonScreen extends StatefulWidget {
  const PaymentSkeletonScreen({super.key});

  @override
  State<PaymentSkeletonScreen> createState() => _PaymentSkeletonScreenState();
}

class _PaymentSkeletonScreenState extends State<PaymentSkeletonScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorSchemes.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                                color: ColorSchemes.lightGray,
                                offset: Offset(0, 1),
                                blurRadius: 50,
                                spreadRadius: 0)
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: ColorSchemes.lightGray,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16)),
                              ),
                              child: SkeletonLine(
                                  style: SkeletonLineStyle(
                                height: 45,
                                width: double.infinity,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16)),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SkeletonLine(
                                          style: SkeletonLineStyle(
                                              height: 30,
                                              width: 30,
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      const SizedBox(width: 16),
                                      const SkeletonLine(
                                          style: SkeletonLineStyle(
                                        height: 10,
                                        width: 70,
                                      )),
                                    ],
                                  ),
                                  const Column(
                                    children: [
                                      SkeletonLine(
                                          style: SkeletonLineStyle(
                                        height: 10,
                                        width: 100,
                                      )),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          SkeletonLine(
                                              style: SkeletonLineStyle(
                                            height: 10,
                                            width: 40,
                                          )),
                                          SizedBox(width: 20),
                                          SkeletonLine(
                                              style: SkeletonLineStyle(
                                            height: 10,
                                            width: 40,
                                          )),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: SkeletonLine(
                                  style: SkeletonLineStyle(
                                height: 10,
                                width: 300,
                              )),
                            ),
                            Container(
                              height: 1,
                              color: ColorSchemes.lightGray,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SkeletonLine(
                                      style: SkeletonLineStyle(
                                          height: 25,
                                          width: 25,
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  const SizedBox(width: 10),
                                  const SkeletonLine(
                                      style: SkeletonLineStyle(
                                    height: 10,
                                    width: 70,
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
