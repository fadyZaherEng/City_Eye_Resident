part of 'delegated_bloc.dart';

@immutable
abstract class DelegatedState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class DelegatedInitialState extends DelegatedState {}

class BackDelegatedState extends DelegatedState {}

class AddDelegatedState extends DelegatedState {}

class ShowSkeletonState extends DelegatedState {}

class ShowLoadingState extends DelegatedState {}

class HideLoadingState extends DelegatedState {}

class GetDelegatedDataSuccessState extends DelegatedState {
  final List<Delegated> delegatedList;

  GetDelegatedDataSuccessState({
    required this.delegatedList,
  });
}

class GetDelegatedDataErrorState extends DelegatedState {
  final String errorMessage;

  GetDelegatedDataErrorState({
    required this.errorMessage,
  });
}

class DeactivateSuccessState extends DelegatedState {
  final Delegated delegated;
  final String message;

  DeactivateSuccessState({
    required this.delegated,
    required this.message,
  });
}

class DeactivateErrorState extends DelegatedState {
  final String errorMessage;

  DeactivateErrorState({
    required this.errorMessage,
  });
}

class EditDelegatedState extends DelegatedState {
  final Delegated delegated;

  EditDelegatedState({
    required this.delegated,
  });
}

class DelegatedCallPhoneNumberState extends DelegatedState {
  final Delegated delegated;

  DelegatedCallPhoneNumberState({
    required this.delegated,
  });
}
