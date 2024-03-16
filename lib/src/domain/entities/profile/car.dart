import 'package:city_eye/src/domain/entities/profile/type_model.dart';
import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final int id;
  final int userUnitId;
  final String plateNumber;
  final TypeModel carType;
  final TypeModel modelType;
  final TypeModel colorType;

  const Car({
    this.id = 0,
    this.userUnitId = 0,
    this.plateNumber = "",
    this.carType = const TypeModel(),
    this.modelType = const TypeModel(),
    this.colorType = const TypeModel(),
  });


  Car copyWith({
    int? id,
    int? userUnitId,
    String? plateNumber,
    TypeModel? carType,
    TypeModel? modelType,
    TypeModel? colorType,
  }) {
    return Car(
      id: id ?? this.id,
      userUnitId: userUnitId ?? this.userUnitId,
      plateNumber: plateNumber ?? this.plateNumber,
      carType: carType ?? this.carType,
      modelType: modelType ?? this.modelType,
      colorType: colorType ?? this.colorType,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userUnitId,
        plateNumber,
        carType,
        modelType,
        colorType,
      ];
}
