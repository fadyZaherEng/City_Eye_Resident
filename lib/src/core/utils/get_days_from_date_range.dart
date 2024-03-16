import 'package:intl/intl.dart';

List<String> getDayNamesInDateRange(DateTime startDate, DateTime endDate) {
  List<String> dayNames = [];

  for (var date = startDate;
      date.isBefore(endDate.add(const Duration(days: 1))) || date.isAtSameMomentAs(endDate.add(const Duration(days: 1)));
      date = date.add(const Duration(days: 1))) {
    String dayName = DateFormat('EEEE').format(date);

    dayNames.add(dayName.replaceAll("أ", "ا"));
  }

  return dayNames;
}
