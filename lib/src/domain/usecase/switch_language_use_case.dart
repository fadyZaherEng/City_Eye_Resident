import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

class SwitchLanguageUseCase {
  final SettingsRepository _settingsRepository;

  SwitchLanguageUseCase(this._settingsRepository);

  Future<DataState<UserUnit>> call() async =>
      await _settingsRepository.switchLanguage();
}