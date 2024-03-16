import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetSwitchLogoUseCase {
  final SharedPreferences sharedPreferences;

  SetSwitchLogoUseCase(this.sharedPreferences);

  Future<bool> call(String logo) async {
    return await sharedPreferences.setString(SharedPreferenceKeys.isSwitch, logo);
  }
}