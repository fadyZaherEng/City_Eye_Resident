import 'package:city_eye/src/domain/entities/qr/day.dart';
import 'package:city_eye/src/domain/entities/qr/holiday.dart';
import 'package:city_eye/src/domain/entities/qr/qrs_type.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:equatable/equatable.dart';

class GuestsType extends Equatable {
  final int id;
  final String name;
  final String code;
  final bool isHoliday;
  final bool isWeekend;
  final bool isRestricted;
  final List<PageField> questions;
  final List<QrsType> qrTypes;
  final List<Day> days;
  final String rules;
  final String qrPeriodRequest;
  final bool iseSelected;

  const GuestsType({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.isHoliday = false,
    this.isWeekend = false,
    this.isRestricted = false,
    this.questions = const [],
    this.qrTypes = const [],
    this.days = const [],
    this.rules = "",
    this.qrPeriodRequest = "",
    this.iseSelected = false,
  });

  GuestsType copyWith({
    int? id,
    String? name,
    String? code,
    bool? isHoliday,
    bool? isWeekend,
    bool? isRestricted,
    List<PageField>? questions,
    List<QrsType>? qrTypes,
    List<Day>? days,
    String? rules,
    String? qrPeriodRequest,
    bool? iseSelected,
  }) {
    return GuestsType(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      isHoliday: isHoliday ?? this.isHoliday,
      isWeekend: isWeekend ?? this.isWeekend,
      isRestricted: isRestricted ?? this.isRestricted,
      questions: questions ?? this.questions,
      qrTypes: qrTypes ?? this.qrTypes,
      days: days ?? this.days,
      rules: rules ?? this.rules,
      qrPeriodRequest: qrPeriodRequest ?? this.qrPeriodRequest,
      iseSelected: iseSelected ?? this.iseSelected,
    );
  }

  GuestsType deepClone() {
    return GuestsType(
      id: id,
      name: name,
      code: code,
      isHoliday: isHoliday,
      isWeekend: isWeekend,
      isRestricted: isRestricted,
      questions: questions.map((e) => e.deepClone()).toList(),
      qrTypes: qrTypes.map((e) => e.deepClone()).toList(),
      days: days.map((e) => e.deepClone()).toList(),
      rules: rules,
      qrPeriodRequest: qrPeriodRequest,
      iseSelected: iseSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        isHoliday,
        isWeekend,
        isRestricted,
        questions,
        qrTypes,
        days,
        rules,
        qrPeriodRequest,
        iseSelected,
      ];
}
