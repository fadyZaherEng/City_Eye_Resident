import 'package:equatable/equatable.dart';

class PreparedVisitTime extends Equatable {
  final int id;
  final String date;
  final String name;
  final bool isSelected;

  const PreparedVisitTime({
    this.id = 0,
    this.date = "",
    this.name = "",
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        isSelected,
      ];

  PreparedVisitTime copyWith({
    int? id,
    String? date,
    bool? isSelected,
  }) {
    return PreparedVisitTime(
      id: id ?? this.id,
      date: date ?? this.date,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  String toString() {
    return 'PreparedVisitTime{id: $id, date: $date, name: $name, isSelected: $isSelected}';
  }
}
