import 'package:city_eye/src/core/utils/convert_string_to_date_format.dart';
import 'package:city_eye/src/domain/entities/gallery/sort.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';

class SortEventsUseCase {
  List<HomeEventItem> call(List<HomeEventItem> events, Sort sort) {
    List<HomeEventItem> sortedEvents = [];
    switch (sort.id) {
      case 1:
        sortedEvents = events
          ..sort((a, b) => convertStringToDateFormat(b.endDate).compareTo(
                convertStringToDateFormat(a.endDate),
              ));
        break;
      case 2:
        sortedEvents = events
          ..sort((a, b) => convertStringToDateFormat(a.endDate).compareTo(
                convertStringToDateFormat(b.endDate),
              ));
        break;
      case 3:
        sortedEvents = events..sort((a, b) => a.memberPrice.compareTo(b.memberPrice));
        break;
      case 4:
        sortedEvents = events..sort((a, b) => b.memberPrice.compareTo(a.memberPrice));
        break;
    }

    return sortedEvents;
  }
}
