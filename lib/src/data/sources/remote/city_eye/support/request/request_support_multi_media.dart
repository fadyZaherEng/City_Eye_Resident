import 'package:equatable/equatable.dart';

final class SupportMultiMediaRequest extends Equatable {
  final List<String> images;
  final List<String> videos;
  final List<String> audios;
  final String imageCode;
  final String videoCode;
  final String audioCode;

  const SupportMultiMediaRequest({
    required this.images,
    required this.videos,
    required this.audios,
    required this.imageCode,
    required this.videoCode,
    required this.audioCode,
  });

  SupportMultiMediaRequest copyWith({
    List<String>? images,
    List<String>? videos,
    List<String>? audios,
    String? imageCode,
    String? audioCode,
    String? videoCode,
  }) {
    return SupportMultiMediaRequest(
      images: images ?? this.images,
      videos: videos ?? this.videos,
      audios: audios ?? this.audios,
      imageCode: imageCode ?? this.imageCode,
      audioCode: audioCode ?? this.audioCode,
      videoCode: videoCode ?? this.videoCode,
    );
  }

  @override
  List<Object> get props => [
        images,
        videos,
        audios,
        videoCode,
        imageCode,
        audioCode,
      ];

  @override
  String toString() {
    return 'SupportMultiMediaRequest{images: $images, videos: $videos, audios: $audios }';
  }
}
