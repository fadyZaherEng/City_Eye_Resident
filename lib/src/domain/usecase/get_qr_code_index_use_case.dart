import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetQrCodeIndexUseCase {
  final SharedPreferences sharedPreferences;

  GetQrCodeIndexUseCase(this.sharedPreferences);

  List<String> call() {
    return sharedPreferences.getStringList(SharedPreferenceKeys.qrCodeIndex) ?? ["0","0","0"];
  }
}
