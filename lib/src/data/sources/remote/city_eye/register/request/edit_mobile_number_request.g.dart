// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_mobile_number_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditMobileNumberRequest _$EditMobileNumberRequestFromJson(
        Map<String, dynamic> json) =>
    EditMobileNumberRequest(
      userId: json['userId'] as int,
      compoundId: json['compoundId'] as int,
      mobileNumber: json['mobileNumber'] as String,
    );

Map<String, dynamic> _$EditMobileNumberRequestToJson(
        EditMobileNumberRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'compoundId': instance.compoundId,
      'mobileNumber': instance.mobileNumber,
    };
