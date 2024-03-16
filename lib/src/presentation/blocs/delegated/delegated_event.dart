part of 'delegated_bloc.dart';

@immutable
abstract class DelegatedEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class BackDelegatedEvent extends DelegatedEvent {}

class AddDelegatedEvent extends DelegatedEvent {}

class ShowSkeletonEvent extends DelegatedEvent {}

class GetDelegatedDataEvent extends DelegatedEvent {}

class DeactivateEvent extends DelegatedEvent {
  final Delegated delegated;
  final List<Delegated> delegations;

  DeactivateEvent({
    required this.delegated,
    required this.delegations,
  });
}

class EditDelegatedEvent extends DelegatedEvent {
  final Delegated delegated;

  EditDelegatedEvent({
    required this.delegated,
  });
}

class DelegatedCallPhoneNumberEvent extends DelegatedEvent {
  final Delegated delegated;

  DelegatedCallPhoneNumberEvent({
    required this.delegated,
  });
}
