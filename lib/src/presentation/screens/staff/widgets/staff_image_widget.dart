import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class StaffImageWidget extends StatefulWidget {
  final String image;

  const StaffImageWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<StaffImageWidget> createState() => _StaffImageWidgetState();
}

class _StaffImageWidgetState extends State<StaffImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.image,
      fit: BoxFit.cover,
      width: 85,
      height: 85,
      errorBuilder: (
        context,
        error,
        stackTrace,
      ) {
        return Center(
            child: SvgPicture.asset(
          ImagePaths.avatar,
          fit: BoxFit.cover,
          width: 85,
          height: 85,
        ));
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        // if (loadingProgress == null) return child;
        return const Center(
            child: SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 85,
            height: 85,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ));
      },
    );
  }
}
