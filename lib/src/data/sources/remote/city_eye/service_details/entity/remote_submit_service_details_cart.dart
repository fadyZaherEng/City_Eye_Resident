import 'package:json_annotation/json_annotation.dart';

import '../../../../../../domain/entities/service_details/submit_service_details_cart.dart';

part 'remote_submit_service_details_cart.g.dart';

@JsonSerializable()
final class RemoteSubmitServiceDetailsCart {
  final int? id;
  final String? paymentUrl;

  const RemoteSubmitServiceDetailsCart({
    this.id = 0,
    this.paymentUrl = "",
  });

  factory RemoteSubmitServiceDetailsCart.fromJson(Map<String, dynamic> json) =>
      _$RemoteSubmitServiceDetailsCartFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSubmitServiceDetailsCartToJson(this);
}

extension RemoteSubmitServiceDetailsCartExtension
    on RemoteSubmitServiceDetailsCart? {
  SubmitServiceDetailsCart mapToDomain() {
    return SubmitServiceDetailsCart(
      id: this?.id ?? 0,
      paymentUrl: this?.paymentUrl ?? "",
    );
  }
}
