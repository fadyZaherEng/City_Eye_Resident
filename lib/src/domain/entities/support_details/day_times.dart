import 'package:equatable/equatable.dart';

class DayTimes extends Equatable {
  final int id;
  final String time;
  final String fromTime;
  final String toTime;
  final bool isSelected;

  const DayTimes({
    this.id = 0,
    this.time = "",
    this.fromTime = "",
    this.toTime = "",
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [id, time, fromTime, toTime];

  DayTimes copyWith({
    int? id,
    String? time,
    String? fromTime,
    String? toTime,
    bool? isSelected,
  }) {
    return DayTimes(
      id: id ?? this.id,
      time: time ?? this.time,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
