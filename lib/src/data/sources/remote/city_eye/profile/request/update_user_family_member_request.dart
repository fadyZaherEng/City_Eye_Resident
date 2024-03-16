import 'package:json_annotation/json_annotation.dart';

part 'update_user_family_member_request.g.dart';

@JsonSerializable()
class UpdateUserFamilyMemberRequest {
  @JsonKey(name: 'id')
  final int? id;
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

  UpdateUserFamilyMemberRequest(
      {required this.id,
      required this.name,
      required this.mobileNumber,
      required this.relationShipTypeId,
      required this.countryCode,
      required this.email,
      required this.attachment
      });

  factory UpdateUserFamilyMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserFamilyMemberRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserFamilyMemberRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobileNumber': mobileNumber,
      'relationShipTypeId': relationShipTypeId,
      'countryCode': countryCode,
      'email': email,
      'attachment': attachment,
    };
  }

  factory UpdateUserFamilyMemberRequest.fromMap(Map<String, dynamic> map) {
    return UpdateUserFamilyMemberRequest(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      mobileNumber: map['mobileNumber'] ?? "",
      relationShipTypeId: map['relationShipTypeId'] ?? 0,
      countryCode: map['countryCode'] ?? "",
      email: map['email'] ?? "",
      attachment: map['attachment'] ?? "",
    );
  }
}
