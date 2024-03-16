import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCurrentCountryCodeUseCase {
  final SharedPreferences sharedPreferences;

  GetCurrentCountryCodeUseCase(this.sharedPreferences);

  String call() {
    return sharedPreferences.getString(SharedPreferenceKeys.currentCountryCode) ?? "EG";
  }
}
