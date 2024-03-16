import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/request_otp_request.dart';
import 'package:city_eye/src/domain/entities/register/otp.dart';
import 'package:city_eye/src/domain/repositories/register_repository.dart';

class RequestOTPUseCase {
  final RegisterRepository _registerRepository;

  RequestOTPUseCase(this._registerRepository);

  Future<DataState<OTP>> call(RequestOTPRequest requestOTPRequest,int compoundId) async {
    return await _registerRepository.requestOTP(requestOTPRequest,compoundId);
  }
}