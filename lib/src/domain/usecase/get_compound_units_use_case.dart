import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/compound_units_request.dart';
import 'package:city_eye/src/domain/entities/register/city_compound.dart';
import 'package:city_eye/src/domain/entities/register/compound_unit.dart';
import 'package:city_eye/src/domain/repositories/register_repository.dart';

class GetCompoundUnitsUseCase {
  final RegisterRepository _registerRepository;

  GetCompoundUnitsUseCase(this._registerRepository);

  Future<DataState<List<CompoundUnit>>> call(CompoundUnitsRequest request,int userId) async {
    return await _registerRepository.getCompoundUnits(request,userId);
  }
}
