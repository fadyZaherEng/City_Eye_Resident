import 'package:city_eye/src/domain/entities/settings/compound_currency.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_compound_currency.g.dart';

@JsonSerializable()
final class RemoteCompoundCurrency {
 final int? id;
 final  String? name;
 final String? code;

  const RemoteCompoundCurrency({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteCompoundCurrency.fromJson(Map<String, dynamic> json) =>
      _$RemoteCompoundCurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCompoundCurrencyToJson(this);
}

extension RemoteCompoundCurrencyExtension on RemoteCompoundCurrency? {
  CompoundCurrency get mapToDomain => CompoundCurrency(
        id: this?.id ?? 0,
        code: this?.code ?? "",
        name: this?.name ?? "",
      );
}
