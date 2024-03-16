import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetCountryUseCase {
  final SharedPreferences sharedPreferences;

  SetCountryUseCase(this.sharedPreferences);

  Future<bool> call(String country) async {
    return await sharedPreferences.setString(SharedPreferenceKeys.country, country);
  }
}