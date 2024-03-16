import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class WallSkeletonItemWidget extends StatelessWidget {
  const WallSkeletonItemWidget({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    )),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          width: 70,
                          height: 6,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          width: 70,
                          height: 6,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  const SkeletonLine(
                    style: SkeletonLineStyle(
                        width: 90,
                        height: 6,
                        padding: EdgeInsets.only(
                          top: 10,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const SkeletonLine(
                  style: SkeletonLineStyle(
                height: 5,
                width: 300,
              )),
              const SizedBox(
                height: 5,
              ),
              const SkeletonLine(
                  style: SkeletonLineStyle(
                height: 5,
                width: 250,
              )),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 85,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: SkeletonLine(
                            style: SkeletonLineStyle(
                                width: 89,
                                height: 53,
                                borderRadius: BorderRadius.circular(
                                  5,
                                ))),
                      );
                    }),
              )
            ],
          ),
        ),
        const SkeletonLine(
          style: SkeletonLineStyle(
            height: 1,
          ),
        )
      ],
    );
  }
}
