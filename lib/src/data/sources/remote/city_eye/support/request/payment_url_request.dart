import 'package:json_annotation/json_annotation.dart';


part 'payment_url_request.g.dart';

@JsonSerializable()
class PaymentUrlRequest {
  final int requestId;

  PaymentUrlRequest({
    required this.requestId,
  });

  factory PaymentUrlRequest.fromJson(Map<String, dynamic> json) => _$PaymentUrlRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentUrlRequestToJson(this);
}
