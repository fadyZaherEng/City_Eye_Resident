import 'package:equatable/equatable.dart';

class DayTimeQrHistory extends Equatable {
  final int id;
  final String fromTime;
  final String toTime;

  const DayTimeQrHistory({
    this.id = 0,
    this.fromTime = "",
    this.toTime = "",
  });

  @override
  List<Object> get props => [
        id,
        fromTime,
        toTime,
      ];
}
