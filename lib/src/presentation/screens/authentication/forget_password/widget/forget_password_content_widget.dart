import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordContentWidget extends StatefulWidget {
  final TextEditingController emailAddressController;
  final String? emailErrorMessage;
  final void Function(String value) validateEmailAction;
  final Function() resetPasswordAction;

  const ForgetPasswordContentWidget({
    Key? key,
    required this.emailAddressController,
    this.emailErrorMessage,
    required this.validateEmailAction,
    required this.resetPasswordAction,
  }) : super(
          key: key,
        );

  @override
  State<ForgetPasswordContentWidget> createState() =>
      _ForgetPasswordContentWidgetState();
}

class _ForgetPasswordContentWidgetState
    extends State<ForgetPasswordContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        16,
      ),
      child: Column(
        children: [
          Text(
            S.of(context).enterTheEmailAddressAssociatedWithYourAccountAndWe,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  letterSpacing: -0.24,
                  color: ColorSchemes.black,
                ),
          ),
          const SizedBox(
            height: 52,
          ),
          CustomTextFieldWidget(
              textInputType: TextInputType.emailAddress,
              errorMessage: widget.emailErrorMessage,
              controller: widget.emailAddressController,
              labelTitle: S.of(context).emailAddress,
              onChange: (value) {
                widget.validateEmailAction(
                  value,
                );
              }),
          const SizedBox(
            height: 40,
          ),
          CustomButtonWidget(
            onTap: widget.resetPasswordAction,
            text: S.of(context).resetPassword,
            width: double.infinity,
            backgroundColor: F.isNiceTouch
                ? ColorSchemes.ghadeerDarkBlue
                : ColorSchemes.primary,
          )
        ],
      ),
    );
  }
}
