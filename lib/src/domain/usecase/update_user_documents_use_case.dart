import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/profile_document_request.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';

class UpdateUserDocumentsUseCase {
  final ProfileRepository _profileRepository;

  UpdateUserDocumentsUseCase(this._profileRepository);

  Future<DataState> call(List<ProfileDocumentRequest> request) async {
    return await _profileRepository.updateUserDocuments(request);
  }
}