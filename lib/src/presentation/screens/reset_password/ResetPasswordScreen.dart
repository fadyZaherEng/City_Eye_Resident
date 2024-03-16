import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/presentation/blocs/reset_password/reset_password_bloc.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/password_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends BaseStatefulWidget {
  final int userId;
  final int invitationId;
  final String phoneNumber;
  final bool isFromDeepLink;

  const ResetPasswordScreen({
    required this.userId,
    required this.invitationId,
    required this.phoneNumber,
    this.isFromDeepLink = false,
    super.key,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends BaseState<ResetPasswordScreen> {
  ResetPasswordBloc get _bloc => BlocProvider.of<ResetPasswordBloc>(context);

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  String? _passwordErrorMessage;
  String? _passwordConfirmationErrorMessage;

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          state.isShow ? showLoading() : hideLoading();
        } else if (state is NavigateBackState) {
          Navigator.pop(context);
        } else if (state is ValidPasswordState) {
          _passwordErrorMessage = null;
        } else if (state is InvalidPasswordState) {
          _passwordErrorMessage = state.errorMessage;
        } else if (state is ValidPasswordConfirmationState) {
          _passwordConfirmationErrorMessage = null;
        } else if (state is InvalidPasswordConfirmationState) {
          _passwordConfirmationErrorMessage = state.errorConfirmMessage;
        } else if (state is SubmitResetPasswordSuccessState) {
          Navigator.pushNamed(
            context,
            Routes.otp,
            arguments: {
              "phoneNumber": state.mobile,
              "userId": widget.userId,
              "invitationId": widget.invitationId,
              "isFromDeepLink": widget.isFromDeepLink,
            },
          );
        } else if (state is SubmitResetPasswordErrorState) {
          _showMessageDialog(state.errorMessage, ImagePaths.error, () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(),
          body: Container(
            child: _buildScreen(),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return buildAppBarWidget(context,
        title: S.of(context).resetPassword,
        textColor: ColorSchemes.white,
        backgroundColor: ColorSchemes.primary,
        isHaveBackButton: true, onBackButtonPressed: () {
          _onBack();
    });
  }

  void _backEvent() {
    Navigator.pop(context);
  }

  Widget _buildScreen() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                ImagePaths.resetPassword,
                width: 160,
                height: 160,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              S.of(context).resetPassword,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    letterSpacing: -0.24,
                    color: ColorSchemes.black,
                  ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              S
                  .of(context)
                  .thisPasswordShouldBeDifferentFromThePreviousPassword,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  letterSpacing: -0.24,
                  color: ColorSchemes.gray,
                  fontSize: 14,
                  height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 48,
            ),
            PasswordTextFieldWidget(
              errorMessage: _passwordErrorMessage,
              controller: _passwordController,
              labelTitle: S.of(context).password,
              textInputType: TextInputType.text,
              showPrefix: true,
              onChange: (value) {
                _onchangePasswordEvent(value);
              },
            ),
            const SizedBox(
              height: 24,
            ),
            PasswordTextFieldWidget(
              errorMessage: _passwordConfirmationErrorMessage,
              controller: _passwordConfirmationController,
              labelTitle: S.of(context).confirmPassword,
              textInputType: TextInputType.text,
              showPrefix: true,
              onChange: (value) {
                _onchangePasswordConfirmationEvent(value);
              },
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButtonWidget(
              width: double.infinity,
              onTap: () {
                _onTapUpdatePasswordEvent();
              },
              text: S.of(context).updatePassword,
              backgroundColor: F.isNiceTouch
                  ? ColorSchemes.ghadeerDarkBlue
                  : ColorSchemes.primary,
            )
          ],
        ),
      ),
    );
  }

  void _onchangePasswordEvent(String value) {
    _bloc.add(ValidatePasswordEvent(
      password: value,
      confirmPassword: _passwordConfirmationController.text,
    ));
  }

  void _onchangePasswordConfirmationEvent(String value) {
    _bloc.add(ValidatePasswordConfirmationEvent(
      password: _passwordController.text,
      confirmPassword: value,
    ));
  }

  void _onTapUpdatePasswordEvent() {
    _bloc.add(SubmitResetPasswordEvent(
      password: _passwordController.text,
      confirmPassword: _passwordConfirmationController.text,
      invitationId: widget.invitationId,
    ));
  }

  void _showMessageDialog(String message, String icon, Function() onTap) {
    showMassageDialogWidget(
      context: context,
      icon: icon,
      text: message,
      buttonText: S.of(context).ok,
      onTap: () {
        onTap();
      },
    );
  }

  void _onBack() {
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
      _backEvent();
    }
  }
}
