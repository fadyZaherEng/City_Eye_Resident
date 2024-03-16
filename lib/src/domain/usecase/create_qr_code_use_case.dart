import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/create_qr_request.dart';
import 'package:city_eye/src/domain/entities/qr/create_qr_response.dart';
import 'package:city_eye/src/domain/repositories/qr_repository.dart';

class CreateQrCodeUseCase {
  final QrRepository _qrRepository;

  CreateQrCodeUseCase(this._qrRepository);

  Future<DataState<CreateQrResponse>> call(
      CreateQrRequest createQrRequest) async {
    return await _qrRepository.createQrCode(createQrRequest);
  }
}
