import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/community_request/request/submit_community_request.dart';
import 'package:city_eye/src/domain/entities/community_request/submit_community.dart';

abstract class CommunityRequestRepository {
  Future<DataState<SubmitCommunity>> submitCommunityRequest(
    String audioPath,
    List<String> imagePath,
    String videoPath,
    SubmitCommunityRequest submitCommunityRequest,
  );
}
