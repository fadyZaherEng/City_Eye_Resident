part of 'qr_details_bloc.dart';

@immutable
abstract class QrDetailsEvent {}

class GetQrDetailsDataEvent extends QrDetailsEvent {
  final int qrId;

  GetQrDetailsDataEvent({
    required this.qrId,
  });
}

class QrDetailsBackEvent extends QrDetailsEvent {}

class QrDetailsShareQrEvent extends QrDetailsEvent {}

class QrDetailsDownloadQrEvent extends QrDetailsEvent {}
