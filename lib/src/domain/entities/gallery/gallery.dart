import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:equatable/equatable.dart';

final class Gallery extends Equatable {
  final int id;
  final String title;
  final String description;
  final String galleryDate;
  final String createdBy;
  final String mainImage;
  final List<GalleryAttachment> galleryAttachments;

  const Gallery({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.galleryDate = "",
    this.createdBy = "",
    this.mainImage = "",
    this.galleryAttachments = const <GalleryAttachment>[],
  });

  @override
  List<Object> get props => [
        id,
        title,
        description,
        galleryDate,
        createdBy,
        mainImage,
        galleryAttachments,
      ];

  @override
  String toString() {
    return 'Gallery{id: $id, title: $title, description: $description, galleryDate: $galleryDate, createdBy: $createdBy, galleryAttachments: $galleryAttachments}';
  }
}
