import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:equatable/equatable.dart';

class EventData extends Equatable {
  List<HomeEventItem> events;
  List<PageField> dynamicQuestions;

  EventData({required this.events, required this.dynamicQuestions});

  @override
  List<Object?> get props => [
        events,
        dynamicQuestions,
      ];
}
