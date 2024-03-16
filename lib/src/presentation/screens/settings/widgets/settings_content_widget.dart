import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/screens/settings/widgets/notification_switch_button_widget.dart';
import 'package:city_eye/src/presentation/screens/settings/widgets/settings_item_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';

class SettingsContentWidget extends StatelessWidget {
  final String versionText;
  final bool notificationsSwitchButtonValue;
  final Function() onBackButtonPressed;
  final void Function(bool value) onSwitchButtonAction;
  final Function() onTapNotificationAction;
  final Function() changePasswordAction;
  final Function() languageAction;
  final Function() switchCompoundAction;
  final Function() deActivateUnitAction;
  final Function() deleteUnitAction;

  const SettingsContentWidget({
    Key? key,
    required this.versionText,
    required this.onBackButtonPressed,
    required this.onSwitchButtonAction,
    required this.changePasswordAction,
    required this.languageAction,
    required this.switchCompoundAction,
    required this.notificationsSwitchButtonValue,
    required this.onTapNotificationAction,
    required this.deActivateUnitAction,
    required this.deleteUnitAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).settings,
        isHaveBackButton: true,
        onBackButtonPressed: onBackButtonPressed,
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          children: [
            SettingsItemWidget(
              haveLeading: true,
              image: ImagePaths.notification,
              text: S.of(context).notifications,
              onTap: onTapNotificationAction,
              leading: NotificationsSwitchButtonWidget(
                value: notificationsSwitchButtonValue,
                onTap: (bool value) => onSwitchButtonAction(value),
              ),
            ),
            const SizedBox(height: 32),
            SettingsItemWidget(
              image: ImagePaths.changePassword,
              text: S.of(context).changePassword,
              onTap: changePasswordAction,
            ),
            const SizedBox(height: 32),
            SettingsItemWidget(
              image: ImagePaths.language,
              text: S.of(context).language,
              onTap: languageAction,
            ),
            const SizedBox(height: 32),
            SettingsItemWidget(
              haveLeading: true,
              leading: Text(
                versionText,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorSchemes.black,
                    ),
              ),
              image: ImagePaths.version,
              text: S.of(context).version,
              onTap: () {},
            ),
            const SizedBox(height: 32),
            SettingsItemWidget(
              image: ImagePaths.buildings,
              text: S.of(context).switchCompound,
              onTap: switchCompoundAction,
            ),
            const SizedBox(height: 32),
            SettingsItemWidget(
              image: ImagePaths.deleteAccount,
              text: S.of(context).deactivateUnit,
              onTap: deActivateUnitAction,
              textColor: ColorSchemes.redError,
            ),
            const SizedBox(height: 32),
            SettingsItemWidget(
              image: ImagePaths.deleteAccount,
              text: S.of(context).deleteAccount,
              onTap: deleteUnitAction,
              textColor: ColorSchemes.redError,
            ),
          ],
        ),
      ),
    );
  }
}
