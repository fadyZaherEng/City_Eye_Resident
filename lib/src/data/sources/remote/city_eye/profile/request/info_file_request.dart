import 'package:json_annotation/json_annotation.dart';

part 'info_file_request.g.dart';

@JsonSerializable()
class InfoFileRequest {
  @JsonKey(name: 'controlTypeId')
  final int controlTypeId;
  @JsonKey(name: 'controlTypeCode')
  final String controlTypeCode;
  @JsonKey(name: 'lable')
  final String label;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'isRequired')
  final bool isRequired;
  @JsonKey(name: 'value')
  final String value;
  @JsonKey(name: 'answerId')
  final int answerId;

  const InfoFileRequest({
    required this.controlTypeId,
    required this.controlTypeCode,
    required this.label,
    required this.id,
    required this.isRequired,
    required this.value,
    required this.answerId,
  });

  factory InfoFileRequest.fromJson(Map<String, dynamic> json) =>
      _$InfoFileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InfoFileRequestToJson(this);


  Map<String, dynamic> toMap() {
    return {
      'controlTypeId': controlTypeId,
      'controlTypeCode': controlTypeCode,
      'label': label,
      'id': id,
      'isRequired': isRequired,
      'value': value,
      'answerId': answerId,
    };
  }

  factory InfoFileRequest.fromMap(Map<String, dynamic> map) {
    return InfoFileRequest(
      controlTypeId: map['controlTypeId'] as int,
      controlTypeCode: map['controlTypeCode'] as String,
      label: map['label'] as String,
      id: map['id'] as int,
      isRequired: map['isRequired'] as bool,
      value: map['value'] as String,
      answerId: map['answerId'] as int,
    );
  }

}

