import 'package:city_eye/src/domain/entities/staff/staff_job_type.dart';
import 'package:equatable/equatable.dart';

class Staff extends Equatable {
  final int id;
  final String name;
  final String mobile;
  final String workingHours;
  final StaffJobType staffJobType;
  final String image;

  const Staff({
    this.id = 0,
    this.name = "",
    this.workingHours = "",
    this.mobile = "",
    this.image = "",
    this.staffJobType = const StaffJobType(),
  });

  @override
  List<Object> get props => [
        id,
        name,
        mobile,
        workingHours,
        staffJobType,
        image,
      ];
}
