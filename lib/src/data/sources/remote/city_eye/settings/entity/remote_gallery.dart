import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_gallery.g.dart';

@JsonSerializable(explicitToJson: true)
final class RemoteGallery {
  int? id;
  String? title;
  String? description;
  String? galleryDate;
  String? createdBy;
  String? mainImage;
  List<RemoteGalleryAttachment>? galleryAttachments;

  RemoteGallery({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.galleryDate = "",
    this.createdBy = "",
    this.mainImage = "",
    this.galleryAttachments = const <RemoteGalleryAttachment>[],
  });

  factory RemoteGallery.fromJson(Map<String, dynamic> json) =>
      _$RemoteGalleryFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteGalleryToJson(this);
}

extension RemoteGalleryExtension on List<RemoteGallery>? {
  List<Gallery> get mapToDomain => this!
      .map(
        (gallery) => Gallery(
          id: gallery.id ?? 0,
          title: gallery.title ?? "",
          description: gallery.description ?? "",
          createdBy: gallery.createdBy ?? "",
          mainImage: gallery.mainImage ?? "",
          galleryDate: gallery.galleryDate ?? "",
          galleryAttachments: gallery.galleryAttachments.mapToDomain,
        ),
      )
      .toList();
}

extension RemoteGalleryExtensionForSingleItem on RemoteGallery? {
  Gallery get mapToDomain => Gallery(
        id: this?.id ?? 0,
        title: this?.title ?? "",
        description: this?.description ?? "",
        createdBy: this?.createdBy ?? "",
        mainImage: this?.mainImage ?? "",
        galleryDate: this?.galleryDate ?? "",
        galleryAttachments: this!.galleryAttachments.mapToDomain,
      );
}
