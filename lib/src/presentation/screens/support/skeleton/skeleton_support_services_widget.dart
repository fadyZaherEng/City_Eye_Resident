import 'package:city_eye/src/presentation/screens/support/skeleton/skeleton_support_service_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonSupportServicesWidget extends StatelessWidget {
  const SkeletonSupportServicesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 120,
                  borderRadius: BorderRadius.circular(
                    12,
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 50,
                  borderRadius: BorderRadius.circular(
                    16,
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            GridView.builder(
              itemCount: 20,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 16,
                mainAxisExtent: 110,
              ),
              itemBuilder: (context, index) {
                return const SkeletonSupportServiceCardWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}
