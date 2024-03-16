// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_mobile_number_widget.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:skeletons/skeletons.dart';

// ignore: must_be_immutable
class AuthorizedWidget extends StatefulWidget {
  var nameController = TextEditingController();
  var idController = TextEditingController();
  var mobileNoController = TextEditingController();

  final void Function(String value) onNameChanged;
  final void Function(String value) onIdChanged;
  final void Function(String phone, String code) onMobileNumberChanged;
  final void Function() onTapUploadImage;
  final void Function() onTapDeleteImage;
  final VoidCallback onTapCaptureSignature;
  final void Function() onClearSignature;
  final void Function() onSaveAuthData;

  final File? selectedImage;
  final Uint8List? signatureImage;
  final String signatureImageNetwork;
  final String selectedImageNetwork;
  final bool isNetwork;

  final String? nameErrorMessage;
  final String? idErrorMessage;
  final String? mobileNumberErrorMessage;
  final String? selectImageErrorMessage;
  final String? signatureErrorMessage;

  bool isCaptureSignature = false;

  String mobileInitialValue = "";
  String countryCode = "";

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
  final void Function(String) onTapImagePreview;

  final GlobalKey nameKey;
  final GlobalKey idKey;
  final GlobalKey mobileKey;
  final GlobalKey imageKey;
  final GlobalKey captureSignatureKey;

  AuthorizedWidget(
      {required this.question,
      required this.nameKey,
      required this.idKey,
      required this.imageKey,
      required this.mobileKey,
      required this.captureSignatureKey,
      required this.onTapSingleSelection,
      required this.onTapMultiSelection,
      required this.onTapDateDeleteAnswer,
      required this.onTapPickDateAnswer,
      required this.onTapTextAnswerQuestion,
      required this.onTapNumericAnswerQuestion,
      required this.onShowUploadImageBottomSheet,
      required this.onShowDialogToDeleteImage,
      required this.nameController,
      required this.idController,
      required this.mobileNoController,
      required this.nameErrorMessage,
      required this.idErrorMessage,
      required this.mobileNumberErrorMessage,
      required this.selectImageErrorMessage,
      required this.signatureErrorMessage,
      required this.selectedImage,
      required this.onNameChanged,
      required this.onIdChanged,
      required this.onMobileNumberChanged,
      required this.onClearSignature,
      required this.onSaveAuthData,
      required this.onTapCaptureSignature,
      required this.onTapUploadImage,
      required this.onTapDeleteImage,
      required this.isCaptureSignature,
      required this.signatureImage,
      required this.selectedImageNetwork,
      required this.signatureImageNetwork,
      required this.isNetwork,
      required this.onOpenSearchableBottomSheet,
      required this.mobileInitialValue,
      required this.countryCode,
      required this.onTapImagePreview,
      super.key});

  @override
  State<AuthorizedWidget> createState() => _AuthorizedWidgetState();
}

class _AuthorizedWidgetState extends State<AuthorizedWidget> {
  @override
  void initState() {
    setState(() {});
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
                      key: widget.nameKey,
                      controller: widget.nameController,
                      labelTitle: S.of(context).name,
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          widget.onNameChanged(value.trim());
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r' \s'),
                            replacementString: " "),
                      ],
                      errorMessage: widget.nameErrorMessage,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldWidget(
                      key: widget.idKey,
                      controller: widget.idController,
                      labelTitle: S.of(context).id,
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          widget.onIdChanged(value.trim());
                        }
                      },
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      errorMessage: widget.idErrorMessage,
                    ),
                    const SizedBox(height: 25),
                    CustomMobileNumberWidget(
                      key: widget.mobileKey,
                      initialValue: widget.mobileInitialValue,
                      controller: widget.mobileNoController,
                      labelTitle: S.of(context).mobileNumber,
                      countryCode: widget.countryCode,
                      onChange: (phone, code) {
                        widget.mobileNoController.text = phone.toString();
                        widget.onMobileNumberChanged(phone.trim(), code);
                      },
                      errorMessage: widget.mobileNumberErrorMessage,
                      languageCode: GetLanguageUseCase(injector())(),
                    ),
                    const SizedBox(height: 16),
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
                              strokeWidth: 1,
                              radius: const Radius.circular(8.0),
                              dashPattern: const [4, 2],
                              child: Center(
                                child: SizedBox(
                                  height: 130,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          ImagePaths.uploadImagePlaceholder),
                                      const SizedBox(height: 8),
                                      Text(
                                        S.of(context).uploadYourId,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: ColorSchemes.gray,
                                            ),
                                      ),
                                    ],
                                  ),
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
                      child: Row(
                        key: widget.captureSignatureKey,
                        children: [
                          SvgPicture.asset(
                            ImagePaths.iconSignature,
                            color: ColorSchemes.primary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            S.of(context).captureSignature,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: ColorSchemes.primary,
                                    ),
                          ),
                          const Expanded(
                              child: SizedBox(
                            width: 10,
                          )),
                          Visibility(
                            visible: (widget.signatureImage!.isNotEmpty ||
                                widget.signatureImageNetwork != ""),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 70,
                                  child: widget.signatureImageNetwork != ""
                                      ? Image.network(
                                          widget.signatureImageNetwork,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  _buildPlaceHolderImage(),
                                          loadingBuilder: (BuildContext context,
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
                                                    BorderRadius.circular(8),
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
                    ),
                    Column(
                      children: createDynamicListWidgets(context),
                    ),
                    const Expanded(child: SizedBox(height: 20)),
                    CustomButtonWidget(
                      onTap: () {
                        widget.onSaveAuthData();
                      },
                      width: double.infinity,
                      text: S.of(context).save,
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

  Widget _buildPlaceHolderImage() {
    return Image.asset(
      ImagePaths.imagePlaceHolder,
      fit: BoxFit.fill,
    );
  }
}
