import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/circular_icon.dart';
import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';

class UploadMediaWidget extends StatefulWidget {
  final Function() onTapCamera;
  final Function() onTapGallery;

  const UploadMediaWidget(
      {Key? key, required this.onTapCamera, required this.onTapGallery})
      : super(key: key);

  @override
  State<UploadMediaWidget> createState() => _UploadMediaWidgetState();
}

class _UploadMediaWidgetState extends State<UploadMediaWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
        height: 219,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: widget.onTapGallery,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularIcon(
                    boxShadows:  [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          color: ColorSchemes.iconBackGround,
                          blurRadius: 24,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 5),
                    ],
                    imagePath: ImagePaths.uploadMediaGallery,
                    backgroundColor: ColorSchemes.iconBackGround,
                    iconSize: 28,
                    iconColor: ColorSchemes.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).gallery,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: 13,
                        letterSpacing: -0.24,
                        color: ColorSchemes.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 71,
            ),
            GestureDetector(
              onTap: widget.onTapCamera,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularIcon(
                    boxShadows:  [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          color: ColorSchemes.iconBackGround,
                          blurRadius: 24,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 5),
                    ],
                    imagePath: ImagePaths.cameraTwo,
                    backgroundColor: ColorSchemes.iconBackGround,
                    iconSize: 28,
                    iconColor: ColorSchemes.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).camera,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: 13,
                        letterSpacing: -0.24,
                        color: ColorSchemes.black),
                  ),
                ],
              ),
            ),
          ],
        ),
        titleLabel: S.of(context).uploadMedia);
  }
}
