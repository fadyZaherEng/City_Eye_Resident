import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoveUserInformationUseCase {
  final SharedPreferences sharedPreferences;

  RemoveUserInformationUseCase(this.sharedPreferences);

  Future<bool> call() async {
    return await sharedPreferences.remove(SharedPreferenceKeys.user);
  }
}
