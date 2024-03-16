import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonSliderWidget extends StatelessWidget {
  const SkeletonSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: SkeletonAvatar(
        style: SkeletonAvatarStyle(
          width: MediaQuery.of(context).size.width,
          height: 160,
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
