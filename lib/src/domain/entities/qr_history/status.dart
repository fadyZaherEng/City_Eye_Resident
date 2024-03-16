import 'package:city_eye/src/domain/entities/qr_history/type_qr_history.dart';

final class StatusQrHistory extends TypeQrHistory {
  final String color;

  const StatusQrHistory({
    super.id = 0,
    super.code = "",
    super.name = "",
    this.color = "",
  });

  @override
  List<Object> get props => [color];
}
