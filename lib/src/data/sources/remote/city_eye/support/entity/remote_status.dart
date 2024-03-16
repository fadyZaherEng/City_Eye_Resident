import 'package:city_eye/src/domain/entities/support/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_status.g.dart';

@JsonSerializable()
class RemoteStatus {
  final int? id;
  final String? name;
  final String? colorCode;
  final String? logo;
  final bool? isCompleted;
  final bool? isCurrent;
  final String? captionStatusCode;

  const RemoteStatus({
    this.id = 0,
    this.name = "",
    this.colorCode = "",
    this.logo = "",
    this.isCompleted = false,
    this.isCurrent = false,
    this.captionStatusCode = "",
  });

  factory RemoteStatus.fromJson(Map<String, dynamic> json) => _$RemoteStatusFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteStatusToJson(this);

}

extension RemoteStatusExtension on RemoteStatus {
  Status mapToDomain() {
    return Status(
      id: id ?? 0,
      name: name ?? "",
      colorCode: colorCode ?? "",
      logo: logo ?? "",
      isCompleted: isCompleted ?? false,
      isCurrent: isCurrent ?? false,
      captionStatusCode: captionStatusCode ?? "",
    );
  }
}

extension RemoteStatusListExtension on List<RemoteStatus>? {
  List<Status> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}