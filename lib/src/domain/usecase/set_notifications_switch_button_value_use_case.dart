import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetNotificationsSwitchButtonValueUseCase {
  final SharedPreferences sharedPreferences;

  SetNotificationsSwitchButtonValueUseCase(this.sharedPreferences);

  Future<bool> call(bool notificationSwitchButtonValue) async {
    return await sharedPreferences.setBool(
        SharedPreferenceKeys.notificationSwitchButtonValue,
        notificationSwitchButtonValue);
  }
}
