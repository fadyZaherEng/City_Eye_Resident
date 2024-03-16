import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/qr_details/qr_details.dart';
import 'package:city_eye/src/domain/entities/qr_details/qr_details_question.dart';

class GetQrDetailsUseCase {
  QrDetails call() {
    return TestDate().getTestData();
  }
}

class TestDate {
  QrDetails getTestData() {
    return QrDetails(
        isMultiplePass: false,
        visitorType: "Friend",
        visitorName: "Abaza",
        qr: ImagePaths.qrImageIcon,
        visitDays: "Sunday , Monday , Tuesday",
        expireDate: "30 Aug 2023",
        visitDate: "29 Aug 2023",
        downloadQr: "downloadQr",
        shareQr: "shareQr",
        qrDetailsQuestion: [
          QrDetailsQuestion(
              "Why You Come to The Compound ?", "Answer 1 , Answer 2"),
          QrDetailsQuestion("Prepared Visit Time", "30 Aug 2023"),
          QrDetailsQuestion(
              "Why You Come to The Compound ?", "Answer 1 , Answer 2")
        ]);
  }
}
