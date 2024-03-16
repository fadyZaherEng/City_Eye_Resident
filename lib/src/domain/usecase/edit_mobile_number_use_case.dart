import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/edit_mobile_number_request.dart';
import 'package:city_eye/src/domain/entities/register/edit_mobile_number.dart';
import 'package:city_eye/src/domain/repositories/register_repository.dart';

class EditMobileNumberUseCase {
  final RegisterRepository _registerRepository;

  EditMobileNumberUseCase(this._registerRepository);

  Future<DataState<EditMobileNumber>> call(EditMobileNumberRequest request) async {
    return await _registerRepository.editMobileNumber(request);
  }

}