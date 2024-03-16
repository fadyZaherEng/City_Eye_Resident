import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/login_request.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository _loginRepository;

  const LoginUseCase(this._loginRepository);

  Future<DataState<User>> call(LoginRequest request) async {
    return await _loginRepository.login(request);
  }
}
