import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveCurrentCountryCodeUseCase {
  final SharedPreferences sharedPreferences;

  SaveCurrentCountryCodeUseCase(this.sharedPreferences);

  Future<bool> call(String code) async {
    return await sharedPreferences.setString(
        SharedPreferenceKeys.currentCountryCode, code);
  }
}
