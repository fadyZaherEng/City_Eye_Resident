import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetNoInternetUseCase {
  final SharedPreferences sharedPreferences;

  SetNoInternetUseCase(this.sharedPreferences);

  Future<bool> call(bool status) async {
    return await sharedPreferences.setBool(SharedPreferenceKeys.noInternet, status);
  }
}