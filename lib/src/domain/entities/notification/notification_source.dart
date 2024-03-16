import 'package:equatable/equatable.dart';

final class NotificationSource extends Equatable {
  final int id;
  final String name;
  final String code;

  const NotificationSource({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  NotificationSource copyWith({
    int? id,
    String? name,
    String? code,
  }) =>
      NotificationSource(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
      );

  @override
  List<Object> get props => [id, name, code];
}
