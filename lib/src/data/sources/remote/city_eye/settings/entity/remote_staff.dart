import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_staff_job_type.dart';
import 'package:city_eye/src/domain/entities/staff/staff.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_staff.g.dart';

@JsonSerializable()
final class RemoteStaff {
  final int? id;
  final String? name;
  final String? mobile;
  final String? workingHours;
  final RemoteStaffJobType stuffJobType;
  final String? image;

  RemoteStaff({
    this.id = 0,
    this.name = "",
    this.workingHours = "",
    this.mobile = "",
    this.stuffJobType = const RemoteStaffJobType(),
    this.image = "",
  });

  factory RemoteStaff.fromJson(JsonType json) => _$RemoteStaffFromJson(json);

  JsonType get toJson => _$RemoteStaffToJson(this);
}

typedef JsonType = Map<String, dynamic>;

extension RemoteStaffExtension on RemoteStaff {
  Staff get mapToDomain => Staff(
        id: id ?? 0,
        name: name ?? "",
        mobile: mobile ?? "",
        workingHours: workingHours ?? "",
        staffJobType: stuffJobType.mapToDomain,
        image: image ?? "",
      );
}

extension RemoteStaffListExtension on List<RemoteStaff>? {
  List<Staff> mapToDomain() {
    return this?.map((e) => e.mapToDomain).toList() ?? [];
  }
}