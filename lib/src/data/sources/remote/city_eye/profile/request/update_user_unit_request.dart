import 'package:json_annotation/json_annotation.dart';

part 'update_user_unit_request.g.dart';

@JsonSerializable()
class UpdateUserUnitRequest {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'gasNo')
  String gazNo;
  @JsonKey(name: 'telephone')
  String telephone;

  UpdateUserUnitRequest({
    required this.id,
    required this.gazNo,
    required this.telephone,
  });

  factory UpdateUserUnitRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserUnitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserUnitRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gasNo': gazNo,
      'telephone': telephone,
    };
  }

  factory UpdateUserUnitRequest.fromMap(Map<String, dynamic> map) {
    return UpdateUserUnitRequest(
      id: map['id'] ?? 0,
      gazNo: map['gasNo'] ?? "",
      telephone: map['telephone'] ?? "",
    );
  }

  @override
  String toString() {
    return 'UpdateUserUnitRequest(id: $id, gazNo: $gazNo, telephone: $telephone)';
  }
}
