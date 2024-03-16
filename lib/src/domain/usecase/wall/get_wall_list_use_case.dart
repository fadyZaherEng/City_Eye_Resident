import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/wall/wall.dart';
import 'package:city_eye/src/domain/repositories/wall_repository.dart';

class GetWallListUseCase {
  final WallRepository _wallRepository;

  GetWallListUseCase(this._wallRepository);

  Future<DataState<List<Wall>>> call() async {
    return await _wallRepository.getWallList();
  }
}
