import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/user_unit_car_request.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';

final class AddUserUnitCarUseCase {
  final ProfileRepository _profileRepository;

  AddUserUnitCarUseCase(this._profileRepository);

  Future<DataState> call(UserUnitCarRequest addUserUnitCarRequest) async =>
      await _profileRepository.addUserUnitCar(addUserUnitCarRequest);
}
