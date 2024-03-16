part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class GetCurrentHistoryEvent extends HistoryEvent {
  final String searchValue;

  GetCurrentHistoryEvent({
    required this.searchValue,
  });
}

class GetPreviousHistoryEvent extends HistoryEvent {
  final String searchValue;

  GetPreviousHistoryEvent({
    required this.searchValue,
  });
}

class QrHistorySearchEvent extends HistoryEvent {
  final String searchValue;

  QrHistorySearchEvent({
    required this.searchValue,
  });
}

class HistoryDeactivateEvent extends HistoryEvent {
  final QrHistory history;
  final int index;

  HistoryDeactivateEvent({
    required this.history,
    required this.index,
  });
}
class HistoryActivateEvent extends HistoryEvent {
  final QrHistory history;
  final int index;

  HistoryActivateEvent({
    required this.history,
    required this.index,
  });
}

class HistoryBackEvent extends HistoryEvent {}

class SelectQrTypeEvent extends HistoryEvent {
  final int qrType;

  SelectQrTypeEvent({required this.qrType});
}
