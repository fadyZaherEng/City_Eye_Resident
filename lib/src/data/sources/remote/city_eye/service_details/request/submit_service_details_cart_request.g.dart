// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_service_details_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitServiceDetailsCartRequest _$SubmitServiceDetailsCartRequestFromJson(
        Map<String, dynamic> json) =>
    SubmitServiceDetailsCartRequest(
      packageId: json['packageId'] as int,
      serviceCount: json['serviceCount'] as int,
      remoteServicePackagesQuestion: (json['servicePackageQuestions']
              as List<dynamic>)
          .map((e) =>
              ServicePackageQuestionRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubmitServiceDetailsCartRequestToJson(
        SubmitServiceDetailsCartRequest instance) =>
    <String, dynamic>{
      'packageId': instance.packageId,
      'serviceCount': instance.serviceCount,
      'servicePackageQuestions': instance.remoteServicePackagesQuestion
          .map((e) => e.toJson())
          .toList(),
    };
