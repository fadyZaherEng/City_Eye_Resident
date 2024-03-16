import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CreateQrSkeletonWidget extends StatelessWidget {
  const CreateQrSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Padding(
      //   padding: const EdgeInsetsDirectional.only(end: 15, bottom: 60),
      //   child: const SkeletonAvatar(
      //     style: SkeletonAvatarStyle(
      //       width: 80,
      //       height: 30,
      //       shape: BoxShape.rectangle,
      //       borderRadius: BorderRadius.all(Radius.circular(12)),
      //
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 18,
                        width: 150,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 120,
                        borderRadius: BorderRadius.circular(
                          12,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 18,
                        width: 150,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 50,
                        borderRadius: BorderRadius.circular(
                          12,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 18,
                        width: 150,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 50,
                        borderRadius: BorderRadius.circular(
                          12,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 18,
                        width: 150,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 50,
                        borderRadius: BorderRadius.circular(
                          12,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 18,
                        width: 150,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 50,
                        borderRadius: BorderRadius.circular(
                          12,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
