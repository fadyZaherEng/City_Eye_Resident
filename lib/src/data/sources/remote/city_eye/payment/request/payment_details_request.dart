
import 'package:json_annotation/json_annotation.dart';

part 'payment_details_request.g.dart';

@JsonSerializable()
class PaymentDetailsRequest {
  final int invoiceId;

  const PaymentDetailsRequest({
    required this.invoiceId,
  });

  factory PaymentDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDetailsRequestToJson(this);

  @override
  String toString() {
    return 'PaymentDetailsRequest{invoiceId: $invoiceId}';
  }
}