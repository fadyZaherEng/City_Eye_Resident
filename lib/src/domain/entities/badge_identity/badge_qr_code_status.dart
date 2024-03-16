import 'package:equatable/equatable.dart';

class BadgeQrCodeStatus extends Equatable {
  final int id;
  final String code;
  final String name;
  final String color;

  const BadgeQrCodeStatus({
    this.id = 0,
    this.code = "",
    this.name = "",
    this.color = "",
  });

  @override
  List<Object> get props => [
        id,
        code,
        name,
        color,
      ];
}
