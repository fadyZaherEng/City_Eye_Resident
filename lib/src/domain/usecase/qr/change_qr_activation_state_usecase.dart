import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/deactivate_qr_request.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:city_eye/src/domain/repositories/qr_repository.dart';

final class ChangeQrActivationStatusUseCase {
  final QrRepository _qrRepository;

  const ChangeQrActivationStatusUseCase(this._qrRepository);

  Future<DataState<QrHistory>> call(
          DeactivateQrRequest deactivateQrRequest) async =>
      await _qrRepository.deactivateQrHistory(deactivateQrRequest);
}
