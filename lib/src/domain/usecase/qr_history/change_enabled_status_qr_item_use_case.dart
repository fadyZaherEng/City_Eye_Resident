import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';

final class ChangeEnabledStatusQrItemUseCase {
  List<QrHistory> call(List<QrHistory> qrHistory, QrHistory changeQrHistory) {
    for (int i = 0; i < qrHistory.length; i++) {
      if (qrHistory[i].id == changeQrHistory.id) {
        if (qrHistory[i].isEnabled == true) {
          qrHistory[i] = qrHistory[i].copyWith(
            isEnabled: false,
          );
        } else {
          qrHistory[i] = qrHistory[i].copyWith(
            isEnabled: true,
          );
        }
        break;
      }
    }
    return qrHistory;
  }
}
