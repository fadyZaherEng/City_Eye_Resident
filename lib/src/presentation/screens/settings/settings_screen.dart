import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/settings/language.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_notifications_switch_button_value_use_case.dart';
import 'package:city_eye/src/presentation/blocs/settings/settings_bloc.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/widget/compounds_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/screens/landing/utils/show_language_bottom_sheet.dart';
import 'package:city_eye/src/presentation/screens/settings/widgets/settings_content_widget.dart';
import 'package:city_eye/src/presentation/widgets/restart_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends BaseStatefulWidget {
  const SettingsScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseState<SettingsScreen> {
  SettingsBloc get _bloc => BlocProvider.of<SettingsBloc>(context);
  String _appVersion = '';
  bool _notificationsSwitchButtonValue = false;
  Language _selectedLanguage = const Language();
  List<Language> _languages = [];

  @override
  void initState() {
    _bloc.add(GetNotificationsSwitchButtonValueEvent());
    _bloc.add(GetAppVersionEvent());
    _bloc.add(GetLanguageEvent());
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) async {
      if (state is ShowLoadingState) {
        showLoading();
      } else if (state is HideLoadingState) {
        hideLoading();
      } else if (state is NavigateBackState) {
        Navigator.pop(context);
      } else if (state is GetLanguagesSuccessState) {
        _languages = state.languages;
        _bloc.add(OpenLanguagesBottomSheetEvent(
          languages: _languages,
        ));
      } else if (state is GetLanguagesErrorState) {
        showSnackBar(
          context: context,
          message: state.message,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      } else if (state is GetLanguageState) {
        _selectedLanguage = _selectedLanguage.copyWith(
          code: state.languageCode,
        );
      } else if (state is NavigationPopState) {
        _onNavigationPopState();
      } else if (state is NavigationToNotificationsScreenState) {
        _onSwitchNotificationsState();
      } else if (state is NavigationToChangePasswordScreenState) {
        _onNavigationToChangePasswordScreenState();
      } else if (state is GetLanguageState) {
        _selectedLanguage = _selectedLanguage.copyWith(
          code: state.languageCode,
        );
      } else if (state is OpenLanguagesBottomSheetState) {
        _openLanguagesBottomSheet();
      } else if (state is OpenCompoundsBottomSheetState) {
        _onOpenCompoundsBottomSheetState(
          userUnits: state.userUnits,
          context: context,
        );
      } else if (state is EnableDisableNotificationSuccessState) {
        _notificationsSwitchButtonValue = state.value;
        showSnackBar(
          context: context,
          message: state.message,
          color: ColorSchemes.snackBarSuccess,
          icon: ImagePaths.success,
        );
      } else if (state is EnableDisableNotificationErrorState) {
        showSnackBar(
          context: context,
          message: state.message,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      } else if (state is GetNotificationsSwitchButtonValueState) {
        _notificationsSwitchButtonValue = state.value;
      } else if (state is GetAppVersionState) {
        _appVersion = state.appVersion;
      } else if (state is SetLanguageState) {
        _restartApp();
      } else if (state is SelectCompoundState) {
        _restartApp();
      } else if (state is DeleteUnitSuccessState) {
        hideLoading();
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.landing, (route) => false);
        showSnackBar(
          context: context,
          message: state.message,
          color: ColorSchemes.snackBarSuccess,
          icon: ImagePaths.success,
        );
      } else if (state is DeleteUnitLoadingState) {
        showLoading();
      } else if (state is GetUserUnitsErrorState) {
        showSnackBar(
          context: context,
          message: state.message,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      } else if (state is DeleteAccountSuccessState) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.landing, (route) => false);
        showSnackBar(
          context: context,
          message: state.message,
          color: ColorSchemes.snackBarSuccess,
          icon: ImagePaths.success,
        );
      } else if (state is DeleteAccountErrorState) {
        showSnackBar(
          context: context,
          message: state.errorMessage,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      }
    }, builder: (context, state) {
      return SettingsContentWidget(
        onBackButtonPressed: () {
          _bloc.add(
            NavigationPopEvent(),
          );
        },
        onTapNotificationAction: () {
          _bloc.add(
            NavigationToNotificationsScreenEvent(),
          );
        },
        changePasswordAction: () {
          _bloc.add(
            NavigationToChangePasswordScreenEvent(),
          );
        },
        languageAction: () {
          _bloc.add(GetLanguagesEvent());
        },
        switchCompoundAction: () {
          _bloc.add(
            OpenCompoundsBottomSheetEvent(),
          );
        },
        versionText: _appVersion,
        notificationsSwitchButtonValue: _notificationsSwitchButtonValue,
        onSwitchButtonAction: (value) async {
          if (Platform.isIOS) {
            await _setupNotificationPermission(value: value);
          } else {
            final int resultCode =
                await HmsApiAvailability().isHMSAvailableWithApkVersion(28);
            if (resultCode == 1) {
              await _setupNotificationPermission(value: value);
            } else {
              _bloc.add(EnableDisableNotificationsEvent(
                value: value,
              ));
            }
          }
        },
        deActivateUnitAction: () {
          _messageActionDialog(
            text:
                "${S.of(context).areYouSureYouWantToDeactivateThisUnit} (${GetUserUnitUseCase(injector())().unitName})${S.of(context).questionMark}",
            primaryAction: () {
              Navigator.pop(context);
              _bloc.add(DeleteUnitEvent());
            },
          );
        },
        deleteUnitAction: () {
          _messageActionDialog(
            text:
                "${S.of(context).areYouSureYouWantToDeleteThisUnit}${S.of(context).questionMark}",
            primaryAction: () {
              Navigator.pop(context);
              _bloc.add(DeleteAccountEvent());
            },
          );
        },
      );
    });
  }

  Future _setupNotificationPermission({required bool value}) async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await SetNotificationsSwitchButtonValueUseCase(injector())(value);
      _bloc.add(EnableDisableNotificationsEvent(
        value: value,
      ));
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      await SetNotificationsSwitchButtonValueUseCase(injector())(value);
      _bloc.add(EnableDisableNotificationsEvent(
        value: value,
      ));
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      await SetNotificationsSwitchButtonValueUseCase(injector())(false);
      _messageActionDialog(
        text: S.current.youShouldAllowThisPermissionToContinue,
        primaryText: S.current.settings,
        secondaryText: S.current.cancel,
        primaryAction: () {
          Navigator.pop(context);
          openAppSettings().then((value) async {
            if (await PermissionServiceHandler()
                .handleServicePermission(setting: Permission.notification)) {
              _bloc.add(EnableDisableNotificationsEvent(
                value: value,
              ));
            }
          });
        },
      );
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      await SetNotificationsSwitchButtonValueUseCase(injector())(false);
    }
  }

  void _onNavigationPopState() {
    Navigator.pop(context);
  }

  void _onSwitchNotificationsState() {}

  void _onNavigationToChangePasswordScreenState() {
    Navigator.pushNamed(context, Routes.changePassword);
  }

  void _openLanguagesBottomSheet() {
    showLanguageBottomSheet(
      context: context,
      height: 400,
      languages: _languages,
      selectedLanguage: _selectedLanguage,
      onLanguageSelected: (language) {
        // Navigator.of(context).pop();
        if (language.code == _selectedLanguage.code) return;
        _selectedLanguage = language;
        _bloc.add(
          SetLanguageEvent(
            languageCode: _selectedLanguage.code,
          ),
        );
        Navigator.of(context).pop();
      },
    );
  }

  void _onOpenCompoundsBottomSheetState({
    required List<UserUnit> userUnits,
    required BuildContext context,
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
              userUnit.message,
              ImagePaths.info,
              () {
                Navigator.of(context).pop();
              },
            );
          } else {
            _bloc.add(
              SelectUnitEvent(
                userUnit: userUnit,
              ),
            );
          }
        },
        onTapAddAnotherUnit: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.addUnit, arguments: {
            "userId": -1,
          });
        },
      ),
      titleLabel: S.of(context).selectCompound,
    ).whenComplete(
        () => _bloc.add(WhenCompletedOpenCompoundsBottomSheetEvent()));
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

  void _messageActionDialog({
    required String text,
    required Function() primaryAction,
    String? primaryText,
    String? secondaryText,
  }) {
    showActionDialogWidget(
        context: context,
        text: text,
        icon: ImagePaths.warning,
        primaryText: primaryText ?? S.of(context).yes,
        secondaryText: secondaryText ?? S.of(context).no,
        primaryAction: () {
          primaryAction();
        },
        secondaryAction: () {
          Navigator.pop(context);
        });
  }

  void _restartApp() async {
    (await SharedPreferences.getInstance())
        .setBool(SharedPreferenceKeys.isRestart, true);
    RestartWidget.restartApp(context);
  }
}
