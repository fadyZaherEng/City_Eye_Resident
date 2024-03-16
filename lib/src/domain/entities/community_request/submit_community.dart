import 'package:equatable/equatable.dart';

class SubmitCommunity extends Equatable {
  final int id;

  const SubmitCommunity({
    this.id = 0,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
