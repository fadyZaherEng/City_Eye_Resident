import 'package:json_annotation/json_annotation.dart';

part 'add_user_family_member_request.g.dart';

@JsonSerializable()
class AddUserFamilyMemberRequest {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'mobileNumber')
  final String? mobileNumber;
  @JsonKey(name: 'relationShipTypeId')
  final int? relationShipTypeId;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'attachment')
  final String? attachment;

  AddUserFamilyMemberRequest({
    required this.name,
    required this.mobileNumber,
    required this.relationShipTypeId,
    required this.countryCode,
    required this.email,
    required this.attachment
  });

  factory AddUserFamilyMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$AddUserFamilyMemberRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddUserFamilyMemberRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobileNumber': mobileNumber,
      'relationShipTypeId': relationShipTypeId,
      'countryCode': countryCode,
      'email': email,
      'attachment': attachment,
    };
  }

  factory AddUserFamilyMemberRequest.fromMap(Map<String, dynamic> map) {
    return AddUserFamilyMemberRequest(
      name: map['name'] ?? "",
      mobileNumber: map['mobileNumber'] ?? "",
      relationShipTypeId: map['relationShipTypeId'] ?? 0,
      countryCode: map['countryCode'] ?? "",
      email: map['email'] ?? "",
      attachment: map['attachment'] ?? "",
    );
  }
}
