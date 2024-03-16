import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:intl/intl.dart';

String convertTimestampToDateFormat(String timestamp) {
  if (timestamp.isEmpty) return '';
  DateTime dateTime = DateTime.parse(timestamp);

  String formattedDate = DateFormat('d MMM y').format(dateTime);

  return formattedDate;
}

String convertTimestampToDateIntoFormat(String timestamp) {
  if (timestamp.isEmpty) return '';
  DateTime dateTime = DateTime.parse(timestamp);

  String myFormat =
      GetLanguageUseCase(injector())() == "ar" ? 'd-M-yyyy' : 'yyyy-M-d';

  String formattedDate = DateFormat(myFormat).format(dateTime);

  return formattedDate;
}

String convertTimestampToDateIntoFormatDelegation(String timestamp) {
  if (timestamp.isEmpty) return '';
  DateTime dateTime = DateTime.parse(timestamp);

  String myFormat = "yyyy-M-d";

  String formattedDate = DateFormat(myFormat).format(dateTime);

  return formattedDate;
}
