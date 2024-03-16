import 'package:city_eye/src/domain/entities/qr_details/qr_details_question.dart';

class QrDetails {
  bool isMultiplePass;
  String expireDate;
  String visitDate;
  String visitDays;
  String visitorName;
  String visitorType;
  String qr;
  String downloadQr;
  String shareQr;
  List<QrDetailsQuestion> qrDetailsQuestion;

  QrDetails({
    required this.isMultiplePass,
    required this.expireDate,
    required this.visitDate,
    required this.visitDays,
    required this.visitorName,
    required this.visitorType,
    required this.qr,
    required this.downloadQr,
    required this.shareQr,
    required this.qrDetailsQuestion,
  });
}
