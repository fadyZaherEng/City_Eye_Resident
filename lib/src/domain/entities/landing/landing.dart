import 'package:city_eye/src/domain/entities/landing/feature.dart';
import 'package:city_eye/src/domain/entities/landing/partner.dart';
import 'package:city_eye/src/domain/entities/landing/social_media.dart';
import 'package:equatable/equatable.dart';

class Landing extends Equatable {
  final List<Partner> partners;
  final List<Feature> features;
  final List<SocialMedia> socialMedia;

  const Landing({
    this.partners = const [],
    this.features = const [],
    this.socialMedia = const [],
  });

  @override
  List<Object?> get props => [partners, features, socialMedia];
}
