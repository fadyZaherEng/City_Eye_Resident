import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonPreparedVisitTime extends StatelessWidget {
  const SkeletonPreparedVisitTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    width: 80,
                    height: 32,
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                ),
                const SizedBox(width: 12),
              ],
            );
          }),
    );
  }
}
