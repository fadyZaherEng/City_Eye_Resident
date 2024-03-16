import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetNotificationsSwitchButtonValueUseCase {
  final SharedPreferences sharedPreferences;

  GetNotificationsSwitchButtonValueUseCase(this.sharedPreferences);

  bool call() {
    return sharedPreferences
            .getBool(SharedPreferenceKeys.notificationSwitchButtonValue) ??
        true;
  }
}
