import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_type.dart';
import 'package:city_eye/src/domain/entities/profile/car.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_car.g.dart';

@JsonSerializable()
class RemoteCar {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'plateNumber')
  final String? plateNumber;
  @JsonKey(name: 'carType')
  final RemoteType? carType;
  @JsonKey(name: 'modelType')
  final RemoteType? modelType;
  @JsonKey(name: 'colorType')
  final RemoteType? colorType;

  const RemoteCar({
    this.id = 0,
    this.plateNumber = "",
    this.carType = const RemoteType(),
    this.modelType = const RemoteType(),
    this.colorType = const RemoteType(),
  });

  factory RemoteCar.fromJson(Map<String, dynamic> json) =>
      _$RemoteCarFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCarToJson(this);
}

//write extension to map RemoteCar to domain Car
extension RemoteCarExtension on RemoteCar {
  Car mapToDomain() {
    return Car(
      id: id ?? 0,
      plateNumber: plateNumber ?? "",
      carType: (carType ?? const RemoteType()).mapToDomain(),
      modelType: (modelType ?? const RemoteType()).mapToDomain(),
      colorType: (colorType ?? const RemoteType()).mapToDomain(),
    );
  }
}

//write extension to map List<RemoteCar> to domain List<Car>
extension RemoteCarListExtension on List<RemoteCar>? {
  List<Car> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
