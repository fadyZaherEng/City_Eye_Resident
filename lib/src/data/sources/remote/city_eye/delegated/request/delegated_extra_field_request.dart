import 'package:json_annotation/json_annotation.dart';

part 'delegated_extra_field_request.g.dart';

@JsonSerializable()
class DelegatedExtraFieldRequest {
  final int id;
  final int controlTypeId;
  final String controlTypeCode;
  final String lable;
  final bool isRequired;
  final String value;
  final String answerId;

  const DelegatedExtraFieldRequest({
    this.id = 0,
    this.controlTypeId = 0,
    this.controlTypeCode = "",
    this.lable = "",
    this.isRequired = false,
    this.value = "",
    this.answerId = "",
  });

  factory DelegatedExtraFieldRequest.fromJson(Map<String, dynamic> json) =>
      _$DelegatedExtraFieldRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DelegatedExtraFieldRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'controlTypeId': controlTypeId,
      'controlTypeCode': controlTypeCode,
      'lable': lable,
      'isRequired': isRequired,
      'value': value,
      'answerId': answerId,
    };
  }

  factory DelegatedExtraFieldRequest.fromMap(Map<String, dynamic> map) {
    return DelegatedExtraFieldRequest(
      id: map['id'] as int,
      controlTypeId: map['controlTypeId'] as int,
      controlTypeCode: map['controlTypeCode'] as String,
      lable: map['lable'] as String,
      isRequired: map['isRequired'] as bool,
      value: map['value'] as String,
      answerId: map['answerId'] as String,
    );
  }

  DelegatedExtraFieldRequest copyWith({
    String? value,
  }) {
    return DelegatedExtraFieldRequest(
      value: value ?? this.value,
    );
  }
}
