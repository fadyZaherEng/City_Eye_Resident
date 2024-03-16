import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_car.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_family_member.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_info.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_profile_file.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_profile_unit.dart';
import 'package:city_eye/src/domain/entities/profile/car_configuration.dart';
import 'package:city_eye/src/domain/entities/profile/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_profile.g.dart';

@JsonSerializable()
class RemoteProfile {
  @JsonKey(name: 'profile')
  final RemoteInfo? info;
  @JsonKey(name: 'unit')
  final RemoteProfileUnit? profileUnit;
  @JsonKey(name: 'files')
  final List<RemoteProfileFile>? files;
  @JsonKey(name: 'familyMember')
  final List<RemoteFamilyMember>? familyMembers;
  @JsonKey(name: 'cars')
  final List<RemoteCar>? cars;

  const RemoteProfile({
    this.info = const RemoteInfo(),
    this.profileUnit = const RemoteProfileUnit(),
    this.files = const [],
    this.familyMembers = const [],
    this.cars = const [],
  });

  factory RemoteProfile.fromJson(Map<String, dynamic> json) =>
      _$RemoteProfileFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteProfileToJson(this);
}

extension RemoteProfileExtension on RemoteProfile {
  Profile mapToDomain() {
    return Profile(
      info: (info ?? RemoteInfo()).mapToDomain(),
      unit: (profileUnit ?? RemoteProfileUnit()).mapToDomain(),
      files: files?.map((e) => e.mapToDomain()).toList() ?? [],
      family: familyMembers?.map((e) => e.mapToDomain()).toList() ?? [],
      cars: cars?.map((e) => e.mapToDomain()).toList() ?? [],
      familyMemberTypes: [],
      carConfiguration: const CarConfiguration(),
    );
  }
}
