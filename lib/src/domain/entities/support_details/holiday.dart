import 'package:equatable/equatable.dart';

class Holiday extends Equatable {
  final int id;
  final String name;

  const Holiday({
    this.id = 0,
    this.name = "",
  });

  @override
  List<Object> get props => [id, name];
}
