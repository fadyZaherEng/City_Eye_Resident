import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WallImageWidget extends StatefulWidget {
  final String image;

  const WallImageWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<WallImageWidget> createState() => _WallImageWidgetState();
}

class _WallImageWidgetState extends State<WallImageWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.image,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        return Image.asset(
          ImagePaths.imagePlaceHolder,
          fit: BoxFit.cover,
        );
      },
      placeholder: (context, url) {
        return Center(
          child: SkeletonLine(
              style: SkeletonLineStyle(
            width: double.infinity,
            height: double.infinity,
            borderRadius: BorderRadius.circular(
              4,
            ),
          )),
        );
      },
    );
  }
}
