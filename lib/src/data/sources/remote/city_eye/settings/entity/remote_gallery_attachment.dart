import 'package:city_eye/src/domain/entities/gallery/gallery.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_gallery_attachment.g.dart';

@JsonSerializable()
final class RemoteGalleryAttachment {
  int? id;
  String? name;
  String? attachment;
  int? sortNo;

  RemoteGalleryAttachment({
    this.id = 0,
    this.name = "",
    this.attachment = "",
    this.sortNo = 0,
  });

  factory RemoteGalleryAttachment.fromJson(Map<String, dynamic> json) =>
      _$RemoteGalleryAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteGalleryAttachmentToJson(this);
}

typedef JsonTypeForGallery = Map<String, dynamic>;

extension RemoteGalleryAttachmentExtension on List<RemoteGalleryAttachment>? {
  List<GalleryAttachment> get mapToDomain => this!
      .map(
        (galleryAttachment) => GalleryAttachment(
          id: galleryAttachment.id ?? 0,
          name: galleryAttachment.name ?? "",
          attachment: galleryAttachment.attachment ?? "",
          sortNo: galleryAttachment.sortNo ?? 0,
        ),
      )
      .toList();
}
