import 'package:equatable/equatable.dart';

class CreateQrResponse extends Equatable {
  final int qrId;
  final String qrImage;
  final String qrPdf;

  const CreateQrResponse({
    this.qrId = 0,
    this.qrImage = "",
    this.qrPdf = "",
  });

  @override
  List<Object?> get props => [qrId, qrImage, qrPdf];
}
