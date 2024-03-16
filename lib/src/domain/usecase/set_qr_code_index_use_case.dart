import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetQrCodeIndexUseCase {
  final SharedPreferences sharedPreferences;

  SetQrCodeIndexUseCase(this.sharedPreferences);

  Future<bool> call(List<String> index) async {
    return await sharedPreferences.setStringList(SharedPreferenceKeys.qrCodeIndex, index);
  }
}