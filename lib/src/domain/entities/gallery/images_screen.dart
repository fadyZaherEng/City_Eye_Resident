import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';

class GalleryImages {
  final List<GalleryAttachment> images;
  final int initialIndex;

  GalleryImages({required this.initialIndex, required this.images});
}