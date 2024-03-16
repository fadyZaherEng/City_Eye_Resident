import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/settings/language.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

class GetLanguagesUseCase {
  final SettingsRepository _helperRepository;

  GetLanguagesUseCase(this._helperRepository);

  Future<DataState<List<Language>>> call() async{
    return await _helperRepository.getLanguage();
  }
}