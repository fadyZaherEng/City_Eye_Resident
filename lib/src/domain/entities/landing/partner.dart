import 'package:equatable/equatable.dart';

class Partner extends Equatable {
  final int id;
  final String name;
  final String code;
  final String mobile;
  final String logo;
  final String description;

  const Partner({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.mobile = "",
    this.logo = "",
    this.description = "",
  });

  @override
  List<Object?> get props => [id, name, code, mobile, logo, description];
}
