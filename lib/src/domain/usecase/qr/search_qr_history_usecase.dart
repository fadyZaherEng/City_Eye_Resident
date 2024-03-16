import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';

class SearchQrHistoryUseCase {
  List<QrHistory> call(List<QrHistory> qrHistories, String value) {
    return qrHistories.where((element) {
      return element.qrType.name.toLowerCase().contains(value.toLowerCase()) ||
          element.name.toLowerCase().contains(value.toLowerCase()) ||
          element.guestType.name.toLowerCase().contains(value.toLowerCase());
    }).toList();
  }
}
