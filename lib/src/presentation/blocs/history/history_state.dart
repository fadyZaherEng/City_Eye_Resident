part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class HistoryInitialState extends HistoryState {}

class CurrentQrHistoryLoadingState extends HistoryState {}

class CurrentQrHistorySuccessState extends HistoryState {
  final List<QrHistory> history;

  CurrentQrHistorySuccessState({
    required this.history,
  });
}

class CurrentQrHistoryErrorState extends HistoryState {
  final String errorMessage;

  CurrentQrHistoryErrorState({
    required this.errorMessage,
  });
}

class PreviousQrHistoryLoadingState extends HistoryState {}

class PreviousQrHistorySuccessState extends HistoryState {
  final List<QrHistory> history;

  PreviousQrHistorySuccessState({
    required this.history,
  });
}

class PreviousQrHistoryErrorState extends HistoryState {
  final String errorMessage;

  PreviousQrHistoryErrorState({
    required this.errorMessage,
  });
}

class HistorySearchState extends HistoryState {
  final List<QrHistory> history;

  HistorySearchState({
    required this.history,
  });
}

class HistoryDeactivateSuccessState extends HistoryState {
  final List<QrHistory> history;
  final String successMessage;

  HistoryDeactivateSuccessState({
    required this.history,
    required this.successMessage,
  });
}

class HistoryDeactivateErrorState extends HistoryState {
  final String errorMessage;

  HistoryDeactivateErrorState({
    required this.errorMessage,
  });
}

class HistoryActivateSuccessState extends HistoryState {
  final List<QrHistory> history;
  final String successMessage;

  HistoryActivateSuccessState({
    required this.history,
    required this.successMessage,
  });
}

class HistoryActivateErrorState extends HistoryState {
  final String errorMessage;

  HistoryActivateErrorState({
    required this.errorMessage,
  });
}

class HistoryBackState extends HistoryState {}

class SelectQrTypeState extends HistoryState {
  final int qrType;

  SelectQrTypeState({required this.qrType});
}

class ShowLoadingDialogState extends HistoryState {}
