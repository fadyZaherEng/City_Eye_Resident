import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

final class GetCompoundConfigurationUseCase {
  final SettingsRepository _settingsRepository;

  GetCompoundConfigurationUseCase(this._settingsRepository);

  Future<DataState<CompoundConfiguration>> call() async =>
      await _settingsRepository.getCompoundConfigration();
}
