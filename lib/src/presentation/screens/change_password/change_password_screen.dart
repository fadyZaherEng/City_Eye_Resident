import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:city_eye/src/presentation/screens/change_password/widgets/change_password_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends BaseStatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends BaseState<ChangePasswordScreen> {
  ChangePasswordBloc get _bloc => BlocProvider.of<ChangePasswordBloc>(context);

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _oldPasswordErrorMessage;
  String? _newPasswordErrorMessage;
  String? _confirmPasswordErrorMessage;

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
      if (state is ShowLoadingState) {
        showLoading();
      } else if(state is HideLoadingState) {
        hideLoading();
      } else if (state is ChangePasswordSuccessState) {
        _showMessageDialog(
          state.message,
          ImagePaths.success,
          () {
            _bloc.add(NavigationBackEvent());
            _bloc.add(NavigationBackEvent());
          },
        );
      } else if (state is ChangePasswordErrorState) {
        _showMessageDialog(
          state.errorMessage,
          ImagePaths.error,
          () {
            _bloc.add(NavigationBackEvent());
          },
        );
      } else if (state is OldPasswordEmptyFormatState) {
        _oldPasswordErrorMessage = state.oldPasswordValidatorMessage;
      } else if (state is NewPasswordEmptyFormatState) {
        _newPasswordErrorMessage = state.newPasswordValidatorMessage;
      } else if (state is ConfirmPasswordEmptyFormatState) {
        _confirmPasswordErrorMessage = state.confirmPasswordValidatorMessage;
      } else if (state is ConfirmPasswordNotMatchNewPasswordFormatState) {
        _confirmPasswordErrorMessage = state.confirmPasswordValidatorMessage;
      } else if (state is NewPasswordMostBeMustBeSixCharacterFormatState) {
        _newPasswordErrorMessage = state.newPasswordValidatorMessage;
      } else if (state is OldPasswordFormatValidState) {
        _oldPasswordErrorMessage = null;
      } else if (state is NewPasswordFormatValidState) {
        _newPasswordErrorMessage = null;
      } else if (state is ConfirmPasswordFormatValidState) {
        _confirmPasswordErrorMessage = null;
      } else if (state is NavigationBackState) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      return _buildContent();
    });
  }

  Widget _buildContent() {
    return ChangePasswordContentWidget(
      oldPasswordController: _oldPasswordController,
      newPasswordController: _newPasswordController,
      confirmPasswordController: _confirmPasswordController,
      oldPasswordErrorMessage: _oldPasswordErrorMessage,
      newPasswordErrorMessage: _newPasswordErrorMessage,
      confirmPasswordErrorMessage: _confirmPasswordErrorMessage,
      onBackButtonPressed: () {
        _bloc.add(NavigationBackEvent());
      },
      onChangeOldPassword: (String value) {
        _bloc.add(ValidateOldPasswordEvent(
          oldPassword: value,
        ));
      },
      onChangeNewPassword: (String value) {
        _bloc.add(ValidateNewPasswordEvent(
          newPassword: value,
        ));
      },
      onChangeConfirmPassword: (String value) {
        _bloc.add(ValidateConfirmPasswordEvent(
          newPassword: _newPasswordController.text,
          confirmPassword: value,
        ));
      },
      changePasswordAction: () {
        _changePasswordEvent();
      },
    );
  }

  void _looseKeyboardFocus() => FocusScope.of(context).unfocus();

  bool isDebouncing = false;

  void _changePasswordEvent() {
    if (!isDebouncing) {
      setState(() {
        isDebouncing = true;
      });
      _bloc.add(ChangePasswordEvent(
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
        confirmPassword: _confirmPasswordController.text,
      ));

      Timer(Duration(seconds: 1), () {
        setState(() {
          isDebouncing = false;
        });
      });
    }
  }

  void _showMessageDialog(
    String message,
    String icon,
    Function() onTap,
  ) {
    showMassageDialogWidget(
      context: context,
      text: message,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: onTap,
    );
  }
}
