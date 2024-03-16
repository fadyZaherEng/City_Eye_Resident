import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_destination_mobile_pages.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_offers.g.dart';

@JsonSerializable()
class RemoteOffers {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'iSRedirectURL')
  final bool? iSRedirectUrl;
  @JsonKey(name: 'redirectURL')
  final String? redirectUrl;
  @JsonKey(name: 'startDate')
  final String? startDate;
  @JsonKey(name: 'endDate')
  final String? endDate;
  @JsonKey(name: 'attachment')
  final String? attachment;
  @JsonKey(name: 'destinationMobilePages')
  final RemoteDestinationMobilePages? remoteDestinationMobilePages;
  @JsonKey(name: 'destinationSourceId')
  final int? destinationSourceId;

  const RemoteOffers({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.iSRedirectUrl = false,
    this.redirectUrl = "",
    this.startDate = "",
    this.endDate = "",
    this.attachment = "",
    this.remoteDestinationMobilePages,
    this.destinationSourceId,
  });

  factory RemoteOffers.fromJson(Map<String, dynamic> json) =>
      _$RemoteOffersFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteOffersToJson(this);

}

extension RemoteOffersExtension on RemoteOffers {
  Offer mapToDomain() {
    return Offer(
      id: id ?? 0,
      title: title ?? "",
      description: description ?? "",
      iSRedirectUrl: iSRedirectUrl ?? false,
      redirectUrl: redirectUrl ?? "",
      startDate: startDate ?? "",
      endDate: endDate ?? "",
      attachment: attachment ?? "",
      destinationMobilePages: remoteDestinationMobilePages?.mapToDomain(),
      destinationSourceId: destinationSourceId,
    );
  }
}

extension RemoteOffersListExtension on List<RemoteOffers>? {
  List<Offer> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
