import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/change_password_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/login_request.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/repositories/login_repository.dart';

class ChangePasswordUseCase {
  final LoginRepository _loginRepository;

  const ChangePasswordUseCase(this._loginRepository);

  Future<DataState> call(ChangePasswordRequest request) async {
    return await _loginRepository.changePassword(request);
  }
}
