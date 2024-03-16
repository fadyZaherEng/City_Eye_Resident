
import 'package:city_eye/src/data/sources/remote/city_eye/community_request/request/extra_field_answers_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_community_request.g.dart';

@JsonSerializable()
class SubmitCommunityRequest {
  final String description;
  final List<ExtraFieldAnswersRequest> extraFieldAnswers;

  SubmitCommunityRequest({
    required this.description,
    required this.extraFieldAnswers,
  });

  factory SubmitCommunityRequest.fromJson(Map<String, dynamic> json) => _$SubmitCommunityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitCommunityRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'extraFieldAnswers': extraFieldAnswers.map((file) => file.toMap()).toList(),
    };
  }

  factory SubmitCommunityRequest.fromMap(Map<String, dynamic> map) {
    return SubmitCommunityRequest(
      description: map['description'] as String,
      extraFieldAnswers: map['extraFieldAnswers'] as List<ExtraFieldAnswersRequest>,
    );
  }
}