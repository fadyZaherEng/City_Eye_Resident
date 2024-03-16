import 'dart:io';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/data/sources/local/singleton/register/register_singleton.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/usecase/get_current_country_code_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/widget/compounds_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/widget/sign_in_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends BaseStatefulWidget {
  final int unitId;
  final bool isFromDeepLink;

  const SignInScreen({
    this.unitId = -1,
    this.isFromDeepLink = false,
    super.key,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _SignInScreenState();
}

class _SignInScreenState extends BaseState<SignInScreen> {
  SignInBloc get _bloc => BlocProvider.of<SignInBloc>(context);
  bool _isCheckRememberMe = false;
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _mobileNumberErrorMessage;
  String? _passwordErrorMessage;

  String _regionCode = "";
  @override
  void initState() {
    _regionCode = GetCurrentCountryCodeUseCase(injector())();
    _bloc.add(GetRememberMeEvent());
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInLoadingState) {
          showLoading();
        } else {
          hideLoading();
        }
        if (state is SignInSuccessState) {
          if (widget.unitId != -1) {
            for (int i = 0; i < state.userUnits.length; i++) {
              if (state.userUnits[i].unitId == widget.unitId) {
                _bloc.add(SelectCompoundEvent(
                  userUnit: state.userUnits[i],
                ));
              }
            }
          } else {
            _openUnitsBottomSheetEvent(
                userUnits: state.userUnits, userId: state.userId);
          }
        } else if (state is SignInErrorState) {
          _showMessageDialog(
            errorMessage: state.errorMessage,
            icon: state.icon,
          );
        } else if (state is NavigateToOTPScreenState) {
          Navigator.pushNamed(
            context,
            Routes.otp,
            arguments: {
              "phoneNumber": _mobileNumberController.text.trim(),
              "userId": state.userId,
              "invitationId": 0,
              "otp": state.otp,
              "compoundID": state.compoundID,
            },
          );
        } else if (state is ChangeRememberMeValueState) {
          _isCheckRememberMe = state.rememberMeValue;
        } else if (state is NavigateToForgotPasswordScreenEvent) {
          _navigateToForgotPasswordScreen();
        } else if (state is NavigateToSignUpScreenState) {
          _onCreateAccountState();
        } else if (state is OpenUnitsBottomSheetState) {
          openUnitsBottomSheetState(
            userUnits: state.userUnits,
            userId: state.userId,
          );
        } else if (state is SelectCompoundState) {
          _onSelectCompoundState();
        } else if (state is MobileNumberEmptyFormatState) {
          _mobileNumberErrorMessage = state.mobileNumberValidatorMessage;
        } else if (state is MobileNumberFormatValidState) {
          _mobileNumberErrorMessage = null;
        } else if (state is PasswordEmptyFormatState) {
          _passwordErrorMessage = state.passwordValidatorMessage;
        } else if (state is PasswordFormatValidState) {
          _passwordErrorMessage = null;
        } else if (state is GetRememberMeState) {
          _isCheckRememberMe = state.rememberMe;
        } else if (state is NavigateToRegisterScreenState) {
          Navigator.pushNamed(context, Routes.addUnit, arguments: {
            "userId": state.userId,
          }).then((value) {
            if (value != null) {
              if (value as bool || state.userUnits.isNotEmpty) {
                _bloc.add(SignInEvent(
                  mobileNumber: _mobileNumberController.text,
                  password: _passwordController.text,
                  regionCode: _regionCode,
                ));
              }
            }
          });
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
              _bloc.add(ChangeRememberMeValueEvent(
                rememberMeValue: false,
              ));
            return Future.value(true);
          },
          child: SignInContentWidget(
            mobileNumberController: _mobileNumberController,
            passwordController: _passwordController,
            isCheckRememberMe: _isCheckRememberMe,
            phoneNumberErrorMessage: _mobileNumberErrorMessage,
            passwordErrorMessage: _passwordErrorMessage,
            validationMobileNumberAction: (mobile, regionCode) {
              _regionCode = regionCode;
              _bloc.add(ValidateMobileNumberEvent(
                mobileNumber: mobile,
                regionCode: regionCode,
              ));
            },
            validationPasswordAction: (String value) {
              _bloc.add(ValidatePasswordEvent(
                password: value,
              ));
            },
            rememberMeAction: (bool value) {
              _bloc.add(ChangeRememberMeValueEvent(
                rememberMeValue: value,
              ));
            },
            forgetPasswordAction: () {
              _bloc.add(NavigateToForgotPasswordScreenState());
            },
            signInAction: () {
              _bloc.add(
                SignInEvent(
                  mobileNumber: _mobileNumberController.text,
                  password: _passwordController.text,
                  regionCode: _regionCode,
                ),
              );
            },
            createAccountAction: () {
              _bloc.add(
                NavigateToSignUpScreenEvent(),
              );
            },
            onCloseAction: () {
              _bloc.add(ChangeRememberMeValueEvent(
                rememberMeValue: false,
              ));
              _onSignInClose();
            },
          ),
        );
      },
    );
  }

  void _openUnitsBottomSheetEvent({
    required List<UserUnit> userUnits,
    required int userId,
  }) {
    _bloc.add(OpenUnitsBottomSheetEvent(
      userUnits: userUnits,
      userId: userId,
    ));
  }

  void _showMessageDialog({
    required String errorMessage,
    required String icon,
  }) {
    showMassageDialogWidget(
      context: context,
      text: errorMessage,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  void _navigateToForgotPasswordScreen() {
    Navigator.pushNamed(
      context,
      Routes.forgetPassword,
    );
  }

  void _onCreateAccountState() {
    Navigator.pushReplacementNamed(context, Routes.register);
  }

  double _getHeight(List<UserUnit> units, BuildContext context) {
    double height = 140;
    for (int i = 0; i < units.length; i++) {
      height += 95;
    }

    if (height < MediaQuery.of(context).size.height * 0.7) {
      return height;
    }
    return MediaQuery.of(context).size.height * 0.7;
  }

  void openUnitsBottomSheetState({
    required List<UserUnit> userUnits,
    required int userId,
  }) {
    showBottomSheetWidget(
      context: context,
      height: _getHeight(userUnits, context),
      content: CompoundsBottomSheetWidget(
        userUnits: userUnits,
        onTapItem: (UserUnit userUnit) {
          if (userUnit.isCompoundVerified == false ||
              userUnit.isActive == false) {
            _showMessageDialog(
              errorMessage: userUnit.message,
              icon: ImagePaths.info,
            );
          } else {
            _bloc.add(SelectCompoundEvent(
              userUnit: userUnit,
            ));
          }
        },
        onTapAddAnotherUnit: () {
          Navigator.pop(context);
          _bloc.add(NavigateToRegisterScreenEvent(
              userId: userId, userUnits: userUnits));
        },
      ),
      titleLabel: S.of(context).selectCompound,
    );
  }

  void _onSelectCompoundState() {
    final RegisterSingleton registerSingleton = RegisterSingleton();
    registerSingleton.clearAllData();
    Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false,
        arguments: {
          "selectIndex": 0,
        });
  }

  void _onSignInClose() {
    if (widget.isFromDeepLink) {
      User? user = GetUserInformationUseCase(injector())();
      if (user.userInformation.id == -1) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.landing,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.main,
          (route) => false,
          arguments: {
            "selectIndex": 0,
          },
        );
      }
    } else {
      Navigator.pop(context);
    }
  }
}
