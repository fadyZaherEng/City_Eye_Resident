import 'package:equatable/equatable.dart';

class BadgeCompoundUnits extends Equatable {
  final int id;
  final String name;
  final String unitNO;

  const BadgeCompoundUnits({
    this.id = 0,
    this.name = "",
    this.unitNO = "",
  });

  @override
  List<Object> get props => [
        id,
        name,
        unitNO,
      ];
}
