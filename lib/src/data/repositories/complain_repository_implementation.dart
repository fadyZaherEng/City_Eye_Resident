import 'dart:convert';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/complain/complain_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/complain/entity/remote_complain.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/complain/request/submit_complain_request.dart';
import 'package:city_eye/src/domain/entities/complain/complain.dart';
import 'package:city_eye/src/domain/repositories/complain_repository.dart';
import 'package:dio/dio.dart';

class ComplainRepositoryImplementation extends ComplainRepository {
  final ComplainAPIService _complainAPIService;

  ComplainRepositoryImplementation(this._complainAPIService);

  @override
  Future<DataState<Complain>> submitComplain(
      String audioPath,
      String videoPath,
      List<String> imagesPath,
      SubmitComplainRequest submitComplainRequest) async {
    try {
      CityEyeRequest<SubmitComplainRequest> request =
          CityEyeRequest<SubmitComplainRequest>()
              .createRequest(submitComplainRequest);

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

      for (int i = 0; i < imagesPath.length; i++) {
        MultipartFile imageFile = imagesPath.isEmpty
            ? MultipartFile.fromBytes(<int>[])
            : await MultipartFile.fromFile(imagesPath[i], filename: "image.jpg");
        files.add(imageFile);
      }

      final httpResponse = await _complainAPIService.submitComplain(
        files,
        jsonEncode(request.toMap()),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemoteComplain())
                .mapToDomain(),
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
