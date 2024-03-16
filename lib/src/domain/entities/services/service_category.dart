import 'package:equatable/equatable.dart';

class ServiceCategory extends Equatable {
  final int id;
  final String name;
  final String code;
  final String logo;

  const ServiceCategory({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.logo = "",
  });

  ServiceCategory copyWith({
    int? id,
    String? name,
    String? code,
    String? logo,
  }) =>
      ServiceCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        logo: logo ?? this.logo,
      );

  @override
  List<Object> get props => [id, name, code, logo];
}
