import 'package:equatable/equatable.dart';

final class NotificationPriority extends Equatable {
  final int id;
  final String name;
  final String code;
  final String extra1;

  const NotificationPriority({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.extra1 = "",
  });

  NotificationPriority copyWith({
    int? id,
    String? name,
    String? code,
    String? extra1,
  }) =>
      NotificationPriority(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        extra1: extra1 ?? this.extra1,
      );

  @override
  List<Object> get props => [id, name, code, extra1];
}
