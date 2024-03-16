import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HistorySkeletonWidget extends StatefulWidget {
  const HistorySkeletonWidget({super.key});

  @override
  State<HistorySkeletonWidget> createState() => _HistorySkeletonWidgetState();
}

class _HistorySkeletonWidgetState extends State<HistorySkeletonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 17, right: 16, left: 16),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                    decoration: BoxDecoration(
                      color: ColorSchemes.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: ColorSchemes.lightGray,
                            offset: Offset(0, 1),
                            blurRadius: 30,
                            spreadRadius: 0)
                      ],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: ColorSchemes.cardSelected,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SkeletonLine(
                                          style: SkeletonLineStyle(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              height: 12,
                                              width: 120),
                                        ),
                                        SkeletonLine(
                                          style: SkeletonLineStyle(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              height: 10,
                                              width: 80),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    SkeletonLine(
                                      style: SkeletonLineStyle(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          height: 10,
                                          width: 70),
                                    )
                                  ],
                                ),
                              )),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SkeletonLine(
                                          style: SkeletonLineStyle(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              height: 25,
                                              width: 100)),
                                      const SizedBox(height: 10),
                                      SkeletonLine(
                                        style: SkeletonLineStyle(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            height: 12,
                                            width: 100),
                                      ),
                                      const SizedBox(height: 10),
                                      SkeletonLine(
                                        style: SkeletonLineStyle(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            height: 12,
                                            width: 100),
                                      )
                                    ]),
                                const SizedBox(width: 66),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        SkeletonLine(
                                            style: SkeletonLineStyle(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                height: 12,
                                                width: 120)),
                                        const SizedBox(height: 15),
                                        SkeletonLine(
                                          style: SkeletonLineStyle(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              height: 12,
                                              width: 120),
                                        ),
                                        const SizedBox(height: 10),
                                        SkeletonLine(
                                          style: SkeletonLineStyle(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              height: 12,
                                              width: 120),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          )
                        ]))));
          }),
    );
  }
}
