// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_unit_car_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUnitCarRequest _$UserUnitCarRequestFromJson(Map<String, dynamic> json) =>
    UserUnitCarRequest(
      id: json['id'] as int,
      plateNumber: json['plateNumber'] as String,
      carTypeId: json['carTypeId'] as int,
      modelId: json['modelId'] as int,
      colorId: json['colorId'] as int,
    );

Map<String, dynamic> _$UserUnitCarRequestToJson(UserUnitCarRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plateNumber': instance.plateNumber,
      'carTypeId': instance.carTypeId,
      'modelId': instance.modelId,
      'colorId': instance.colorId,
    };
