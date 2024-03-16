import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_document_request.g.dart';

@JsonSerializable()
class ProfileDocumentRequest {
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
  final String? expireDate;
  final bool isChanged;

  const ProfileDocumentRequest({
    required this.controlTypeId,
    required this.controlTypeCode,
    required this.label,
    required this.id,
    required this.isRequired,
    required this.value,
    required this.expireDate,
    this.isChanged = false,
  });

  factory ProfileDocumentRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileDocumentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDocumentRequestToJson(this);

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

  factory ProfileDocumentRequest.fromMap(Map<String, dynamic> map) {
    return ProfileDocumentRequest(
      controlTypeId: map['controlTypeId'] as int,
      controlTypeCode: map['controlTypeCode'] as String,
      label: map['label'] as String,
      id: map['id'] as int,
      isRequired: map['isRequired'] as bool,
      value: map['value'] as String,
      expireDate: map['expireDate'] as String,
    );
  }

  //Write CopyWith
  ProfileDocumentRequest copyWith({
    int? controlTypeId,
    String? controlTypeCode,
    String? label,
    int? id,
    bool? isRequired,
    String? value,
    String? expireDate,
    bool? isChanged,
  }) {
    return ProfileDocumentRequest(
      controlTypeId: controlTypeId ?? this.controlTypeId,
      controlTypeCode: controlTypeCode ?? this.controlTypeCode,
      label: label ?? this.label,
      id: id ?? this.id,
      isRequired: isRequired ?? this.isRequired,
      value: value ?? this.value,
      expireDate: expireDate ?? this.expireDate,
      isChanged: isChanged ?? this.isChanged,
    );
  }

  ProfileDocumentRequest deepClone() {
    return ProfileDocumentRequest(
      controlTypeId: controlTypeId,
      controlTypeCode: controlTypeCode,
      label: label,
      id: id,
      isRequired: isRequired,
      value: value,
      expireDate: expireDate,
      isChanged: isChanged,
    );
  }

}

extension ProfileDocumentRequestExtension on ProfileDocumentRequest {
  Future<MultipartFile> toMultipart() async {
    return await MultipartFile.fromFile(value, filename: id.toString());
  }
}

extension ProfileDocumentRequestsExtension on List<ProfileDocumentRequest> {
  Future<List<MultipartFile>> toMultipart() async {
    return await Future.wait(map((file) async => await file.toMultipart()));
  }
}
