import 'package:json_annotation/json_annotation.dart';
part 'service_details_cart_request.g.dart';

@JsonSerializable()
final class ServiceDetailsCartRequest {
  final int serviceCategoryId;

  ServiceDetailsCartRequest({
    required this.serviceCategoryId ,
  });

  factory ServiceDetailsCartRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceDetailsCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDetailsCartRequestToJson(this);
}
