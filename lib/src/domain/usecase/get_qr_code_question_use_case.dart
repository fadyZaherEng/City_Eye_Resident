import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/qr/qr_response.dart';
import 'package:city_eye/src/domain/repositories/qr_repository.dart';

class GetQrCodeQuestionUseCase {
  final QrRepository _qrRepository;

  GetQrCodeQuestionUseCase(this._qrRepository);

  Future<DataState<QrResponse>> call() async {
    return await _qrRepository.getQrCodeQuestions();
  }
}
