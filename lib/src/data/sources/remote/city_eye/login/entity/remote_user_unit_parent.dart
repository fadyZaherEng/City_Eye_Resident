import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit_parent.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_user_unit_parent.g.dart';

@JsonSerializable()
class RemoteUserUnitParent {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'sortNo')
  final int? sortNo;

  const RemoteUserUnitParent({
    this.id = 0,
    this.name = "",
    this.sortNo = 0,
  });

  factory RemoteUserUnitParent.fromJson(Map<String, dynamic> json) =>
      _$RemoteUserUnitParentFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteUserUnitParentToJson(this);
}

extension RemoteUserUnitParentExtension on RemoteUserUnitParent {
  UserUnitParent mapToDomain() {
    return UserUnitParent(
      id: id ?? 0,
      name: name ?? "",
      sortNumber: sortNo ?? 0,
    );
  }
}

extension RemoteUserUnitParentsExtension on List<RemoteUserUnitParent>? {
  List<UserUnitParent> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
