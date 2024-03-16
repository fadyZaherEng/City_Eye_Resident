import 'package:city_eye/src/domain/entities/wall/wall_attachment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_wall_attachment.g.dart';

@JsonSerializable()
class RemoteWallAttachment {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'attachment')
  final String? attachment;
  @JsonKey(name: 'sortNo')
  final int? sortNo;

  const RemoteWallAttachment({
    this.id = 0,
    this.name = "",
    this.attachment = "",
    this.sortNo = 0,
  });

  factory RemoteWallAttachment.fromJson(Map<String, dynamic> json) =>
      _$RemoteWallAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteWallAttachmentToJson(this);
}

extension RemoteWallAttachmentExtension on RemoteWallAttachment {
  WallAttachment mapToDomain() {
    return WallAttachment(
      id: id ?? 0,
      name: name ?? "",
      attachment: attachment ?? "",
      sortNo: sortNo ?? 0,
    );
  }
}

extension RemoteWallAttachmentListExtension on List<RemoteWallAttachment>? {
  List<WallAttachment> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
