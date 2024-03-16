import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetCanNavigateToBadgeScreenUseCase {
  final SharedPreferences sharedPreferences;

  SetCanNavigateToBadgeScreenUseCase(this.sharedPreferences);

  Future<bool> call(bool value) {
    return sharedPreferences.setBool(SharedPreferenceKeys.isNavigationToBadge, value);
  }
}
