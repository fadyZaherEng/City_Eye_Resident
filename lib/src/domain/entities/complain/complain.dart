import 'package:equatable/equatable.dart';

class Complain extends Equatable {
  final int id;

  const Complain({
    this.id = 0,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
