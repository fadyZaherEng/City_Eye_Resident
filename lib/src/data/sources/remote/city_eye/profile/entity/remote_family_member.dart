import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_type.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_family_member.g.dart';

@JsonSerializable()
class RemoteFamilyMember  {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'mobileNumber')
  final String? mobileNumber;
  @JsonKey(name: 'relationShipType')
  final RemoteType? relationShipType;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'attachment')
  final String? attachment;
  @JsonKey(name: 'countryCode')
  final String? countryCode;


  const RemoteFamilyMember({
    this.id = 0,
    this.name = "" ,
    this.mobileNumber = "",
    this.relationShipType = const RemoteType(),
    this.email = "",
    this.attachment = "",
    this.countryCode = "",
  });

  factory RemoteFamilyMember.fromJson(Map<String, dynamic> json) =>
      _$RemoteFamilyMemberFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteFamilyMemberToJson(this);
}

//write extension to map RemoteFamilyMember to domain FamilyMember
extension RemoteFamilyMemberExtension on RemoteFamilyMember {
  FamilyMember mapToDomain() {
    return FamilyMember(
      id: id ?? 0,
      name: name ?? "",
      mobileNumber: mobileNumber ?? "",
      familyMemberType: (relationShipType ?? RemoteType()).mapToDomain(),
      email: email ?? "",
      attachment: attachment ?? "",
      countryCode: countryCode ?? "EG",
    );
  }
}

//write extension to map List<RemoteFamilyMember> to domain List<FamilyMember>
extension RemoteFamilyMemberListExtension on List<RemoteFamilyMember>? {
  List<FamilyMember> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
