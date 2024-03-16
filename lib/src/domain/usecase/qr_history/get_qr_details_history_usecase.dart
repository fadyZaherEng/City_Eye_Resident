import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_details_request.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_details.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history_with_questions_answer.dart';
import 'package:city_eye/src/domain/repositories/qr_repository.dart';

final class GetQrDetailsHistoryUseCase {
  final QrRepository _qrRepository;

  GetQrDetailsHistoryUseCase(this._qrRepository);

  Future<DataState<QrDetails>> call(QrDetailsRequest qrDetailsRequest) async =>
      await _qrRepository.getQrHistoryDetailsById(qrDetailsRequest);
}
