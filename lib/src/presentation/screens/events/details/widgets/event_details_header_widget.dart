import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class EventDetailsHeaderWidget extends StatelessWidget {
  final String title;
  final String link;
  final String imageUrl;
  final Function() onBackButtonPressed;
  final Function(String) onShareButtonPressed;
  final Function(String) onTapPreviewImage;

  const EventDetailsHeaderWidget({
    Key? key,
    required this.title,
    required this.link,
    required this.imageUrl,
    required this.onBackButtonPressed,
    required this.onShareButtonPressed,
    required this.onTapPreviewImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: InkWell(
        onTap: () {
          onTapPreviewImage(imageUrl);
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 250,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    ImagePaths.imagePlaceHolder,
                    fit: BoxFit.cover,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  return SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                  );
                },
              ),
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // Shadow color
                    spreadRadius: 2, // Spread radius of the shadow
                    blurRadius: 4, // Blur radius of the shadow
                    offset: const Offset(0, 2), // Offset of the shadow
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 63),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      onBackButtonPressed();
                    },
                    child: SvgPicture.asset(
                      ImagePaths.arrowLeft,
                      matchTextDirection: true,
                      width: 24,
                      height: 24,
                      color: ColorSchemes.white,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          letterSpacing: -0.24,
                          color: ColorSchemes.white,
                        ),
                  ),
                  Visibility(
                    visible: false,
                    child: InkWell(
                      onTap: () {
                        onShareButtonPressed(link);
                      },
                      child: SvgPicture.asset(
                        ImagePaths.share,
                        matchTextDirection: true,
                        width: 24,
                        height: 24,
                        color: ColorSchemes.white,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
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
