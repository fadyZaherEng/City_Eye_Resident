import 'dart:convert';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/is_url.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_family_member.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_car.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_family_member_invitation.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_profile_image.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/profile_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/add_user_family_member_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/delete_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/profile_document_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_info_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_family_member_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_unit_request.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/car.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_invitation.dart';
import 'package:city_eye/src/domain/entities/profile/profile_image.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_profile.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/user_unit_car_request.dart';
import 'package:city_eye/src/domain/entities/profile/profile.dart';

class ProfileRepositoryImplementation extends ProfileRepository {
  final ProfileAPIService _profileAPIService;

  ProfileRepositoryImplementation(this._profileAPIService);

  @override
  Future<DataState<Profile>> getProfile() async {
    try {
      CityEyeRequest request = await CityEyeRequest().createRequest(null);
      final httpResponse = await _profileAPIService.getProfile(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? RemoteProfile()).mapToDomain(),
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
  Future<DataState<List<Car>>> addUserUnitCar(
      UserUnitCarRequest addUserUnitCarRequest) async {
    try {
      CityEyeRequest<UserUnitCarRequest> request =
          CityEyeRequest<UserUnitCarRequest>()
              .createRequest(addUserUnitCarRequest);
      final httpResponse = await _profileAPIService.addUserUnitCar(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: httpResponse.data.result.mapToDomain(),
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
  Future<DataState<List<Car>>> updateUserUnitCar(
      UserUnitCarRequest updateUserUnitCarRequest) async {
    try {
      CityEyeRequest<UserUnitCarRequest> request =
          CityEyeRequest<UserUnitCarRequest>()
              .createRequest(updateUserUnitCarRequest);
      final httpResponse = await _profileAPIService.updateUserUnitCar(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: httpResponse.data.result.mapToDomain(),
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
  Future<DataState> deleteUserUnitCar(
      DeleteRequest deleteUserUnitCarRequest) async {
    try {
      CityEyeRequest<DeleteRequest> request = CityEyeRequest<DeleteRequest>()
          .createRequest(deleteUserUnitCarRequest);
      final httpResponse = await _profileAPIService.deleteUserUnitCar(request);
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
  Future<DataState<FamilyMemberInvitation>> addUserFamilyMember(
      AddUserFamilyMemberRequest addUserFamilyMemberRequest,
      String imagePath) async {
    try {
      CityEyeRequest<AddUserFamilyMemberRequest> request =
          CityEyeRequest<AddUserFamilyMemberRequest>()
              .createRequest(addUserFamilyMemberRequest);

      MultipartFile fileImage = imagePath.isEmpty
          ? MultipartFile.fromBytes(<int>[])
          : await MultipartFile.fromFile(imagePath);

      final httpResponse = await _profileAPIService.requestAddUserFamilyMember(
        jsonEncode(request.toMap()),
        [fileImage],
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ??
                    const RemoteFamilyMemberInvitation())
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
  Future<DataState<List<FamilyMember>>> updateUserFamilyMember(
      UpdateUserFamilyMemberRequest updateUserFamilyMemberRequest,
      String imagePath) async {
    try {
      CityEyeRequest<UpdateUserFamilyMemberRequest> request =
          CityEyeRequest<UpdateUserFamilyMemberRequest>()
              .createRequest(updateUserFamilyMemberRequest);

      MultipartFile fileImage = imagePath.isEmpty
          ? MultipartFile.fromBytes(<int>[])
          : await MultipartFile.fromFile(imagePath);

      final httpResponse =
          await _profileAPIService.requestUpdateUserFamilyMember(
        jsonEncode(request.toMap()),
        [fileImage],
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? []).mapToDomain(),
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
  Future<DataState> deleteUserFamilyMember(DeleteRequest deleteRequest) async {
    try {
      CityEyeRequest<DeleteRequest> request =
          CityEyeRequest<DeleteRequest>().createRequest(deleteRequest);
      final httpResponse =
          await _profileAPIService.deleteUserFamilyMember(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: httpResponse.data.responseMessage ?? "",
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
  Future<DataState> updateUserUnit(
      UpdateUserUnitRequest updateUserUnitRequest) async {
    try {
      CityEyeRequest<UpdateUserUnitRequest> request =
          CityEyeRequest<UpdateUserUnitRequest>()
              .createRequest(updateUserUnitRequest);
      final httpResponse = await _profileAPIService.updateUserUnit(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: httpResponse.data.responseMessage ?? "",
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
  Future<DataState> updateUserDocuments(
      List<ProfileDocumentRequest> profileDocumentRequest) async {
    try {
      List<ProfileDocumentRequest> tempProfileDocumentRequest =
          profileDocumentRequest.map((element) => element.deepClone()).toList();

      List<MultipartFile> files = [];
      for (int i = 0; i < profileDocumentRequest.length; i++) {
        if (profileDocumentRequest[i].controlTypeCode ==
                QuestionsCode.multiImage &&
            profileDocumentRequest[i].value.isNotEmpty &&
            profileDocumentRequest[i].isChanged) {
          List<String> paths = profileDocumentRequest[i].value.split(',');
          for (int j = 0; j < paths.length; j++) {
            if (!isUrl(paths[j])) {
              print("object $j");
              files.add(await MultipartFile.fromFile(paths[j],
                  filename: "${profileDocumentRequest[i].id.toString()}.jpg"));
            }
          }
        } else if (profileDocumentRequest[i].controlTypeCode ==
            QuestionsCode.image) {
          if (profileDocumentRequest[i].value.isNotEmpty &&
              profileDocumentRequest[i].isChanged) {
            files.add(await MultipartFile.fromFile(
                profileDocumentRequest[i].value,
                filename: "${profileDocumentRequest[i].id.toString()}.jpg"));
          }
        } else {
          if (profileDocumentRequest[i].value.isNotEmpty &&
              profileDocumentRequest[i].isChanged) {
            files.add(await MultipartFile.fromFile(
                profileDocumentRequest[i].value,
                filename:
                    "${profileDocumentRequest[i].id.toString()}.${profileDocumentRequest[i].value.split('.').last}"));
          }
        }
        for (int i = 0; i < tempProfileDocumentRequest.length; i++) {
          if (tempProfileDocumentRequest[i].controlTypeCode ==
              QuestionsCode.multiImage) {
            tempProfileDocumentRequest[i] = tempProfileDocumentRequest[i]
                .copyWith(
                    value: tempProfileDocumentRequest[i]
                        .value
                        .split(",")
                        .toList()
                        .where((element) => isUrl(element))
                        .toList()
                        .join(","));
          } else if (tempProfileDocumentRequest[i].controlTypeCode ==
              QuestionsCode.image) {
            tempProfileDocumentRequest[i] = tempProfileDocumentRequest[i]
                .copyWith(
                    value: isUrl(tempProfileDocumentRequest[i].value)
                        ? tempProfileDocumentRequest[i].value
                        : "");
          }
        }
      }

      CityEyeRequest<List<ProfileDocumentRequest>> request =
          CityEyeRequest<List<ProfileDocumentRequest>>()
              .createRequest(tempProfileDocumentRequest);
      print(jsonEncode(request.toMap()));
      final httpResponse = await _profileAPIService.updateUserDocuments(
        jsonEncode(request.toMap()),
        files,
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

  @override
  Future<DataState<Profile>> updateUserInfo(
      UpdateInfoRequest updateInfoRequest) async {
    try {
      CityEyeRequest<UpdateInfoRequest> request =
          CityEyeRequest<UpdateInfoRequest>().createRequest(updateInfoRequest);
      List<MultipartFile> files = [];
      for (int i = 0; i < updateInfoRequest.extraFields.length; i++) {
        if (updateInfoRequest.extraFields[i].controlTypeCode ==
                QuestionsCode.image &&
            updateInfoRequest.extraFields[i].value.isNotEmpty &&
            !isUrl(updateInfoRequest.extraFields[i].value)) {
          files.add(await MultipartFile.fromFile(
              updateInfoRequest.extraFields[i].value,
              filename:
                  "${updateInfoRequest.extraFields[i].id.toString()}.jpg"));
        }
      }

      final httpResponse = await _profileAPIService.updateUserInfo(
          jsonEncode(request.toMap()), files);
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

  @override
  Future<DataState<ProfileImage>> updateUserImage(String imagePath) async {
    try {
      CityEyeRequest request =
          CityEyeRequest().createRequest({"image": "profile.jpg"});
      MultipartFile profileImage = imagePath.isEmpty
          ? MultipartFile.fromBytes(<int>[])
          : await MultipartFile.fromFile(imagePath, filename: "profile.jpg");

      final httpResponse = await _profileAPIService.updateUserImage(
        jsonEncode(request.toMap()),
        [profileImage],
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemoteProfileImage())
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
