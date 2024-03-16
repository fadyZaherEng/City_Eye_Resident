import 'package:equatable/equatable.dart';

class HomeEventOption extends Equatable {
  final int id;
  final String name;
  final int eventId;
  final bool isCalendar;
  final bool isJoin;
  final bool isSelectedByUser;

  const HomeEventOption({
    this.id = 0,
    this.name = "",
    this.eventId = 0,
    this.isCalendar = false,
    this.isJoin = false,
    this.isSelectedByUser = false,
  });

  HomeEventOption copyWith({
    int? id,
    String? name,
    int? eventId,
    bool? isCalendar,
    bool? isJoin,
    bool? isSelectedByUser,
  }) {
    return HomeEventOption(
      id: id ?? this.id,
      name: name ?? this.name,
      eventId: eventId ?? this.eventId,
      isCalendar: isCalendar ?? this.isCalendar,
      isJoin: isJoin ?? this.isJoin,
      isSelectedByUser: isSelectedByUser ?? this.isSelectedByUser,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        eventId,
        isCalendar,
        isJoin,
        isSelectedByUser,
      ];
}
