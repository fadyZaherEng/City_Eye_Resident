import 'dart:io';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/domain/entities/profile/info.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/date_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/extra_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/multi_selection_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/numaric_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/searchable_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/signle_selection_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/upload_image_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoWidget extends StatefulWidget {
  final ScrollController scrollController;
  final Info info;
  final String? nameErrorMessage;
  final String? emailErrorMessage;
  final Function(String) onNameChanged;
  final Function(String) onEmailChanged;
  final bool isImageLocal;
  final Function(Info) onSave;
  final Function() onCameraTab;
  final Function(String) onImageProfilePreview;
  final Function(List<PageField>, PageField, int) selectSingleSelection;
  final Function(List<PageField>, PageField, int) selectItem;
  final Function(List<PageField>, PageField) deleteAnswer;
  final Function(List<PageField>, PageField, dynamic) addAnswer;
  final Function(List<PageField>, PageField) onImageTab;
  final Function(List<PageField>, PageField) onImageDelete;
  final Function(List<PageField>, PageField, bool) onOpenSearchableBottomSheet;
  final GlobalKey nameKey;
  final GlobalKey emailKey;
  final TextEditingController fullNameController;
  final TextEditingController emailAddressController;
  final TextEditingController mobileNumberController;

  const InfoWidget({
    Key? key,
    required this.scrollController,
    required this.info,
    required this.nameErrorMessage,
    required this.emailErrorMessage,
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.isImageLocal,
    required this.onSave,
    required this.onCameraTab,
    required this.onImageProfilePreview,
    required this.selectSingleSelection,
    required this.selectItem,
    required this.deleteAnswer,
    required this.addAnswer,
    required this.onImageTab,
    required this.onImageDelete,
    required this.nameKey,
    required this.emailKey,
    required this.fullNameController,
    required this.emailAddressController,
    required this.mobileNumberController,
    required this.onOpenSearchableBottomSheet,
  }) : super(key: key);

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.loose,
        children: [
          CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: () {
                                widget.onImageProfilePreview(widget.info.image);
                              },
                              child: Container(
                                width: 64,
                                height: 64,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: _buildProfilePhoto(widget.isImageLocal),
                              ),
                            ),
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              bottom: 12,
                              end: -15,
                              child: InkWell(
                                onTap: () {
                                  widget.onCameraTab();
                                },
                                child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorSchemes.gray,
                                    ),
                                    child: SvgPicture.asset(
                                      ImagePaths.camera,
                                      fit: BoxFit.scaleDown,
                                    )),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Text(
                          S.of(context).uploadYourPhoto,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.13,
                                  ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    CustomTextFieldWidget(
                      controller: widget.fullNameController,
                      key: widget.nameKey,
                      labelTitle: S.of(context).fullName,
                      onChange: (value) {
                        widget.onNameChanged(value);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r' \s'),
                            replacementString: " "),
                      ],
                      errorMessage: widget.nameErrorMessage,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextFieldWidget(
                      controller: widget.emailAddressController,
                      labelTitle: S.of(context).emailAddress,
                      key: widget.emailKey,
                      onChange: (value) {
                        widget.onEmailChanged(value);
                      },
                      errorMessage: widget.emailErrorMessage,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextFieldWidget(
                      controller: widget.mobileNumberController,
                      labelTitle: S.of(context).mobileNumber,
                      onChange: (value) {},
                      errorMessage: null,
                      isReadOnly: true,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ...createQrListWidgets(context),
                    const SizedBox(
                      height: 56,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CustomButtonWidget(
              onTap: () {
                Info info = Info(
                  name: widget.fullNameController.text,
                  email: widget.emailAddressController.text,
                  mobileNumber: widget.mobileNumberController.text,
                  image: widget.info.image,
                  fields: widget.info.fields,
                );
                widget.onSave(info);
              },
              width: double.infinity,
              text: S.of(context).save,
              backgroundColor: F.isNiceTouch
                  ? ColorSchemes.ghadeerDarkBlue
                  : ColorSchemes.primary,
            ),
          ),
        ],
      ),
    );
  }

  Image _buildProfilePhoto(bool isImageLocal) {
    return isImageLocal
        ? Image.file(
            File(widget.info.image),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return SvgPicture.asset(
                ImagePaths.avatar,
                fit: BoxFit.scaleDown,
              );
            },
          )
        : Image.network(
            widget.info.image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return SvgPicture.asset(
                ImagePaths.avatar,
                fit: BoxFit.scaleDown,
              );
            },
          );
  }

  List<Widget> createQrListWidgets(BuildContext context) {
    List<Widget> list = [];
    widget.info.fields.forEach((element) {
      if (element.code == QuestionsCode.singleChoice) {
        list.add(SingleSelectionFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: element,
          selectAnswer: (answerId) {
            widget.selectSingleSelection(widget.info.fields, element, answerId);
          },
          showSeparator: !(element == widget.info.fields.last),
        ));
      } else if (element.code == QuestionsCode.multiChoice) {
        list.add(MultiSelectionFieldWidget(
          horizontalPadding: 1,
          verticalPadding: 16,
          pageField: element,
          selectAnswer: (answerId) {
            widget.selectItem(widget.info.fields, element, answerId);
          },
          showSeparator: !(element == widget.info.fields.last),
        ));
      } else if (element.code == QuestionsCode.date) {
        list.add(DateTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: element,
          deleteDate: () {
            widget.deleteAnswer(widget.info.fields, element);
          },
          pickDate: (answer) {
            widget.addAnswer(widget.info.fields, element, answer);
          },
          showSeparator: !(element == widget.info.fields.last),
        ));
      } else if (element.code == QuestionsCode.text) {
        list.add(ExtraTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: element,
          updateAnswer: false,
          addAnswer: (answer) {
            widget.addAnswer(widget.info.fields, element, answer);
          },
          showSeparator: !(element == widget.info.fields.last),
        ));
      } else if (element.code == QuestionsCode.number) {
        list.add(NumericTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: element,
          addAnswer: (answer) {
            widget.addAnswer(widget.info.fields, element, answer);
          },
          showSeparator: !(element == widget.info.fields.last),
        ));
      } else if (element.code == QuestionsCode.image) {
        list.add(UploadImageFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: element,
          showUploadImageBottomSheet: () {
            widget.onImageTab(widget.info.fields, element);
          },
          showDialogToDeleteImage: () {
            widget.onImageDelete(widget.info.fields, element);
          },
          showSeparator: !(element == widget.info.fields.last),
        ));
      } else if (element.code == QuestionsCode.searchableSingle ||
          element.code == QuestionsCode.searchableMulti) {
        list.add(SearchableFieldWidget(
          pageField: element,
          horizontalPadding: 0,
          verticalPadding: 16,
          showSeparator: !(element == widget.info.fields.last),
          openBottomSheet: () {
            widget.onOpenSearchableBottomSheet(widget.info.fields, element,
                element.code == QuestionsCode.searchableMulti);
          },
        ));
      }
    });
    return list;
  }
}
