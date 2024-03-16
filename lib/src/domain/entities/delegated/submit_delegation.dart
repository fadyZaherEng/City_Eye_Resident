import 'package:equatable/equatable.dart';

class SubmitDelegation extends Equatable {
  final String link;
  final String qrImage;
  final int pinCode;

  const SubmitDelegation({
    this.link = "",
    this.qrImage = "",
    this.pinCode = 0,
  });

  @override
  List<Object?> get props => [
        link,
        qrImage,
        pinCode,
      ];
}
