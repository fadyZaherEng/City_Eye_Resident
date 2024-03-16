import 'package:city_eye/src/domain/entities/wall/images.dart';
import 'package:city_eye/src/domain/entities/wall/wall_attachment.dart';

class ImagesScreen {
  final List<WallAttachment> images;
  final int initialIndex;

  ImagesScreen({required this.initialIndex, required this.images});
}
