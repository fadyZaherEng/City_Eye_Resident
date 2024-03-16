import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoveUserUnitsUseCase {
  final SharedPreferences sharedPreferences;

  RemoveUserUnitsUseCase(this.sharedPreferences);

  Future<bool> call() async {
    return await sharedPreferences.remove(SharedPreferenceKeys.userUnit);
  }
}
