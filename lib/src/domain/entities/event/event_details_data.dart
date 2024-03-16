import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:equatable/equatable.dart';

class EventDetailsData extends Equatable {
  final String link;
  final HomeEventItem event;
  final List<PageField> dynamicQuestions;

  const EventDetailsData({
    this.link = '',
    this.event = const HomeEventItem(),
    this.dynamicQuestions = const [],
  });

  EventDetailsData copyWith({
    String? link,
    HomeEventItem? event,
    List<PageField>? dynamicQuestions,
  }) {
    return EventDetailsData(
      link: link ?? this.link,
      event: event ?? this.event,
      dynamicQuestions: dynamicQuestions ?? this.dynamicQuestions,
    );
  }

  @override
  List<Object?> get props => [
        link,
        event,
        dynamicQuestions,
      ];
}
