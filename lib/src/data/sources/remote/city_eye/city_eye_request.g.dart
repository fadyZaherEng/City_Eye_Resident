// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_eye_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityEyeRequest<T> _$CityEyeRequestFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CityEyeRequest<T>(
      userId: json['userID'] as int?,
      subscriberId: json['subscriberId'] as int?,
      userTypeId: json['userTypeId'] as int?,
      unitId: json['unitId'] as int?,
      compoundId: json['compoundId'] as int?,
      languageCode: json['languageCode'] as String?,
      deviceToken: json['deviceToken'] as String?,
      deviceSerial: json['deviceSerial'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$CityEyeRequestToJson<T>(
  CityEyeRequest<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'userID': instance.userId,
      'subscriberId': instance.subscriberId,
      'userTypeId': instance.userTypeId,
      'unitId': instance.unitId,
      'compoundId': instance.compoundId,
      'languageCode': instance.languageCode,
      'deviceToken': instance.deviceToken,
      'deviceSerial': instance.deviceSerial,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
