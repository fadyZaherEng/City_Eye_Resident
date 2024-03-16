import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetSupportIndexUseCase {
  final SharedPreferences sharedPreferences;

  SetSupportIndexUseCase(this.sharedPreferences);

  Future<bool> call(List<String> index) async {
    return await sharedPreferences.setStringList(SharedPreferenceKeys.supportIndex, index);
  }
}