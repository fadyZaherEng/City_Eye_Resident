import 'package:json_annotation/json_annotation.dart';

part 'edit_mobile_number_request.g.dart';

@JsonSerializable()
class EditMobileNumberRequest {
  final int userId;
  final int compoundId;
  final String mobileNumber;

  const EditMobileNumberRequest({
    required this.userId,
    required this.compoundId,
    required this.mobileNumber,
  });

  factory EditMobileNumberRequest.fromJson(Map<String, dynamic> json) =>
      _$EditMobileNumberRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditMobileNumberRequestToJson(this);

  @override
  String toString() {
    return 'EditMobileNumberRequest{userId: $userId, mobileNumber: $mobileNumber , compoundId: $compoundId}';
  }
}
