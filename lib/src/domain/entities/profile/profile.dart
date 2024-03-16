import 'package:city_eye/src/domain/entities/profile/car.dart';
import 'package:city_eye/src/domain/entities/profile/car_configuration.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';
import 'package:city_eye/src/domain/entities/profile/info.dart';
import 'package:city_eye/src/domain/entities/profile/profile_file.dart';
import 'package:city_eye/src/domain/entities/profile/profile_unit.dart';
import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final Info info;
  final ProfileUnit unit;
  final List<ProfileFile> files;
  final List<FamilyMember> family;
  final List<Car> cars;
  final CarConfiguration carConfiguration;
  final List<FamilyMemberType> familyMemberTypes;

  const Profile({
    this.info = const Info(),
    this.unit = const ProfileUnit(),
    this.files = const [],
    this.family = const [],
    this.cars = const [],
    this.carConfiguration = const CarConfiguration(),
    this.familyMemberTypes = const [],
  });

  Profile copyWith({
    Info? info,
    ProfileUnit? unit,
    List<ProfileFile>? files,
    List<FamilyMember>? family,
    List<Car>? cars,
    CarConfiguration? carConfiguration,
    List<FamilyMemberType>? familyMemberTypes,
  }) {
    return Profile(
      info: info ?? this.info,
      unit: unit ?? this.unit,
      files: files ?? this.files,
      family: family ?? this.family,
      cars: cars ?? this.cars,
      carConfiguration: carConfiguration ?? this.carConfiguration,
      familyMemberTypes: familyMemberTypes ?? this.familyMemberTypes,
    );
  }

  @override
  List<Object?> get props => [
        info,
        unit,
        files,
        family,
        cars,
        carConfiguration,
        familyMemberTypes,
      ];
}
