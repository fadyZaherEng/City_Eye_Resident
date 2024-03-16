import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/core/utils/format_date.dart';
import 'package:city_eye/src/core/utils/is_url.dart';
import 'package:city_eye/src/domain/entities/profile/profile_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class FileImagesWidget extends StatefulWidget {
  final ProfileFile file;
  final Function(ProfileFile, int) onAddMultiImage;
  final Function(List<String>, int) onTapImage;
  final Function(ProfileFile, int) onDeleteImage;
  final Function(ProfileFile) onChangeDate;

  const FileImagesWidget({
    Key? key,
    required this.file,
    required this.onAddMultiImage,
    required this.onTapImage,
    required this.onDeleteImage,
    required this.onChangeDate,
  }) : super(key: key);

  @override
  State<FileImagesWidget> createState() => _FileImagesWidgetState();
}

class _FileImagesWidgetState extends State<FileImagesWidget> {
  List<String> images = [];

  @override
  void initState() {
    if (widget.file.value.isNotEmpty) {
      images = widget.file.value.split(",").toList();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FileImagesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.file.value.isNotEmpty) {
      images = widget.file.value.split(",").toList();
    } else {
      images = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Text(
              widget.file.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: ColorSchemes.black,
                    letterSpacing: -0.24,
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 75,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: images.length + 1,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              return index == images.length
                  ? images.length >= widget.file.maxCount
                      ? const SizedBox.shrink()
                      : Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: () {
                                widget.onAddMultiImage(
                                  widget.file,
                                  index,
                                );
                              },
                              child: Container(
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorSchemes.white,
                                  border: Border.all(
                                    width: 1,
                                    color: ColorSchemes.primary,
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: ColorSchemes.white,
                                      border: Border.all(
                                        width: 1.5,
                                        color: ColorSchemes.primary,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      ImagePaths.add,
                                      fit: BoxFit.scaleDown,
                                      color: ColorSchemes.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                  : Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {
                            widget.onTapImage(
                              images,
                              index,
                            );
                          },
                          child: Container(
                            width: 84,
                            height: 84,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image(
                              image: _buildImage(images[index]),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const Center(
                                  child: SkeletonLine(
                                      style: SkeletonLineStyle(
                                    height: 84,
                                    width: 84,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  )),
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          start: 6,
                          top: -10,
                          child: InkWell(
                            onTap: () {
                              widget.onDeleteImage(
                                widget.file,
                                index,
                              );
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: ColorSchemes.white,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                ImagePaths.close,
                                fit: BoxFit.scaleDown,
                                color: ColorSchemes.gray,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 16,
              );
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(child: SizedBox()),
            SvgPicture.asset(
              ImagePaths.calendarEvents,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              S.of(context).expDate,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorSchemes.gray,
                    letterSpacing: -0.24,
                  ),
            ),
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                widget.onChangeDate(widget.file);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorSchemes.priorityLow.withOpacity(0.08),
                ),
                child: Text(
                  englishNumbers(formatDate(widget.file.expireDate)),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                      ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        widget.file.errorMessage.isNotEmpty
            ? Text(
                widget.file.errorMessage,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorSchemes.redError,
                      letterSpacing: -0.24,
                    ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  bool checkMinImagesRequired() {
    if (widget.file.minCount == 0) {
      return false;
    } else if (images.length < widget.file.minCount) {
      return true;
    } else {
      return false;
    }
  }

  ImageProvider _buildImage(String url) {
    if (isUrl(url)) {
      return NetworkImage(url);
    }
    return FileImage(File(url));
  }
}
