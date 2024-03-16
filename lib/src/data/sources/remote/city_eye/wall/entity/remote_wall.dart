import 'package:city_eye/src/data/sources/remote/city_eye/wall/entity/remote_wall_attachment.dart';
import 'package:city_eye/src/domain/entities/wall/wall.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_wall.g.dart';

@JsonSerializable()
class RemoteWall {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'wallDate')
  final String? wallDate;
  @JsonKey(name: 'createdBy')
  final String? createdBy;
  @JsonKey(name: 'mainImage')
  final String? mainImage;
  @JsonKey(name: 'wallAttachments')
  final List<RemoteWallAttachment>? wallAttachments;

  RemoteWall({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.wallDate = "",
    this.createdBy = "",
    this.mainImage = "",
    this.wallAttachments = const [],
  });

  factory RemoteWall.fromJson(Map<String, dynamic> json) =>
      _$RemoteWallFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteWallToJson(this);
}

extension RemoteWallExtension on RemoteWall {
  Wall mapToDomain() {
    return Wall(
      id: id ?? 0,
      title: title ?? "",
      description: description ?? "",
      wallDate: wallDate ?? "",
      createdBy: createdBy ?? "",
      mainImage: mainImage ?? "",
      wallAttachments: (wallAttachments ?? []).mapToDomain(),
    );
  }
}

extension RemoteWallListExtension on List<RemoteWall>? {
  List<Wall> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
