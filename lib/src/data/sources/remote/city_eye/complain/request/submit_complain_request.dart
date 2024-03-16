
import 'package:json_annotation/json_annotation.dart';

part 'submit_complain_request.g.dart';

@JsonSerializable()
class SubmitComplainRequest {
  final String description;

  SubmitComplainRequest({
    required this.description
  });

  factory SubmitComplainRequest.fromJson(Map<String, dynamic> json) => _$SubmitComplainRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitComplainRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'description': description,
    };
  }

  factory SubmitComplainRequest.fromMap(Map<String, dynamic> map) {
    return SubmitComplainRequest(
      description: map['description'],
    );
  }
}
