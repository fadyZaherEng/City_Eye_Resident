import 'package:equatable/equatable.dart';

class QrGuestType extends Equatable {
  final int id;
  final String code;
  final String name;

  const QrGuestType({
    this.id = 0,
    this.code = "",
    this.name = "",
  });

  @override
  List<Object?> get props => [id, code, name];

}