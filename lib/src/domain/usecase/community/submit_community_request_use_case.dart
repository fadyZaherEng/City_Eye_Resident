import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/community_request/request/submit_community_request.dart';
import 'package:city_eye/src/domain/entities/community_request/submit_community.dart';
import 'package:city_eye/src/domain/repositories/community_request_repository.dart';

class SubmitCommunityRequestUseCase {
  final CommunityRequestRepository _communityRequestRepository;

  SubmitCommunityRequestUseCase(this._communityRequestRepository);

  Future<DataState<SubmitCommunity>> call(String audioPath,
      List<String> imagePath,
      String videoPath,
      SubmitCommunityRequest submitCommunityRequest,) async {
    return await _communityRequestRepository.submitCommunityRequest(
      audioPath, imagePath, videoPath, submitCommunityRequest,
    );
  }
}