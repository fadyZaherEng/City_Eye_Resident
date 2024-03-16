import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/service_package_question_request.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_service_details_cart_request.g.dart';

@JsonSerializable(explicitToJson: true)
final class SubmitServiceDetailsCartRequest {
  final int packageId;
  final int serviceCount;
  @JsonKey(name: "servicePackageQuestions")
  final List<ServicePackageQuestionRequest> remoteServicePackagesQuestion;

  const SubmitServiceDetailsCartRequest({
    required this.packageId,
    required this.serviceCount,
    required this.remoteServicePackagesQuestion,
  });

  factory SubmitServiceDetailsCartRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitServiceDetailsCartRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SubmitServiceDetailsCartRequestToJson(this);
}

