import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetWallItemIdUseCase {
  final SharedPreferences sharedPreferences;

  GetWallItemIdUseCase(this.sharedPreferences);

  int call() {
    return sharedPreferences.getInt(SharedPreferenceKeys.wallItemId) ?? 0;
  }
}
