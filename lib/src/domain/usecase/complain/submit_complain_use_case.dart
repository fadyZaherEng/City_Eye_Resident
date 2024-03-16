import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/complain/request/submit_complain_request.dart';
import 'package:city_eye/src/domain/entities/complain/complain.dart';
import 'package:city_eye/src/domain/repositories/complain_repository.dart';

class SubmitComplainUseCase {
  final ComplainRepository _complainRepository;

  SubmitComplainUseCase(this._complainRepository);

  Future<DataState<Complain>> call(
      String audioPath,
      String videoPath,
      List<String> imagesPath,
      SubmitComplainRequest submitComplainRequest) async {
    return await _complainRepository.submitComplain(
        audioPath, videoPath, imagesPath, submitComplainRequest);
  }
}
