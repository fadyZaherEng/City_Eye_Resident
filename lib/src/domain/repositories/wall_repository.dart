import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/wall/request/wall_details_request.dart';
import 'package:city_eye/src/domain/entities/wall/wall.dart';

abstract class WallRepository {
  Future<DataState<List<Wall>>> getWallList();

  Future<DataState<Wall>> getWallDetails(WallDetailsRequest wallDetailsRequest);
}
