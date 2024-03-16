import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/presentation/widgets/custom_mobile_number_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/password_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileWidget extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailAddressController;
  final TextEditingController mobileNumberController;
  final TextEditingController passwordController;
  final String? fullNameErrorMessage;
  final String? emailAddressErrorMessage;
  final String? mobileNumberErrorMessage;
  final String? passwordErrorMessage;
  final String countryCode;
  final Function(String value) onChangeFullName;
  final Function(String value) onChangeEmailAddress;
  final Function(String number, String code) onChangeMobileNumber;
  final Function(String value) onChangePassword;

  const ProfileWidget({
    Key? key,
    required this.fullNameController,
    required this.emailAddressController,
    required this.mobileNumberController,
    required this.onChangeFullName,
    required this.onChangeEmailAddress,
    required this.onChangeMobileNumber,
    required this.fullNameErrorMessage,
    required this.countryCode,
    required this.emailAddressErrorMessage,
    required this.mobileNumberErrorMessage,
    required this.passwordController,
    required this.passwordErrorMessage,
    required this.onChangePassword,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 36),
              CustomTextFieldWidget(
                errorMessage: widget.fullNameErrorMessage,
                controller: widget.fullNameController,
                labelTitle: S.of(context).fullName,
                onChange: (value) => widget.onChangeFullName(value),
              ),
              const SizedBox(height: 32),
              CustomTextFieldWidget(
                textInputType: TextInputType.emailAddress,
                errorMessage: widget.emailAddressErrorMessage,
                controller: widget.emailAddressController,
                labelTitle: S.of(context).emailAddress,
                onChange: (value) => widget.onChangeEmailAddress(value),
              ),
              const SizedBox(height: 32),
              CustomMobileNumberWidget(
                textInputType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                errorMessage: widget.mobileNumberErrorMessage,
                controller: widget.mobileNumberController,
                labelTitle: S.of(context).mobileNumber,
                languageCode: GetLanguageUseCase(injector())(),
                countryCode: widget.countryCode,
                initialValue: widget.mobileNumberController.text,
                onChange: (number, code) {
                  widget.mobileNumberController.text = number.trim().toString();
                  widget.onChangeMobileNumber(number, code);
                },
              ),
              const SizedBox(height: 32),
              PasswordTextFieldWidget(
                errorMessage: widget.passwordErrorMessage,
                controller: widget.passwordController,
                labelTitle: S.of(context).password,
                onChange: (value) => widget.onChangePassword(value),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
