import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/validate_mobile_number_request.dart';
import 'package:city_eye/src/domain/repositories/register_repository.dart';

class RegisterValidateMobileUseCase {
  final RegisterRepository _registerRepository;

  RegisterValidateMobileUseCase(this._registerRepository);

  Future<DataState> call(ValidateMobileNumberRequest validateMobileNumberRequest) async {
    return await _registerRepository.validateMobileNumber(validateMobileNumberRequest);
  }
}