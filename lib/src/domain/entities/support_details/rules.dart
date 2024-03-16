import 'package:city_eye/src/domain/entities/support_details/days.dart';
import 'package:city_eye/src/domain/entities/support_details/sles.dart';
import 'package:equatable/equatable.dart';

class Rules extends Equatable {
  final bool canRequestOnSameDay;
  final bool execludeHoliday;
  final bool needAssignApproval;
  final int bufferPerDay;
  final int bufferPerSlot;
  final int maxDays;
  final bool isIncludeTax;
  final bool isIncludeVat;
  final bool isUseCustomeConfigration;
  final bool isDefault;
  final List<Days> days;
  final List<Sles> slEs;

  const Rules({
    this.canRequestOnSameDay = false,
    this.execludeHoliday = false,
    this.needAssignApproval = false,
    this.bufferPerDay = 0,
    this.bufferPerSlot = 0,
    this.maxDays = 0,
    this.isIncludeTax = false,
    this.isIncludeVat = false,
    this.isUseCustomeConfigration = false,
    this.isDefault = false,
    this.days = const [],
    this.slEs = const [],
  });

  @override
  List<Object?> get props => [
        canRequestOnSameDay,
        execludeHoliday,
        needAssignApproval,
        bufferPerDay,
        bufferPerSlot,
        maxDays,
        isIncludeTax,
        isIncludeVat,
        isUseCustomeConfigration,
        isDefault,
        days,
        slEs,
      ];
}
