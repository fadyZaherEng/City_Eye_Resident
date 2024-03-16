import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetIsAppLanguageChangedUseCase {
  final SharedPreferences sharedPreferences;

  GetIsAppLanguageChangedUseCase(this.sharedPreferences);

  bool call() {
    return sharedPreferences.getBool(SharedPreferenceKeys.appLanguageChanged) ??
        false;
  }
}
