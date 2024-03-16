// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_support_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitSupportRequest _$SubmitSupportRequestFromJson(
        Map<String, dynamic> json) =>
    SubmitSupportRequest(
      description: json['description'] as String,
      categoryId: json['categoryId'] as int,
      timeId: json['timeId'] as int,
      date: json['date'] as String,
      isSupplier: json['isSupplier'] as bool,
      canRequestOnSameDay: json['canRequestOnSameDay'] as bool,
      bufferPerDay: json['bufferPerDay'] as int,
      bufferPerSlot: json['bufferPerSlot'] as int,
      supplierId: json['supplierId'] as int,
    );

Map<String, dynamic> _$SubmitSupportRequestToJson(
        SubmitSupportRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'categoryId': instance.categoryId,
      'timeId': instance.timeId,
      'date': instance.date,
      'isSupplier': instance.isSupplier,
      'canRequestOnSameDay': instance.canRequestOnSameDay,
      'bufferPerDay': instance.bufferPerDay,
      'bufferPerSlot': instance.bufferPerSlot,
      'supplierId': instance.supplierId,
    };
