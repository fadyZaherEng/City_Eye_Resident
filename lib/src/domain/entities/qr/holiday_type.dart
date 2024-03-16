import 'package:equatable/equatable.dart';

class HolidayType extends Equatable {
  final int id;
  final String name;

  const HolidayType({
    this.id = 0,
    this.name = "",
  });

  HolidayType deepClone() {
    return HolidayType(
      id: id,
      name: name,
    );
  }


  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
