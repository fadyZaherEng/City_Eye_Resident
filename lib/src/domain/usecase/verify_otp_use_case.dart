import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/verify_otp_request.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/repositories/register_repository.dart';

class VerifyOTPUseCase {
  final RegisterRepository _registerRepository;

  VerifyOTPUseCase(this._registerRepository);

  Future<DataState<User>> call(VerifyOTPRequest verifyOTPRequest,int userId) async {
    return await _registerRepository.verifyOTP(verifyOTPRequest,userId);
  }
}