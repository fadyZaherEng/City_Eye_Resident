import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/landing/landing.dart';
import 'package:city_eye/src/domain/repositories/landing_repository.dart';

class GetLandingUseCase {
  final LandingRepository _landingRepository;

  GetLandingUseCase(this._landingRepository);

  Future<DataState<Landing>> call() async {
    return await _landingRepository.getLanding();
  }
}
