import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_history_request.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:city_eye/src/domain/repositories/qr_repository.dart';

final class GetQrHistoryUseCase {
  final QrRepository _qrRepository;

  const GetQrHistoryUseCase(this._qrRepository);

  Future<DataState<List<QrHistory>>> call(
      QrHistoryRequest qrHistoryRequest) async {
    return await _qrRepository.getQrHistory(qrHistoryRequest);
  }
}
