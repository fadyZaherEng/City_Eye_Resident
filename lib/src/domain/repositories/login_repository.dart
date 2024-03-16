import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/change_password_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/forgot_password_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/login_request.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';

abstract class LoginRepository {
  Future<DataState<User>> login(LoginRequest loginRequest);

  Future<DataState<String>> forgotPassword(ForgotPasswordRequest forgotPasswordRequest);

  Future<DataState<String>> changePassword(ChangePasswordRequest changePasswordRequest);
}
