import 'package:city_eye/src/domain/entities/offers/destination_mobile_pages.dart';
import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final int id;
  final String title;
  final String description;
  final bool iSRedirectUrl;
  final String redirectUrl;
  final String startDate;
  final String endDate;
  final String attachment;
  final DestinationMobilePages? destinationMobilePages;
  final int? destinationSourceId;

  const Offer({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.iSRedirectUrl = false,
    this.redirectUrl = "",
    this.startDate = "",
    this.endDate = "",
    this.attachment = "",
    this.destinationMobilePages,
    this.destinationSourceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iSRedirectUrl': iSRedirectUrl,
      'redirectUrl': redirectUrl,
      'startDate': startDate,
      'endDate': endDate,
      'attachment': attachment,
      'destinationMobilePages': destinationMobilePages?.toMap(),
      'destinationSourceId': destinationSourceId,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      iSRedirectUrl: map["iSRedirectUrl"],
      redirectUrl: map["redirectUrl"],
      startDate: map["startDate"],
      endDate: map["endDate"],
      attachment: map["attachment"],
      destinationMobilePages: map["destinationMobilePages"].fromMap(),
      destinationSourceId: map["destinationSourceId"],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        iSRedirectUrl,
        startDate,
        endDate,
        attachment,
        destinationMobilePages,
        destinationSourceId
      ];
}
