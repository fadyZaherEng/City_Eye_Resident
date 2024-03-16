import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveFirebaseNotificationTokenUseCase {
  final SharedPreferences _sharedPreferences;

  SaveFirebaseNotificationTokenUseCase(this._sharedPreferences);

  Future<bool> call({required String firebaseNotificationToken}) async {
    return await _sharedPreferences.setString(
        SharedPreferenceKeys.notificationToken, firebaseNotificationToken);
  }
}
