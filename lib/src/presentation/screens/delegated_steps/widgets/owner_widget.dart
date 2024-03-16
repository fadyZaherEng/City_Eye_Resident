// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_date_picker_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/date_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/extra_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/multi_selection_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/numaric_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/searchable_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/signle_selection_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/upload_image_field_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

// ignore: must_be_immutable
class OwnerWidget extends StatefulWidget {
  var messageController = TextEditingController();
  var nameController = TextEditingController();
  var unitNoController = TextEditingController();
  var idController = TextEditingController();
  var dateFromController = TextEditingController();
  var dateToController = TextEditingController();
  final void Function() onTapUploadImage;
  final void Function(String) onTapImagePreview;
  final void Function() onTapDeleteImage;
  final void Function(String) onMessageChanged;
  final void Function(String value) onIdChanged;
  final VoidCallback onTapCaptureSignature;
  final void Function(bool isFromDate) onTapSelectedDate;
  final void Function() onClearSignature;
  final void Function() onSaveOwnerData;
  final File? selectedImage;
  final String selectedImageNetwork;
  final bool isNetwork;
  bool isCaptureSignature = false;
  final Uint8List? signatureImage;
  final String signatureImageNetwork;

  final String? messageErrorMessage;
  final String? idErrorMessage;
  final String? dateFromErrorMessage;
  final String? dateToErrorMessage;
  final String? selectImageErrorMessage;
  final String? captureSignatureErrorMessage;

  final GlobalKey messageKey;
  final GlobalKey idKey;
  final GlobalKey imageKey;
  final GlobalKey captureSignatureKey;
  final GlobalKey dateKey;

  ///**************** Dynamic Widgets **********************
  List<PageField> question;
  final void Function(PageField question, int answerId) onTapSingleSelection;
  final void Function(PageField question, int answerId) onTapMultiSelection;
  final void Function(PageField question) onTapDateDeleteAnswer;
  final void Function(PageField question, String answer) onTapPickDateAnswer;
  final void Function(PageField question, String answer)
      onTapTextAnswerQuestion;
  final void Function(PageField question, String answer)
      onTapNumericAnswerQuestion;
  final void Function(
    PageField question,
  ) onShowUploadImageBottomSheet;
  final void Function(
    PageField question,
  ) onShowDialogToDeleteImage;
  final Function(PageField, bool) onOpenSearchableBottomSheet;

  OwnerWidget(
      {required this.question,
      required this.messageKey,
      required this.idKey,
      required this.imageKey,
      required this.captureSignatureKey,
      required this.dateKey,
      required this.onTapSingleSelection,
      required this.onTapMultiSelection,
      required this.onTapDateDeleteAnswer,
      required this.onTapPickDateAnswer,
      required this.onTapTextAnswerQuestion,
      required this.onTapNumericAnswerQuestion,
      required this.onShowUploadImageBottomSheet,
      required this.onShowDialogToDeleteImage,
      required this.messageController,
      required this.messageErrorMessage,
      required this.nameController,
      required this.unitNoController,
      required this.idController,
      required this.idErrorMessage,
      required this.dateFromController,
      required this.dateFromErrorMessage,
      required this.dateToController,
      required this.dateToErrorMessage,
      required this.selectImageErrorMessage,
      required this.captureSignatureErrorMessage,
      required this.onTapUploadImage,
      required this.onTapDeleteImage,
      required this.onTapCaptureSignature,
      required this.onTapSelectedDate,
      required this.onClearSignature,
      required this.onSaveOwnerData,
      required this.onMessageChanged,
      required this.onIdChanged,
      required this.selectedImage,
      required this.isCaptureSignature,
      required this.signatureImage,
      required this.selectedImageNetwork,
      required this.signatureImageNetwork,
      required this.isNetwork,
      required this.onOpenSearchableBottomSheet,
      required this.onTapImagePreview,
      super.key});

  @override
  State<OwnerWidget> createState() => _OwnerWidgetState();
}

class _OwnerWidgetState extends State<OwnerWidget> {
  final ScrollController _scrollController = ScrollController();

  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  @override
  void initState() {
    _focus.addListener(() {
      setState(() {
        _textFieldHasFocus = _focus.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldWidget(
                      isReadOnly: true,
                      controller: widget.nameController,
                      labelTitle: S.of(context).name,
                      textColor: ColorSchemes.gray,
                      onChange: (string) {
                        // widget.onNameChanged(string);
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldWidget(
                      isReadOnly: true,
                      controller: widget.unitNoController,
                      labelTitle: S.of(context).unitNo,
                      textColor: ColorSchemes.gray,
                      onChange: (string) {
                        // widget.onNameChanged(string);
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldWidget(
                      key: widget.idKey,
                      controller: widget.idController,
                      labelTitle: S.of(context).id,
                      onChange: (string) {
                        if (string.isNotEmpty) {
                          widget.onIdChanged(string.trim());
                        }
                      },
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      errorMessage: widget.idErrorMessage,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: widget.messageErrorMessage == null ? 64 : 85,
                      child: TextField(
                        key: widget.messageKey,
                        expands: true,
                        maxLines: null,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        controller: widget.messageController,
                        onChanged: (string) {
                          if (string.isNotEmpty) {
                            widget.onMessageChanged(string.trim());
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r' \s'),
                              replacementString: " "),
                        ],
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: Constants.fontWeightRegular,
                            color: ColorSchemes.black,
                            letterSpacing: -0.13),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorSchemes.border),
                                borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorSchemes.border),
                                borderRadius: BorderRadius.circular(8)),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorSchemes.redError),
                                borderRadius: BorderRadius.circular(8)),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorSchemes.border),
                                borderRadius: BorderRadius.circular(8)),
                            errorText: widget.messageErrorMessage,
                            labelText: S.of(context).message,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            labelStyle:
                                _labelStyle(context, _textFieldHasFocus),
                            errorMaxLines: 2),
                      ),
                    ),
                    const SizedBox(height: 20),
                    (widget.selectedImage == null && !widget.isNetwork)
                        ? GestureDetector(
                            key: widget.imageKey,
                            onTap: () {
                              widget.onTapUploadImage();
                            },
                            child: DottedBorder(
                              color: widget.selectImageErrorMessage == null
                                  ? ColorSchemes.primary
                                  : ColorSchemes.redError,
                              borderType: BorderType.RRect,
                              strokeWidth: 1,
                              radius: const Radius.circular(8),
                              child: SizedBox(
                                height: 130,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 24.0),
                                    SvgPicture.asset(
                                        ImagePaths.uploadImagePlaceholder),
                                    const SizedBox(height: 16.0),
                                    Text(
                                      S.of(context).uploadYourId,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: ColorSchemes.gray,
                                              letterSpacing: -0.13),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  widget.onTapImagePreview(widget.isNetwork
                                      ? widget.selectedImageNetwork
                                      : widget.selectedImage!.path);
                                },
                                child: SizedBox(
                                    height: 175,
                                    width: double.infinity,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: widget.isNetwork
                                            ? Image.network(
                                                widget.selectedImageNetwork,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    _buildPlaceHolderImage(),
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child: SkeletonLine(
                                                        style:
                                                            SkeletonLineStyle(
                                                      width: double.infinity,
                                                      height: 200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    )),
                                                  );
                                                },
                                              )
                                            : SizedBox(
                                                height: 175,
                                                width: double.infinity,
                                                child: Image.file(
                                                    widget.selectedImage!,
                                                    fit: BoxFit.cover),
                                              ))),
                              ),
                              Positioned.directional(
                                textDirection: Directionality.of(context),
                                end: 6,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    InkWell(
                                      onTap: () {
                                        widget.onTapDeleteImage();
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
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
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () {
                                        widget.onTapUploadImage();
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: const BoxDecoration(
                                          color: ColorSchemes.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                          ImagePaths.edit,
                                          fit: BoxFit.scaleDown,
                                          color: ColorSchemes.gray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: widget.selectImageErrorMessage != null,
                      child: Text(
                        "* ${S.of(context).thisImageRequired}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.redError,
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: widget.onTapCaptureSignature,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            key: widget.captureSignatureKey,
                            children: [
                              SvgPicture.asset(
                                ImagePaths.iconSignature,
                                color: ColorSchemes.primary,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                S.of(context).captureSignature,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: ColorSchemes.primary,
                                    ),
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              Visibility(
                                visible: (widget.signatureImage!.isNotEmpty ||
                                    (widget.signatureImageNetwork != "")),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 35,
                                      width: 70,
                                      child: widget.signatureImageNetwork != ""
                                          ? Image.network(
                                              widget.signatureImageNetwork,
                                              fit: BoxFit.fill,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  _buildPlaceHolderImage(),
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child: SkeletonLine(
                                                      style: SkeletonLineStyle(
                                                    width: double.infinity,
                                                    height: 200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  )),
                                                );
                                              },
                                            )
                                          : Image.memory(widget.signatureImage!,
                                              fit: BoxFit.fill),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        widget.onClearSignature();
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: const BoxDecoration(
                                          color: ColorSchemes.gray,
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                          ImagePaths.close,
                                          fit: BoxFit.scaleDown,
                                          color: ColorSchemes.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Visibility(
                            visible:
                                widget.captureSignatureErrorMessage != null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  "* ${S.of(context).signatureRequired}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: ColorSchemes.redError,
                                          fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      S.of(context).delegationTime,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.black,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      key: widget.dateKey,
                      children: [
                        Expanded(
                          child: CustomDatePickerTextFieldWidget(
                            controller: widget.dateFromController,
                            labelTitle: S.of(context).from,
                            onTap: () {
                              widget.onTapSelectedDate(true);
                            },
                            errorMessage: widget.dateFromErrorMessage,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CustomDatePickerTextFieldWidget(
                            controller: widget.dateToController,
                            labelTitle: S.of(context).to,
                            onTap: () {
                              widget.onTapSelectedDate(false);
                            },
                            errorMessage: widget.dateToErrorMessage,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: createDynamicListWidgets(context),
                    ),
                    const Expanded(child: SizedBox(height: 20)),
                    CustomButtonWidget(
                      onTap: () {
                        widget.onSaveOwnerData();
                        // _scrollTo();
                      },
                      width: double.infinity,
                      text: S.of(context).next,
                      backgroundColor: F.isNiceTouch
                          ? ColorSchemes.ghadeerDarkBlue
                          : ColorSchemes.primary,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> createDynamicListWidgets(BuildContext context) {
    List<Widget> list = [];
    for (var element in widget.question) {
      if (element.code == QuestionsCode.singleChoice) {
        list.add(SingleSelectionFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: element,
          showSeparator: !(element == widget.question.last),
          selectAnswer: (answerId) {
            FocusScope.of(context).unfocus();
            widget.onTapSingleSelection(element, answerId);
          },
        ));
      } else if (element.code == QuestionsCode.multiChoice) {
        list.add(MultiSelectionFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: element,
          showSeparator: !(element == widget.question.last),
          selectAnswer: (answerId) {
            FocusScope.of(context).unfocus();
            widget.onTapMultiSelection(element, answerId);
          },
        ));
      } else if (element.code == QuestionsCode.date) {
        list.add(DateTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: element,
          showSeparator: !(element == widget.question.last),
          deleteDate: () {
            widget.onTapDateDeleteAnswer(element);
          },
          pickDate: (answer) {
            widget.onTapPickDateAnswer(element, answer);
          },
        ));
      } else if (element.code == QuestionsCode.text) {
        list.add(ExtraTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: element,
          updateAnswer: false,
          showSeparator: !(element == widget.question.last),
          addAnswer: (answer) {
            widget.onTapTextAnswerQuestion(element, answer);
          },
        ));
      } else if (element.code == QuestionsCode.number) {
        list.add(NumericTextFieldWidget(
            horizontalPadding: 0,
            verticalPadding: 16,
            pageField: element,
            updateAnswer: false,
            showSeparator: !(element == widget.question.last),
            addAnswer: (answer) {
              widget.onTapNumericAnswerQuestion(element, answer);
            }));
      } else if (element.code == QuestionsCode.image) {
        list.add(UploadImageFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: element,
          showSeparator: !(element == widget.question.last),
          showUploadImageBottomSheet: () {
            widget.onShowUploadImageBottomSheet(element);
          },
          showDialogToDeleteImage: () {
            widget.onShowDialogToDeleteImage(element);
          },
        ));
      } else if (element.code == QuestionsCode.searchableSingle ||
          element.code == QuestionsCode.searchableMulti) {
        list.add(SearchableFieldWidget(
          pageField: element,
          horizontalPadding: 0,
          verticalPadding: 16,
          showSeparator: !(element == widget.question.last),
          openBottomSheet: () {
            widget.onOpenSearchableBottomSheet(
                element, element.code == QuestionsCode.searchableMulti);
          },
        ));
      }
    }
    return list;
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || widget.messageController.text.isNotEmpty) {
      return Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: widget.messageErrorMessage == null
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    } else {
      return Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: widget.messageErrorMessage == null
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    }
  }

  Widget _buildPlaceHolderImage() {
    return Image.asset(
      ImagePaths.imagePlaceHolder,
      fit: BoxFit.fill,
    );
  }
}
