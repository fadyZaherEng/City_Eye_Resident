import 'package:city_eye/src/data/sources/remote/city_eye/register/request/register_file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: 'unitId')
  final String unitId;
  @JsonKey(name: 'UserTypeId')
  final String userTypeId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'mobileNumber')
  final String mobileNumber;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'Files')
  final List<RegisterFile> files;


  const RegisterRequest({
    required this.unitId,
    required this.userTypeId,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.files,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'unitId': unitId,
      'UserTypeId': userTypeId,
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'password': password,
      'Files': files.map((file) => file.toMap()).toList(),
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      unitId: map['unitId'] as String,
      userTypeId: map['userTypeId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      mobileNumber: map['mobileNumber'] as String,
      password: map['password'] as String,
      files: map['files'] as List<RegisterFile>,
    );
  }
}
