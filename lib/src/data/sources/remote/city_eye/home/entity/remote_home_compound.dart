import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_compound_item.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_event.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_extra_field.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_home_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_home_support.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_survey.dart';
import 'package:city_eye/src/domain/entities/home/home_compound.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_home_compound.g.dart';

@JsonSerializable()
final class RemoteHomeCompound {
  List<RemoteHomeCompoundItem>? homeSections;
  List<RemoteHomeSupport>? supportCategorys;
  List<RemoteHomeService>? servicesCategorys;
  List<RemoteEvent>? events;
  List<RemoteSurvey>? surveys;
  List<RemoteExtraField>? extraFieldEvents;

  RemoteHomeCompound({
    this.homeSections = const [],
    this.supportCategorys = const [],
    this.servicesCategorys = const [],
    this.events = const [],
    this.surveys = const [],
    this.extraFieldEvents = const [],
  });

  factory RemoteHomeCompound.fromJson(Map<String, dynamic> json) =>
      _$RemoteHomeCompoundFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteHomeCompoundToJson(this);
}

extension RemoteHomeCompoundExtension on RemoteHomeCompound {
  HomeCompound get mapToDomain => HomeCompound(
        homeSections: (homeSections ?? []).mapToDomain(),
        supportCategories: (supportCategorys ?? []).mapToDomain(),
        servicesCategories: (servicesCategorys ?? []).mapToDomain(),
        events: (events ?? []).mapToDomain,
        surveys: (surveys ?? []).mapToDomain,
        extraFieldEvents: (extraFieldEvents ?? []).mapToDomain,
      );
}
