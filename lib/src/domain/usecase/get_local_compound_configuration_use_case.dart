import 'dart:convert';

import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class GetLocalCompoundConfigurationUseCase {
  final SharedPreferences _sharedPreferences;

  GetLocalCompoundConfigurationUseCase(this._sharedPreferences);

  CompoundConfiguration call() {
    return _sharedPreferences
                .getString(SharedPreferenceKeys.compoundConfiguration) ==
            null
        ? const CompoundConfiguration()
        : CompoundConfiguration.fromMap(
            jsonDecode(_sharedPreferences.getString(
                  SharedPreferenceKeys.compoundConfiguration,
                ) ??
                ""),
          );
  }
}
