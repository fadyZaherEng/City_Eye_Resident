import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_file.g.dart';

@JsonSerializable()
class RegisterFile {
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
  @JsonKey(name: 'expireDate')
  final String expireDate;

  const RegisterFile({
    required this.controlTypeId,
    required this.controlTypeCode,
    required this.label,
    required this.id,
    required this.isRequired,
    required this.value,
    required this.expireDate,
  });

  factory RegisterFile.fromJson(Map<String, dynamic> json) =>
      _$RegisterFileFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterFileToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'controlTypeId': controlTypeId,
      'controlTypeCode': controlTypeCode,
      'label': label,
      'id': id,
      'isRequired': isRequired,
      'value': value,
      'expireDate': expireDate,
    };
  }

  factory RegisterFile.fromMap(Map<String, dynamic> map) {
    return RegisterFile(
      controlTypeId: map['controlTypeId'] as int,
      controlTypeCode: map['controlTypeCode'] as String,
      label: map['label'] as String,
      id: map['id'] as int,
      isRequired: map['isRequired'] as bool,
      value: map['value'] as String,
      expireDate: map['expireDate'] as String,
    );
  }
}

extension RegisterFileExtension on RegisterFile {
  Future<MultipartFile> toMultipart() async {
    return await MultipartFile.fromFile(value, filename: id.toString());
  }
}

extension RegisterFilesExtension on List<RegisterFile> {
  Future<List<MultipartFile>> toMultipart() async {
    return await Future.wait(map((file) async => await file.toMultipart()));
  }
}
