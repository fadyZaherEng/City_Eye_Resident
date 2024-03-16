import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String code;
  final String name;
  final String logo;

  const Category({
    this.id = 0,
    this.code = "",
    this.name = "",
    this.logo = "",
  });

  @override
  List<Object?> get props => [id, code, name, logo];

}