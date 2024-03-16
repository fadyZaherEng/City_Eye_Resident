import 'package:equatable/equatable.dart';

class Feature extends Equatable {
  final int id;
  final String name;
  final String description;
  final String logo;

  const Feature({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.logo = "",
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        logo,
      ];
}
