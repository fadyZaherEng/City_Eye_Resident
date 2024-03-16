import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetWallItemIdUseCase {
  final SharedPreferences sharedPreferences;

  SetWallItemIdUseCase(this.sharedPreferences);

  Future<bool> call(int id) async {
    return await sharedPreferences.setInt(SharedPreferenceKeys.wallItemId, id);
  }
}