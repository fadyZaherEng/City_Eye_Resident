part of 'staff_bloc.dart';

@immutable
abstract class StaffState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(
          this,
        ),
      ];
}

class StaffInitialState extends StaffState {}

class GetStaffLoadingState extends StaffState {}

class GetStaffSuccessState extends StaffState {
  final List<Staff> staff;

  GetStaffSuccessState({required this.staff});
}

class GetStaffErrorState extends StaffState {
  final String errorMessage;

  GetStaffErrorState({required this.errorMessage});
}

class OpenStaffPhoneNumberState extends StaffState {
  final String phoneNumber;

  OpenStaffPhoneNumberState({required this.phoneNumber});
}

class NavigationPopState extends StaffState {}
