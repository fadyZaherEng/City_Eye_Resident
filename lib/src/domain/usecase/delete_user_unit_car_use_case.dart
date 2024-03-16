import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/delete_request.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';

final class DeleteUserUnitCarUseCase {
  final ProfileRepository _profileRepository;

  DeleteUserUnitCarUseCase(this._profileRepository);

  Future<DataState> call(DeleteRequest deleteUserUnitCarRequest) async =>
      await _profileRepository.deleteUserUnitCar(deleteUserUnitCarRequest);
}
