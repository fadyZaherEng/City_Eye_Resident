import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetServicesIndexUseCase {
  final SharedPreferences sharedPreferences;

  GetServicesIndexUseCase(this.sharedPreferences);

  int call() {
    return sharedPreferences.getInt(SharedPreferenceKeys.servicesIndex) ?? 0;
  }
}
