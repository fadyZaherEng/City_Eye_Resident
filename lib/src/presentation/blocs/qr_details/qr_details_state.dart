part of 'qr_details_bloc.dart';

@immutable
abstract class QrDetailsState {}

class QrDetailsInitial extends QrDetailsState {}

class QrDetailsBackState extends QrDetailsState {}

class QrDetailsShowSkeletonState extends QrDetailsState {}

class SuccessGetQrDetailsDataState extends QrDetailsState {
  final QrHistoryWithQuestionAnswer qrDetails;

  SuccessGetQrDetailsDataState(this.qrDetails);
}
class ErrorGetQrDetailsDataState extends QrDetailsState {
  final String errorMessage;

  ErrorGetQrDetailsDataState(this.errorMessage);
}
class QrDetailsShareQrState extends QrDetailsState {}

class QrDetailsDownloadQrState extends QrDetailsState {}
