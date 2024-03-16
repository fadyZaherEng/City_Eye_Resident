import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/password_text_field_widget.dart';
import 'package:flutter/material.dart';

class ChangePasswordContentWidget extends StatelessWidget {
  final Function() onBackButtonPressed;
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final void Function(String value) onChangeOldPassword;
  final void Function(String value) onChangeNewPassword;
  final void Function(String value) onChangeConfirmPassword;
  final Function() changePasswordAction;
  final String? oldPasswordErrorMessage;
  final String? newPasswordErrorMessage;
  final String? confirmPasswordErrorMessage;

  const ChangePasswordContentWidget({
    Key? key,
    required this.onBackButtonPressed,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onChangeOldPassword,
    required this.onChangeNewPassword,
    required this.onChangeConfirmPassword,
    required this.changePasswordAction,
    this.oldPasswordErrorMessage,
    this.newPasswordErrorMessage,
    this.confirmPasswordErrorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).changePassword,
        isHaveBackButton: true,
        onBackButtonPressed: onBackButtonPressed,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            PasswordTextFieldWidget(
              errorMessage: oldPasswordErrorMessage,
              controller: oldPasswordController,
              labelTitle: S.of(context).oldPassword,
              onChange: (value) => onChangeOldPassword(
                value,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            PasswordTextFieldWidget(
              errorMessage: newPasswordErrorMessage,
              controller: newPasswordController,
              labelTitle: S.of(context).newPassword,
              onChange: (value) => onChangeNewPassword(
                value,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            PasswordTextFieldWidget(
              errorMessage: confirmPasswordErrorMessage,
              controller: confirmPasswordController,
              labelTitle: S.of(context).confirmPassword,
              onChange: (value) => onChangeConfirmPassword(
                value,
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            CustomButtonWidget(
              width: double.infinity,
              height: 48,
              onTap: changePasswordAction,
              text: S.of(context).changePassword,
              backgroundColor: F.isNiceTouch
                  ? ColorSchemes.ghadeerDarkBlue
                  : ColorSchemes.primary,
            )
          ]),
        ),
      ),
    );
  }
}
