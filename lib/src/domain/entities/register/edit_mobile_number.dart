import 'package:equatable/equatable.dart';

class EditMobileNumber extends Equatable {
  final String newOTPnumber;
  final String expireDate;

  const EditMobileNumber({
    this.newOTPnumber = "",
    this.expireDate = "",
  });

  @override
  List<Object?> get props => [newOTPnumber, expireDate];
}
