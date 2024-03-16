import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_question.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_rule.dart';
import 'package:city_eye/src/domain/entities/qr/qr_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qr_response.g.dart';

@JsonSerializable()
class RemoteQrResponse {
  final List<RemoteQrQuestion>? questions;
  final List<RemoteQrRule>? rules;

  RemoteQrResponse({
    this.questions = const [],
    this.rules = const [],
  });

  factory RemoteQrResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoteQrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrResponseToJson(this);
}

extension RemoteQrResponseExtension on RemoteQrResponse {
  QrResponse mapToDomain() {
    return QrResponse(
      questions: (questions ?? []).mapToDomain(),
      rules: (rules ?? []).mapToDomain(),
    );
  }
}

extension RemoteQrResponseListExtension on List<RemoteQrResponse> {
  List<QrResponse> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}