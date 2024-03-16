import 'package:city_eye/src/domain/entities/payment/currency.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_currency.g.dart';

@JsonSerializable()
final class RemoteCurrency {
  final int? id;
  final String? name;
  final String? code;

  const RemoteCurrency({
    this.id = 0,
    this.name = "",
    this.code = "",
  });


  factory RemoteCurrency.fromJson(Map<String, dynamic> json) =>
      _$RemoteCurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCurrencyToJson(this);

}

extension RemoteCurrencyExtension on RemoteCurrency? {
  Currency get mapToDomain {
    return Currency(
      id: this?.id ?? 0,
      name: this?.name ?? "",
      code: this?.code ?? "",
    );
  }
}
