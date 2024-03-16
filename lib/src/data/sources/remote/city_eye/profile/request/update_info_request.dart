import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/info_file_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_info_request.g.dart';

@JsonSerializable()
class UpdateInfoRequest {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'mobileNumber')
  final String mobileNumber;
  @JsonKey(name: 'extraFields')
  final List<InfoFileRequest> extraFields;

  const UpdateInfoRequest({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.extraFields,
  });

  factory UpdateInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInfoRequestToJson(this);


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'extraFields': extraFields.map((file) => file.toMap()).toList(),
    };
  }

  factory UpdateInfoRequest.fromMap(Map<String, dynamic> map) {
    return UpdateInfoRequest(
      name: map['name'] as String,
      email: map['email'] as String,
      mobileNumber: map['mobileNumber'] as String,
      extraFields: map['extraFields'] as List<InfoFileRequest>,
    );
  }

}
