import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/qr/qr_configuration.dart';
import 'package:city_eye/src/domain/repositories/qr_repository.dart';

class GetQrConfigurationUseCase {
  final QrRepository _qrRepository;

  GetQrConfigurationUseCase(this._qrRepository);

  Future<DataState<QrConfiguration>> call() async {
    return await _qrRepository.getQrConfiguration();
  }
}