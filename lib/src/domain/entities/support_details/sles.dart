import 'package:equatable/equatable.dart';

class Sles extends Equatable {
  final int id;
  final String name;
  final String code;
  final int noOfMinutes;
  final bool isSLE;

  const Sles({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.noOfMinutes = 0,
    this.isSLE = false,
  });

  @override
  List<Object?> get props => [id, name, code, noOfMinutes, isSLE];

}