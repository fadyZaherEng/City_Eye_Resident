import 'package:equatable/equatable.dart';

final class NotificationType extends Equatable {
  final int id;
  final String name;
  final String code;

  const NotificationType({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  NotificationType copyWith({
    int? id,
    String? name,
    String? code,
  }) =>
      NotificationType(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
      );

  @override
  List<Object> get props => [id, name, code];
}
