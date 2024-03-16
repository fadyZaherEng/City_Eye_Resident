import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetServicesIndexUseCase {
  final SharedPreferences sharedPreferences;

  SetServicesIndexUseCase(this.sharedPreferences);

  Future<bool> call(int index) async {
    return await sharedPreferences.setInt(SharedPreferenceKeys.servicesIndex, index);
  }
}