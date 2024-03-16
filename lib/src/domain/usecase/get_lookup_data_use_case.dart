import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/lookup_request.dart';
import 'package:city_eye/src/domain/entities/settings/lookup.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

class GetLookupDataUseCase {
  final SettingsRepository _settingsRepository;

  GetLookupDataUseCase(this._settingsRepository);

  Future<DataState<List<Lookup>>> call(List<LookupRequest> requests) async {
    return await _settingsRepository.getLookupData(requests);
  }
}