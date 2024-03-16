import 'dart:ui';

import 'package:equatable/equatable.dart';

class History extends Equatable {
  final int id;
  final int gistType;
  final String gistName;
  final String statusName;
  final Color statusColor;
  final String statusDate;
  final String visitDate;
  final String validDate;
  bool isDeactivate;
  final String historyFor;

  History({
    required this.id,
    required this.gistType,
    required this.gistName,
    required this.statusName,
    required this.statusColor,
    required this.statusDate,
    required this.visitDate,
    required this.validDate,
    this.isDeactivate = false,
    required this.historyFor,
  });

  @override
  List<Object?> get props => [
        gistType,
        gistName,
        statusName,
        statusColor,
        statusDate,
        visitDate,
        validDate,
        isDeactivate,
        historyFor,
        id,
      ];
}
