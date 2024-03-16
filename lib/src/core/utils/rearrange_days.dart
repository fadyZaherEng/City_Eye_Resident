import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';

List<LookupFile> rearrangeDays(List<LookupFile> days) {
  DateTime currentDate = DateTime.now();
  String currentDay = currentDate.weekday == 7
      ? "Sunday الأحد الاحد"
      : currentDate.weekday == 1
          ? "Monday الاثنين"
          : currentDate.weekday == 2
              ? "Tuesday الثلاثاء"
              : currentDate.weekday == 3
                  ? "Wednesday  الأربعاء الاربعاء"
                  : currentDate.weekday == 4
                      ? "Thursday الخميس"
                      : currentDate.weekday == 5
                          ? "Friday   الجمع الجمعة الجمعه"
                          : "Saturday السبت";

  List<LookupFile> daysAfterCurrent = [];
  List<LookupFile> daysBeforeCurrent = [];

  bool foundCurrentDay = false;

  for (LookupFile file in days) {
    if (currentDay.contains(file.name)) {
      foundCurrentDay = true;
      daysAfterCurrent.add(file);
    } else if (!foundCurrentDay) {
      daysBeforeCurrent.add(file);
    } else {
      daysAfterCurrent.add(file);
    }
  }

  List<LookupFile> rearrangedList = daysAfterCurrent + daysBeforeCurrent;

  return rearrangedList;
}
