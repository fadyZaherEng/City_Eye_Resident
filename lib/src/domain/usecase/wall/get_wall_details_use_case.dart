import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/wall/request/wall_details_request.dart';
import 'package:city_eye/src/domain/entities/wall/wall.dart';
import 'package:city_eye/src/domain/repositories/wall_repository.dart';

class GetWallDetailsUseCase {
  final WallRepository _wallRepository;

  GetWallDetailsUseCase(this._wallRepository);

  Future<DataState<Wall>> call(WallDetailsRequest wallDetailsRequest) async {
    return await _wallRepository.getWallDetails(wallDetailsRequest);
  }
}
