import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/usecase/get_current_country_code_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/widget/create_account_widget.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/widget/forget_password_widget.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/widget/remember_me_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_mobile_number_widget.dart';
import 'package:city_eye/src/presentation/widgets/password_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInContentWidget extends StatefulWidget {
  final TextEditingController mobileNumberController;
  final TextEditingController passwordController;
  final bool isCheckRememberMe;
  final String? phoneNumberErrorMessage;
  final String? passwordErrorMessage;
  final void Function(String mobile, String regionCode)
      validationMobileNumberAction;
  final void Function(String value) validationPasswordAction;
  final void Function(bool value) rememberMeAction;
  final Function() forgetPasswordAction;
  final Function() signInAction;
  final Function() createAccountAction;
  final Function() onCloseAction;

  const SignInContentWidget({
    Key? key,
    required this.mobileNumberController,
    required this.passwordController,
    required this.isCheckRememberMe,
    this.phoneNumberErrorMessage,
    this.passwordErrorMessage,
    required this.validationMobileNumberAction,
    required this.validationPasswordAction,
    required this.rememberMeAction,
    required this.forgetPasswordAction,
    required this.signInAction,
    required this.createAccountAction,
    required this.onCloseAction,
  }) : super(
          key: key,
        );

  @override
  State<SignInContentWidget> createState() => _SignInContentWidgetState();
}

class _SignInContentWidgetState extends State<SignInContentWidget>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  double _bottomPadding = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(
      this,
    );
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final isKeyboardOpen =
        WidgetsBinding.instance.window.viewInsets.bottom != 0.0;
    setState(() {
      _bottomPadding =
          isKeyboardOpen ? MediaQuery.of(context).viewInsets.bottom / 1.3 : 0.0;
    });
    if (isKeyboardOpen) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: _bottomPadding,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: widget.onCloseAction,
                          child: SvgPicture.asset(
                            ImagePaths.close,
                            height: 20,
                            width: 20,
                            color: ColorSchemes.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    SvgPicture.asset(
                      ImagePaths.logo,
                      height: 130,
                      width: 130,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    CustomMobileNumberWidget(
                      onChange: (number, code) {
                        widget.mobileNumberController.text = number.toString();
                        widget.validationMobileNumberAction(
                          number.toString(),
                          code.toString(),
                        );
                      },
                      countryCode: GetCurrentCountryCodeUseCase(injector())(),
                      controller: widget.mobileNumberController,
                      labelTitle: S.of(context).mobileNumber,
                      errorMessage: widget.phoneNumberErrorMessage,
                      languageCode: GetLanguageUseCase(injector())(),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    PasswordTextFieldWidget(
                      errorMessage: widget.passwordErrorMessage,
                      controller: widget.passwordController,
                      labelTitle: S.of(context).password,
                      onChange: (value) {
                        widget.validationPasswordAction(
                          value,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RememberMeWidget(
                          isCheckRememberMe: widget.isCheckRememberMe,
                          onTap: () {
                            widget.rememberMeAction(
                              !widget.isCheckRememberMe,
                            );
                          },
                          onChange: (bool value) {
                            widget.rememberMeAction(
                              value,
                            );
                          },
                        ),
                        ForgetPasswordWidget(
                          onTap: widget.forgetPasswordAction,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 47,
                    ),
                    CustomButtonWidget(
                      width: double.infinity,
                      onTap: widget.signInAction,
                      text: S.of(context).signIn,
                      backgroundColor: F.isNiceTouch
                          ? ColorSchemes.ghadeerDarkBlue
                          : ColorSchemes.primary,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        CreateAccountWidget(
          onTap: widget.createAccountAction,
        ),
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(
      this,
    );
    _scrollController.dispose();
    super.dispose();
  }
}
