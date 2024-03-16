import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetIsAppLanguageChangedUseCase {
  final SharedPreferences sharedPreferences;

  SetIsAppLanguageChangedUseCase(this.sharedPreferences);

  Future<bool> call(bool status) async {
    return await sharedPreferences.setBool(SharedPreferenceKeys.appLanguageChanged, status);
  }
}