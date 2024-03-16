import 'package:equatable/equatable.dart';

class DayTime extends Equatable {
  final int id;
  final String time;
  final bool isSelected;

  const DayTime({
    this.id = -1,
    this.time = "",
    this.isSelected = false,
  });

  DayTime copyWith({
    int? id,
    String? time,
    bool? isSelected,
  }) {
    return DayTime(
      id: id ?? this.id,
      time: time ?? this.time,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  DayTime deepClone() {
    return DayTime(
      id: id,
      time: time,
      isSelected: isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        time,
        isSelected,
      ];
}
