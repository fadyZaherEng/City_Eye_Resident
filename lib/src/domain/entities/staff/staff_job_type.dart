import 'package:equatable/equatable.dart';

class StaffJobType extends Equatable {
  final int id;
  final String name;
  final String code;

  const StaffJobType({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  @override
  List<Object?> get props => [id, name, code];
}
