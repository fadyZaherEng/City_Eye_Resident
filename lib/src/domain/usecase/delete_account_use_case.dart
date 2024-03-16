import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

class DeleteAccountUseCase {
  final SettingsRepository _settingsRepository;

  DeleteAccountUseCase(this._settingsRepository);

  Future<DataState<String>> call() async {
    return await _settingsRepository.deleteAccount();
  }
}
