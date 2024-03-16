import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/register/city_compound.dart';
import 'package:city_eye/src/domain/repositories/register_repository.dart';

class GetCityCompoundsUseCase {
  final RegisterRepository _registerRepository;

  GetCityCompoundsUseCase(this._registerRepository);

  Future<DataState<List<CityCompound>>> call() async {
    return await _registerRepository.getCityCompounds();
  }
}
