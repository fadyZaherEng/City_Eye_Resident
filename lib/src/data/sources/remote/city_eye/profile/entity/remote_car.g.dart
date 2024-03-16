// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCar _$RemoteCarFromJson(Map<String, dynamic> json) => RemoteCar(
      id: json['id'] as int? ?? 0,
      plateNumber: json['plateNumber'] as String? ?? "",
      carType: json['carType'] == null
          ? const RemoteType()
          : RemoteType.fromJson(json['carType'] as Map<String, dynamic>),
      modelType: json['modelType'] == null
          ? const RemoteType()
          : RemoteType.fromJson(json['modelType'] as Map<String, dynamic>),
      colorType: json['colorType'] == null
          ? const RemoteType()
          : RemoteType.fromJson(json['colorType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteCarToJson(RemoteCar instance) => <String, dynamic>{
      'id': instance.id,
      'plateNumber': instance.plateNumber,
      'carType': instance.carType,
      'modelType': instance.modelType,
      'colorType': instance.colorType,
    };
