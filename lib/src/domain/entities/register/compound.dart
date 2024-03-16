import 'package:equatable/equatable.dart';

class Compound extends Equatable {
  final int id;
  final int cityId;
  final String name;
  final String cityName;
  final String logo;

  const Compound({
    this.id = 0,
    this.cityId = 0,
    this.name = "",
    this.cityName = "" ,
    this.logo = "",
  });

  @override
  List<Object?> get props => [
    id,
    cityId,
    name,
    cityName,
    logo,
  ];
}
