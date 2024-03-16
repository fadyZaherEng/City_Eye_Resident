import 'package:equatable/equatable.dart';

class WeekEndDays extends Equatable {
  final int id;
  final String name;
  final String code;

  const WeekEndDays({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  @override
  List<Object?> get props => [id, name, code];
}
