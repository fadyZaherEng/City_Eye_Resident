import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/request_support_multi_media.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/submit_support_request.dart';
import 'package:city_eye/src/domain/entities/support_details/submit_support.dart';
import 'package:city_eye/src/domain/repositories/support_repository.dart';

final class SubmitSupportUseCase {
  final SupportRepository _supportRepository;

  const SubmitSupportUseCase(this._supportRepository);

  Future<DataState<SubmitSupport>> call(
          SubmitSupportRequest submitSupportRequest ,SupportMultiMediaRequest supportMultiMediaRequest) async =>
      await _supportRepository.submitSupport(submitSupportRequest,supportMultiMediaRequest);
}
