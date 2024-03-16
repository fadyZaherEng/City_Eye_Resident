import 'package:city_eye/src/domain/entities/services/service_category.dart';
import 'package:equatable/equatable.dart';

class ServicePackages extends Equatable {
  final int id;
  final String name;
  final bool isCountType;
  final ServiceCategory serviceCategory;

  const ServicePackages({
    this.id = 0,
    this.name = "",
    this.isCountType = false,
    this.serviceCategory = const ServiceCategory(),
  });

  ServicePackages copyWith({
    int? id,
    String? name,
    bool? isCountType,
    ServiceCategory? serviceCategory,
  }) =>
      ServicePackages(
        id: id ?? this.id,
        name: name ?? this.name,
        isCountType: isCountType ?? this.isCountType,
        serviceCategory: serviceCategory ?? this.serviceCategory,
      );

  @override
  List<Object> get props => [id, name, isCountType, serviceCategory];
}
