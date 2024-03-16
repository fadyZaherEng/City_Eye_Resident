import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentImageWidget extends StatefulWidget {
  final Function() onTap;
  final void Function(String image) deleteImageAction;
  final String image;
  final String name;
  final String description;
  final String errorMessage;
  final GlobalKey? globalKey;

  const DocumentImageWidget({
    Key? key,
    required this.onTap,
    required this.image,
    required this.name,
    required this.deleteImageAction,
    required this.description,
    required this.errorMessage,
    this.globalKey,
  }) : super(key: key);

  @override
  State<DocumentImageWidget> createState() => _DocumentImageWidgetState();
}

class _DocumentImageWidgetState extends State<DocumentImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: widget.globalKey,
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorSchemes.black,
                  letterSpacing: -0.24,
                ),
          ),
          const SizedBox(height: 16),
          widget.image.isEmpty
              ? InkWell(
                  onTap: widget.onTap,
                  child: Container(
                      height: 114,
                      width: 343,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(
                            color: ColorSchemes.lightGray,
                            width: 1,
                          )),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(ImagePaths.circleAdd),
                            const SizedBox(height: 10),
                            Text(
                              widget.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: ColorSchemes.gray,
                                    fontWeight: Constants.fontWeightRegular,
                                    letterSpacing: -0.13,
                                  ),
                            ),
                          ],
                        ),
                      )))
              : SizedBox(
                  height: 114,
                  width: 343,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          image: DecorationImage(
                            image: FileImage(File(
                              widget.image,
                            )),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            height: 22,
                            width: 22,
                            decoration: const BoxDecoration(
                                color: ColorSchemes.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                )),
                            child: InkWell(
                              onTap: () =>
                                  widget.deleteImageAction(widget.image),
                              child: SvgPicture.asset(
                                ImagePaths.close,
                                fit: BoxFit.scaleDown,
                                color: ColorSchemes.black,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
          const SizedBox(height: 8),
          Text(
            widget.image.isEmpty ? widget.errorMessage : '',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorSchemes.redError,
                  fontWeight: Constants.fontWeightRegular,
                  letterSpacing: -0.13,
                ),
          ),
        ],
      ),
    );
  }
}
