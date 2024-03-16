import 'package:json_annotation/json_annotation.dart';

part 'city_eye_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CityEyeResponse<T> {
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'requestId')
  String? requestId;
  @JsonKey(name: 'error')
  List<String>? error;
  @JsonKey(name: 'success')
  bool? success;
  @JsonKey(name: 'responseMessage')
  String? responseMessage;
  @JsonKey(name: 'result')
  T? result;

  CityEyeResponse({
    this.statusCode,
    this.requestId,
    this.error,
    this.success,
    this.responseMessage,
    this.result,
  });

  factory CityEyeResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CityEyeResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Function(dynamic value) value) =>
      _$CityEyeResponseToJson(this, (T) {
        return T;
      });
}
