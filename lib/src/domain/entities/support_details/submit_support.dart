import 'package:equatable/equatable.dart';

final class SubmitSupport extends Equatable {
  final int id;

  const SubmitSupport({
    this.id = 0,
  });

  @override
  List<Object> get props => [id];

  SubmitSupport copyWith({
    int? id,
  }) {
    return SubmitSupport(
      id: id ?? this.id,
    );
  }
}
