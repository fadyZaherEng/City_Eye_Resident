import 'package:json_annotation/json_annotation.dart';
part 'gallery_request.g.dart';

@JsonSerializable()
final class GalleryDetailsRequest {
  final String id;

  GalleryDetailsRequest({required this.id});

  factory GalleryDetailsRequest.fromJson(JsonTypeForGalleryDetailsRequest json) =>
      _$GalleryDetailsRequestFromJson(json);

  JsonTypeForGalleryDetailsRequest get toJson => _$GalleryDetailsRequestToJson(this);
}

typedef JsonTypeForGalleryDetailsRequest = Map<String, dynamic>;
