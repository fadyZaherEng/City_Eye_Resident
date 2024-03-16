import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericTextFieldWidget extends StatefulWidget {
  final PageField pageField;
  final Function(String) addAnswer;
  final double verticalPadding;
  final double horizontalPadding;
  final bool updateAnswer;
  final bool showSeparator;

  const NumericTextFieldWidget({
    Key? key,
    required this.pageField,
    required this.addAnswer,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
    this.updateAnswer = false,
    this.showSeparator = true,
  }) : super(key: key);

  @override
  State<NumericTextFieldWidget> createState() => _NumericTextFieldWidgetState();
}

class _NumericTextFieldWidgetState extends State<NumericTextFieldWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void didUpdateWidget(covariant NumericTextFieldWidget oldWidget) {
    if (widget.updateAnswer) controller.text = widget.pageField.value ?? "";
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    controller.text = widget.pageField.value;
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
              horizontal: widget.horizontalPadding),
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
                child: CustomTextFieldWidget(
                  controller: controller,
                  labelTitle: widget.pageField.description ?? "",
                  onChange: (value) {
                    controller.text.trim();
                    widget.addAnswer(value.trim());
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textInputType: TextInputType.number,
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
}
