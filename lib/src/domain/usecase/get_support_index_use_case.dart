import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSupportIndexUseCase {
  final SharedPreferences sharedPreferences;

  GetSupportIndexUseCase(this.sharedPreferences);

  List<String> call() {
    return sharedPreferences.getStringList(SharedPreferenceKeys.supportIndex) ?? ["0","0","0"];
  }
}
