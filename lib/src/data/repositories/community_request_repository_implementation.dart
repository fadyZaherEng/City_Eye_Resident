import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/community_request/community_request_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/community_request/request/submit_community_request.dart';
import 'package:city_eye/src/domain/entities/community_request/submit_community.dart';
import 'package:city_eye/src/domain/repositories/community_request_repository.dart';
import 'package:dio/dio.dart';

class CommunityRequestRepositoryImplementation
    extends CommunityRequestRepository {
  final CommunityRequestAPIService _communityRequestAPIService;

  CommunityRequestRepositoryImplementation(this._communityRequestAPIService);

  @override
  Future<DataState<SubmitCommunity>> submitCommunityRequest(
    String audioPath,
    List<String> imagePath,
    String videoPath,
    SubmitCommunityRequest submitCommunityRequest,
  ) async {
    try {
      CityEyeRequest<SubmitCommunityRequest> request =
          CityEyeRequest<SubmitCommunityRequest>()
              .createRequest(submitCommunityRequest);

      List<MultipartFile> files = [];

      MultipartFile audioFile = audioPath.isEmpty
          ? MultipartFile.fromBytes(<int>[])
          : await MultipartFile.fromFile(audioPath, filename: "audio.mp3");

      MultipartFile videoFile = videoPath.isEmpty
          ? MultipartFile.fromBytes(<int>[])
          : await MultipartFile.fromFile(videoPath, filename: "video.mp4");

      if (audioPath.isNotEmpty) {
        files.add(audioFile);
      }
      if (videoPath.isNotEmpty) {
        files.add(videoFile);
      }

      for (int i = 0; i < imagePath.length; i++) {
        MultipartFile imageFile = imagePath.isEmpty
            ? MultipartFile.fromBytes(<int>[])
            : await MultipartFile.fromFile(imagePath[i], filename: "image.jpg");
        files.add(imageFile);
      }

      for (int i = 0;
          i < submitCommunityRequest.extraFieldAnswers.length;
          i++) {
        if (submitCommunityRequest.extraFieldAnswers[i].controlTypeCode ==
                QuestionsCode.image &&
            submitCommunityRequest.extraFieldAnswers[i].value.isNotEmpty) {
          files.add(await MultipartFile.fromFile(
              submitCommunityRequest.extraFieldAnswers[i].value,
              filename:
                  "${submitCommunityRequest.extraFieldAnswers[i].id.toString()}.jpg"));
        }
      }

      final httpResponse =
          await _communityRequestAPIService.submitCommunityRequest(
        files,
        jsonEncode(request.toMap()),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: null,
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }
}
