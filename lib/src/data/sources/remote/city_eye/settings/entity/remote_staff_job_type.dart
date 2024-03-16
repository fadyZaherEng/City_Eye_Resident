import 'package:city_eye/src/domain/entities/staff/staff_job_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_staff_job_type.g.dart';

@JsonSerializable()
class RemoteStaffJobType {
  final int? id;
  final String? name;
  final String? code;

  const RemoteStaffJobType({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteStaffJobType.fromJson(Map<String, dynamic> json) =>
      _$RemoteStaffJobTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteStaffJobTypeToJson(this);
}

extension RemoteStaffJobTypeExtension on RemoteStaffJobType {
  StaffJobType get mapToDomain => StaffJobType(
        id: id ?? 0,
        name: name ?? "",
        code: code ?? "",
      );
}
