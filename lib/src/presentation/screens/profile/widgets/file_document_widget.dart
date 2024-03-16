import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/core/utils/format_date.dart';
import 'package:city_eye/src/domain/entities/profile/profile_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileDocumentWidget extends StatelessWidget {
  final ProfileFile file;
  final Function(ProfileFile) onDelete;
  final Function(ProfileFile) onEdit;
  final Function(ProfileFile) onTapDocument;
  final Function(ProfileFile) onChangeDate;

  const FileDocumentWidget({
    Key? key,
    required this.file,
    required this.onDelete,
    required this.onEdit,
    required this.onTapDocument,
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
        file.value.isEmpty
            ? InkWell(
                onTap: () {
                  if (file.value.isNotEmpty) return;
                  onTapDocument(file);
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
                    child: Center(
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
                    )),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    ImagePaths.pdf,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.pdfScreen,
                              arguments: {
                                "screenTitle": S.of(context).documents,
                                "link": file.value,
                                "isNetworkPDF": true,
                              },
                            );
                          },
                          child: Text(
                            file.value.split('/').last,
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.13,
                                    ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          S.of(context).editNow,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: ColorSchemes.gray,
                                    letterSpacing: -0.12,
                                  ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onEdit(file);
                    },
                    child: SvgPicture.asset(
                      ImagePaths.edit,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      onDelete(file);
                    },
                    child: SvgPicture.asset(
                      ImagePaths.close,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Expanded(child: SizedBox()),
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
        const SizedBox(height: 8),
        file.errorMessage.isNotEmpty
            ? Text(
                file.errorMessage,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.redError,
                      letterSpacing: -0.24,
                    ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
