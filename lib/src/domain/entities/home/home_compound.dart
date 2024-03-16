import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_section_item.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:equatable/equatable.dart';

final class HomeCompound extends Equatable {
  final List<HomeCompoundItem> homeSections;
  final List<HomeSupport> supportCategories;
  final List<HomeService> servicesCategories;
  final List<HomeEventItem> events;
  final List<Survey> surveys;
  final List<PageField> extraFieldEvents;

  const HomeCompound({
    this.homeSections = const [],
    this.supportCategories = const [],
    this.servicesCategories = const [],
    this.events = const [],
    this.surveys = const [],
    this.extraFieldEvents = const [],
  });

  @override
  List<Object> get props => [
        homeSections,
        supportCategories,
        servicesCategories,
        events,
        surveys,
        extraFieldEvents,
      ];
}
