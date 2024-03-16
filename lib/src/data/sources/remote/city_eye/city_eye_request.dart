import 'package:city_eye/flavors.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/usecase/get_firebase_notification_token_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_eye_request.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CityEyeRequest<T> {
  @JsonKey(name: 'userID')
  int? userId;
  @JsonKey(name: 'subscriberId')
  int? subscriberId;
  @JsonKey(name: 'userTypeId')
  int? userTypeId;
  @JsonKey(name: 'unitId')
  int? unitId;
  @JsonKey(name: 'compoundId')
  int? compoundId;
  @JsonKey(name: 'languageCode')
  String? languageCode;
  @JsonKey(name: 'deviceToken')
  String? deviceToken;
  @JsonKey(name: 'deviceSerial')
  String? deviceSerial;
  @JsonKey(name: 'data')
  T? data;

  CityEyeRequest({
    this.userId,
    this.subscriberId,
    this.userTypeId,
    this.unitId,
    this.compoundId,
    this.languageCode,
    this.deviceToken,
    this.deviceSerial,
    this.data,
  });


  factory CityEyeRequest.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CityEyeRequestFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Function(dynamic value) value) =>
      _$CityEyeRequestToJson(this, (T) {
        return T;
      });


  CityEyeRequest<T> createRequest(T)  {
    return CityEyeRequest(
      userId:  GetUserInformationUseCase(injector())().userInformation.id  == -1 ? 0 : GetUserInformationUseCase(injector())().userInformation.id,
      compoundId:  GetUserUnitUseCase(injector())().compoundId,
      deviceSerial: "",
      deviceToken: GetFirebaseNotificationTokenUseCase(injector())(),
      languageCode:  GetLanguageUseCase(injector())(),
      subscriberId: F.subscriberId,
      unitId:  GetUserUnitUseCase(injector())().unitId,
      userTypeId:  GetUserUnitUseCase(injector())().userTypeId == 0 ? null :GetUserUnitUseCase(injector())().userTypeId ,
      data: T,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'subscriberId': subscriberId,
      'userTypeId': userTypeId,
      'unitId': unitId,
      'compoundId': compoundId,
      'languageCode': languageCode,
      'deviceToken': deviceToken,
      'deviceSerial': deviceSerial,
      'data': data != null ? data : null,
    };
  }

  factory CityEyeRequest.fromMap(Map<String, dynamic> map) {
    return CityEyeRequest(
      userId: map['userId'] as int,
      subscriberId: map['subscriberId'] as int,
      userTypeId: map['userTypeId'] as int,
      unitId: map['unitId'] as int,
      compoundId: map['compoundId'] as int,
      languageCode: map['languageCode'] as String,
      deviceToken: map['deviceToken'] as String,
      deviceSerial: map['deviceSerial'] as String,
      data: map['data'] as T,
    );
  }
}
