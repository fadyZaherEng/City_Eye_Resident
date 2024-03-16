import 'package:json_annotation/json_annotation.dart';

part 'add_contact_us_request.g.dart';

@JsonSerializable()
final class AddContactUsRequest {
  final String? name;
  final String? email;
  final String? mobile;
  final int? countryId;
  final String? message;

  const AddContactUsRequest({
    this.name = "",
    this.email = "",
    this.mobile = "",
    this.countryId = 0,
    this.message = "",
  });

  factory AddContactUsRequest.fromJson(Map<String, dynamic> json) =>
      _$AddContactUsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddContactUsRequestToJson(this);
}
