import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/landing/landing.dart';

abstract class LandingRepository {
  Future<DataState<Landing>> getLanding();
}
