part of 'staff_bloc.dart';

@immutable
abstract class StaffEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(
          this,
        ),
      ];
}

class GetStaffEvent extends StaffEvent {}

class OpenStuffPhoneNumberEvent extends StaffEvent {
  final String phoneNumber;

  OpenStuffPhoneNumberEvent({
    required this.phoneNumber,
  });
}

class NavigationPopEvent extends StaffEvent {}
