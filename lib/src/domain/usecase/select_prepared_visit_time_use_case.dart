import 'package:city_eye/src/domain/entities/support_details/day_times.dart';

class SelectPreparedVisitTimeUseCase {
  List<DayTimes> call(List<DayTimes> preparedVisitTimes,
      DayTimes selectedPreparedVisitTime) {
    for (int i = 0; i < preparedVisitTimes.length; i++) {
      if (preparedVisitTimes[i].id == selectedPreparedVisitTime.id) {
        preparedVisitTimes[i] = preparedVisitTimes[i].copyWith(
          isSelected: !preparedVisitTimes[i].isSelected,
        );
      } else {
        preparedVisitTimes[i] = preparedVisitTimes[i].copyWith(
          isSelected: false,
        );
      }
    }
    return preparedVisitTimes;
  }
}
