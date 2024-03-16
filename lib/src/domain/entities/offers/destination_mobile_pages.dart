import 'package:equatable/equatable.dart';

class DestinationMobilePages extends Equatable {
  final int id;
  final String name;
  final String code;

  const DestinationMobilePages({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }

  factory DestinationMobilePages.fromMap(Map<String, dynamic> map) {
    return DestinationMobilePages(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      code: map['code'] ?? '',
    );
  }


  @override
  List<Object?> get props => [id, name, code];
}