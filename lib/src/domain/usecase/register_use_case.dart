import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/register_request.dart';
import 'package:city_eye/src/domain/entities/register/otp.dart';
import 'package:city_eye/src/domain/repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository _registerRepository;

  RegisterUseCase(this._registerRepository);

  Future<DataState<OTP>> call(RegisterRequest request,int userId) async {
    return await _registerRepository.register(request,userId);
  }
}