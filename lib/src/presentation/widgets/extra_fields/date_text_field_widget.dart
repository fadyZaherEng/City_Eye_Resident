import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/android_date_picker.dart';
import 'package:city_eye/src/core/utils/ios_date_picker.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_with_suffix_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DateTextFieldWidget extends StatefulWidget {
  final PageField pageField;
  final Function(String) pickDate;
  final Function() deleteDate;
  final double verticalPadding;
  final double horizontalPadding;
  final bool showSeparator;

  const DateTextFieldWidget({
    Key? key,
    required this.pageField,
    required this.pickDate,
    required this.deleteDate,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
    this.showSeparator = true,
  }) : super(key: key);

  @override
  State<DateTextFieldWidget> createState() => _DateTextFieldWidgetState();
}

class _DateTextFieldWidgetState extends State<DateTextFieldWidget> {
  TextEditingController controller = TextEditingController();
  DateTime? selectedDate;

  @override
  void didUpdateWidget(covariant DateTextFieldWidget oldWidget) {
    controller.text = widget.pageField.value ?? "";
    selectedDate = widget.pageField.value.isNotEmpty
        ? DateTime.parse(widget.pageField.value)
        : null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    controller.text = widget.pageField.value;
    selectedDate = widget.pageField.value.isNotEmpty
        ? DateTime.parse(widget.pageField.value)
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: widget.pageField.key,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding,
            horizontal: widget.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.pageField.label ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorSchemes.black),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                child: CustomTextFieldWithSuffixIconWidget(
                  controller: controller,
                  labelTitle: widget.pageField.description,
                  onTap: () {
                    selectDate();
                  },
                  suffixIcon: selectedDate == null || controller.text == ""
                      ? SvgPicture.asset(
                          ImagePaths.selectDate,
                          fit: BoxFit.scaleDown,
                          matchTextDirection: true,
                        )
                      : InkWell(
                          onTap: () {
                            widget.deleteDate();
                            selectedDate = null;
                            controller.text = "";
                          },
                          child: SvgPicture.asset(
                            ImagePaths.close,
                            fit: BoxFit.scaleDown,
                            matchTextDirection: true,
                          ),
                        ),
                  isReadOnly: true,
                  errorMessage: widget.pageField.notAnswered &&
                      widget.pageField.isRequired
                      ? S.of(context).thisFieldIsRequired
                      : !widget.pageField.isValid
                      ? widget.pageField.validationMessage
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
        Visibility(
          visible: widget.showSeparator,
          child: const Divider(
            height: 1,
            color: ColorSchemes.gray,
          ),
        ),
      ],
    );
  }

  void selectDate() {
    if (Platform.isAndroid) {
      androidDatePicker(
        context: context,
        firstDate: DateTime(1900),
        onSelectDate: (date) {
          if (date == null) return;
          controller.text = date.toString().split(" ")[0];
          widget.pickDate(controller.text);
          selectedDate = date;
        },
        selectedDate: selectedDate,
      );
    } else {
      DateTime tempDate = selectedDate ?? DateTime.now();
      iosDatePicker(
        context: context,
        selectedDate: selectedDate,
        onChange: (date) {
          tempDate = date;
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
        onDone: () {
          selectedDate = tempDate;
          controller.text = selectedDate.toString().split(" ")[0];
          widget.pickDate(controller.text);
          Navigator.of(context).pop();
        },
      );
    }
  }
}