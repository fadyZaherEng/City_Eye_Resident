import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/core/utils/format_date.dart';
import 'package:city_eye/src/domain/entities/profile/profile_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class FileImageWidget extends StatelessWidget {
  final ProfileFile file;
  final Function(ProfileFile) onDelete;
  final Function(ProfileFile) onEdit;
  final Function(ProfileFile) onTapImage;
  final Function(ProfileFile) onChangeDate;

  const FileImageWidget({
    Key? key,
    required this.file,
    required this.onDelete,
    required this.onEdit,
    required this.onTapImage,
    required this.onChangeDate,
  }) : super(key: key);

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
              file.name,
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
        Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            InkWell(
              onTap: () {
                // if (file.value.isNotEmpty) return;
                onTapImage(file);
              },
              child: Container(
                width: double.infinity,
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorSchemes.white,
                  border: Border.all(
                    width: 1,
                    color: ColorSchemes.lightGray,
                  ),
                ),
                child: file.value.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ImagePaths.circleAdd,
                              fit: BoxFit.scaleDown,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              file.label,
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
                      )
                    : Image.network(
                        file.value,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.file(
                            File(file.value),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ImagePaths.imagePlaceHolder,
                                fit: BoxFit.cover,
                              );
                            },
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                              child: SkeletonLine(
                            style: SkeletonLineStyle(
                              width: double.infinity,
                              height: 150,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ));
                        },
                      ),
              ),
            ),
            file.value.isNotEmpty
                ? Positioned.directional(
                    textDirection: Directionality.of(context),
                    end: 8,
                    child: Container(
                      height: 90,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorSchemes.black.withOpacity(0.44)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              onDelete(file);
                            },
                            child: SvgPicture.asset(
                              ImagePaths.delete,
                              fit: BoxFit.scaleDown,
                              color: ColorSchemes.white,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () {
                              onEdit(file);
                            },
                            child: SvgPicture.asset(
                              ImagePaths.edit,
                              fit: BoxFit.scaleDown,
                              color: ColorSchemes.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
        const SizedBox(
          height: 16,
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
                onChangeDate(file);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorSchemes.priorityLow.withOpacity(0.08),
                ),
                child: Text(
                  englishNumbers(formatDate(file.expireDate)),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                      ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        file.errorMessage.isNotEmpty
            ? Text(
                file.errorMessage,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorSchemes.redError,
                      letterSpacing: -0.24,
                    ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
