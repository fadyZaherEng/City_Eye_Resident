// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_service_details_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteServiceDetailsCart _$RemoteServiceDetailsCartFromJson(
        Map<String, dynamic> json) =>
    RemoteServiceDetailsCart(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      price: json['price'] as int? ?? 0,
      maxCount: json['maxCount'] as int? ?? 0,
      minCount: json['minCount'] as int? ?? 0,
      startDate: json['startDate'] as String? ?? "",
      endDate: json['endDate'] as String? ?? "",
      serviceRate: (json['serviceRate'] as num?)?.toDouble() ?? 0.0,
      serviceDaysLimit: json['serviceDaysLimit'] as int? ?? 0,
      isCountType: json['isCountType'] as bool? ?? false,
      servicePackageQuestions:
          (json['servicePackageQuestions'] as List<dynamic>?)
                  ?.map((e) => RemoteServicePackagesQuestion.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const [],
    );

Map<String, dynamic> _$RemoteServiceDetailsCartToJson(
        RemoteServiceDetailsCart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'maxCount': instance.maxCount,
      'minCount': instance.minCount,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'serviceRate': instance.serviceRate,
      'serviceDaysLimit': instance.serviceDaysLimit,
      'isCountType': instance.isCountType,
      'servicePackageQuestions':
          instance.servicePackageQuestions?.map((e) => e.toJson()).toList(),
    };
