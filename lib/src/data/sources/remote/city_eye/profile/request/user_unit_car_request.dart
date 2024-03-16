import 'package:json_annotation/json_annotation.dart';

part 'user_unit_car_request.g.dart';

@JsonSerializable()
final class UserUnitCarRequest {
  final int id;

  final String plateNumber;

  final int carTypeId;

  final int modelId;

  final int colorId;

  UserUnitCarRequest({
    required this.id,
    required this.plateNumber,
    required this.carTypeId,
    required this.modelId,
    required this.colorId,
  });

  factory UserUnitCarRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUnitCarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUnitCarRequestToJson(this);

  @override
  String toString() {
    return 'UserUnitCarRequest{plateNumber: $plateNumber, carTypeId: $carTypeId, modelId: $modelId, colorId: $colorId}';
  }
}
