import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/delegated_extra_field_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_delegated_request.g.dart';

@JsonSerializable()
class SubmitDelegatedRequest {
  final int id;
  final String notes;
  final String name;
  final String personalID;
  final String fromDate;
  final String toDate;
  final String authName;
  final String authPersonalID;
  final String authMobile;
  final int statusId;
  final String authCountryCode;
  final List<DelegatedExtraFieldRequest> ownerExtraField;
  final List<DelegatedExtraFieldRequest> authExtraField;

  SubmitDelegatedRequest({
    required this.id,
    required this.notes,
    required this.name,
    required this.personalID,
    required this.fromDate,
    required this.toDate,
    required this.authName,
    required this.authPersonalID,
    required this.authMobile,
    required this.statusId,
    required this.authCountryCode,
    required this.ownerExtraField,
    required this.authExtraField,
  });

  factory SubmitDelegatedRequest.fromJson(Map<String, dynamic> json) => _$SubmitDelegatedRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitDelegatedRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'notes': notes,
      'name': name,
      'personalID': personalID,
      'fromDate': fromDate,
      'toDate': toDate,
      'authName': authName,
      'authPersonalID': authPersonalID,
      'authMobile': authMobile,
      'statusId': statusId,
      'authCountryCode': authCountryCode,
      'ownerExtraField': ownerExtraField,
      'authExtraField': authExtraField,
    };
  }

  factory SubmitDelegatedRequest.fromMap(Map<String, dynamic> map) {
    return SubmitDelegatedRequest(
      id: map['id'] as int,
      notes: map['notes'] as String,
      name: map['name'] as String,
      personalID: map['personalID'] as String,
      fromDate: map['fromDate'] as String,
      toDate: map['toDate'] as String,
      authName: map['authName'] as String,
      authPersonalID: map['authPersonalID'] as String,
      authMobile: map['authMobile'] as String,
      statusId: map['statusId'] as int,
      authCountryCode: map['authCountryCode'] as String,
      ownerExtraField: map['ownerExtraField'] as List<DelegatedExtraFieldRequest>,
      authExtraField: map['authExtraField'] as List<DelegatedExtraFieldRequest>,
    );
  }
}