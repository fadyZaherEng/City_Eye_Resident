import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_submit_support.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_support_details_date.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/request_support_multi_media.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/submit_support_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/support_details_date_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/support_api_service.dart';
import 'package:city_eye/src/domain/entities/support_details/prepared_visit_time.dart';
import 'package:city_eye/src/domain/entities/support_details/submit_support.dart';
import 'package:city_eye/src/domain/entities/support_details/support_details_date.dart';
import 'package:city_eye/src/domain/repositories/support_repository.dart';
import 'package:dio/dio.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_comments.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_orders.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_payment_url.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/comments_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/my_orders_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/order_cancel_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/order_rating_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/payment_url_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/send_comment_request.dart';
import 'package:city_eye/src/domain/entities/support/comments.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/domain/entities/support/payment_url.dart';

abstract interface class SupportCheckingMultiMediaRequest {
  Future<List<MultipartFile>> _sendImageRequest({
    required SupportMultiMediaRequest supportMultiMediaRequest,
  });

  Future<List<MultipartFile>> _sendAudioRequest({
    required SupportMultiMediaRequest supportMultiMediaRequest,
  });

  Future<List<MultipartFile>> _sendVideoRequest({
    required SupportMultiMediaRequest supportMultiMediaRequest,
  });

  Future<List<MultipartFile>> _checkMultiMediaRequest({
    required SupportMultiMediaRequest supportMultiMediaRequest,
  });
}

final class SupportRepositoryImplementation
    implements SupportRepository, SupportCheckingMultiMediaRequest {
  final SupportAPIService _supportAPIService;

  SupportRepositoryImplementation(this._supportAPIService);

  @override
  Future<DataState<SupportDetailsDate>> getSupportDetailsDate(
      SupportDetailsDateRequest supportDetailsDateRequest) async {
    try {
      final request = CityEyeRequest<SupportDetailsDateRequest>()
          .createRequest(supportDetailsDateRequest);
      request.languageCode = "en";
      final httpResponse =
          await _supportAPIService.getSupportDetailsDate(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemoteSupportDetailsDate())
                .mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<SubmitSupport>> submitSupport(
      SubmitSupportRequest submitSupportRequest,
      SupportMultiMediaRequest supportMultiMediaRequest) async {
    List<MultipartFile> filesMultiMedia = [];
    try {
      final CityEyeRequest<SubmitSupportRequest> request =
          CityEyeRequest<SubmitSupportRequest>()
              .createRequest(submitSupportRequest);

      final getMultiMediaRequest = await _checkMultiMediaRequest(
        supportMultiMediaRequest: supportMultiMediaRequest,
      );
      filesMultiMedia = List<MultipartFile>.from(getMultiMediaRequest);

      final httpResponse = await _supportAPIService.submitSupport(
        jsonEncode(request.toMap()),
        filesMultiMedia,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemoteSubmitSupport())
                .mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    } catch (error) {
      log(error.toString());
      return DataFailed(
        message: error.toString(),
      );
    }
  }

  @override
  Future<List<MultipartFile>> _sendImageRequest({
    required SupportMultiMediaRequest supportMultiMediaRequest,
  }) async {
    final List<MultipartFile> multiPartFileForImage = [];
    for (int i = 0; i < supportMultiMediaRequest.images.length; i++) {
      final image = await MultipartFile.fromFile(
        supportMultiMediaRequest.images[i],
        filename:
            '${supportMultiMediaRequest.imageCode}.${supportMultiMediaRequest.images[i].split('.').last}',
      );
      multiPartFileForImage.add(image);
    }
    return multiPartFileForImage;
  }

  @override
  Future<List<MultipartFile>> _sendAudioRequest({
    required SupportMultiMediaRequest supportMultiMediaRequest,
  }) async {
    final List<MultipartFile> multiPartFileForAudio = [];
    for (int i = 0; i < supportMultiMediaRequest.audios.length; i++) {
      multiPartFileForAudio.add(
        await MultipartFile.fromFile(supportMultiMediaRequest.audios[i],
            filename: '${supportMultiMediaRequest.audioCode}.mp3'),
      );
    }
    return multiPartFileForAudio;
  }

  @override
  Future<List<MultipartFile>> _sendVideoRequest({
    required SupportMultiMediaRequest supportMultiMediaRequest,
  }) async {
    final List<MultipartFile> multiPartFileForVideo = [];
    for (int i = 0; i < supportMultiMediaRequest.videos.length; i++) {
      multiPartFileForVideo.add(
        await MultipartFile.fromFile(supportMultiMediaRequest.videos[i],
            filename:
                '${supportMultiMediaRequest.videoCode}.${supportMultiMediaRequest.videos[i].split('.').last}'),
      );
    }
    return multiPartFileForVideo;
  }

  @override
  Future<List<MultipartFile>> _checkMultiMediaRequest({
    required SupportMultiMediaRequest supportMultiMediaRequest,
  }) async {
    List<MultipartFile> filesForMultiMedia = [];
    final uploadingImages = supportMultiMediaRequest.images;
    final uploadingAudios = supportMultiMediaRequest.audios;
    final uploadingVideos = supportMultiMediaRequest.videos;

    if (uploadingImages.isNotEmpty) {
      final getFilesImage = await _sendImageRequest(
          supportMultiMediaRequest: supportMultiMediaRequest);
      filesForMultiMedia.addAll([...getFilesImage]);
    }
    if (uploadingAudios.isNotEmpty) {
      final getFilesAudio = await _sendAudioRequest(
          supportMultiMediaRequest: supportMultiMediaRequest);
      filesForMultiMedia.addAll([...getFilesAudio]);
    }
    if (uploadingVideos.isNotEmpty) {
      final getFilesVideo = await _sendVideoRequest(
          supportMultiMediaRequest: supportMultiMediaRequest);
      filesForMultiMedia.addAll([...getFilesVideo]);
    }
    return filesForMultiMedia;
  }

  @override
  Future<DataState<List<Orders>>> getMyOrders(
      MyOrdersRequest myOrdersRequest) async {
    try {
      CityEyeRequest<MyOrdersRequest> request =
          CityEyeRequest<MyOrdersRequest>().createRequest(myOrdersRequest);
      final httpResponse = await _supportAPIService.getMyOrders(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain(),
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

  @override
  Future<DataState> cancelOrder(OrderCancelRequest orderCancelRequest) async {
    try {
      CityEyeRequest<OrderCancelRequest> request =
          CityEyeRequest<OrderCancelRequest>()
              .createRequest(orderCancelRequest);

      final httpResponse = await _supportAPIService.cancelOrder(request);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
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

  @override
  Future<DataState<PaymentUrl>> getPaymentUrl(
      PaymentUrlRequest paymentUrlRequest) async {
    try {
      CityEyeRequest<PaymentUrlRequest> request =
          CityEyeRequest<PaymentUrlRequest>().createRequest(paymentUrlRequest);

      final httpResponse = await _supportAPIService.getPaymentUrl(request);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemotePaymentUrl())
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

  @override
  Future<DataState> sendOrderRating(
      OrderRatingRequest orderRatingRequest) async {
    try {
      CityEyeRequest<OrderRatingRequest> request =
          CityEyeRequest<OrderRatingRequest>()
              .createRequest(orderRatingRequest);

      final httpResponse = await _supportAPIService.sendOrderRating(request);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
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

  @override
  Future<DataState<List<Comments>>> getOrderComments(
      CommentsRequest commentsRequest) async {
    try {
      CityEyeRequest<CommentsRequest> request =
          CityEyeRequest<CommentsRequest>().createRequest(commentsRequest);

      final httpResponse = await _supportAPIService.getOrderComments(request);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain(),
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

  @override
  Future<DataState<List<Comments>>> sendSupportComment(
      String imagePath, SendCommentRequest sendCommentRequest) async {
    try {
      CityEyeRequest<SendCommentRequest> request =
          CityEyeRequest<SendCommentRequest>()
              .createRequest(sendCommentRequest);

      MultipartFile? image = imagePath.isEmpty
          ? MultipartFile.fromBytes(<int>[])
          : await MultipartFile.fromFile(imagePath, filename: "image.jpg");

      final httpResponse = await _supportAPIService.sendSupportComment(
        jsonEncode(request.toMap()),
        [image],
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain(),
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
