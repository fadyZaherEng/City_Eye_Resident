import 'package:city_eye/src/domain/entities/community_request/submit_community.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_submit_community.g.dart';

@JsonSerializable()
class RemoteSubmitCommunity {
  final int? id;

  const RemoteSubmitCommunity({
    this.id = 0,
  });

  factory RemoteSubmitCommunity.fromJson(Map<String, dynamic> json) => _$RemoteSubmitCommunityFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSubmitCommunityToJson(this);

}

extension RemoteSubmitCommunityRequestResponseExtension on RemoteSubmitCommunity {
  SubmitCommunity mapToDomain() {
    return SubmitCommunity(
      id: id ?? 0,
    );
  }
}