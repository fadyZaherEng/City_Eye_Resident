import 'package:city_eye/src/domain/entities/qr_history/guest_type.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history_with_questions_answer.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_type.dart';
import 'package:city_eye/src/domain/entities/qr_history/status.dart';
import 'package:city_eye/src/domain/entities/qr_history/unit_qr_code_day.dart';
import 'package:city_eye/src/domain/entities/qr_history/unit_qr_question_answer.dart';
import 'package:equatable/equatable.dart';

class QrDetails extends Equatable {
  final bool isValid;
  final QrHistoryWithQuestionAnswer qrHistoryWithQuestionAnswer;

  const QrDetails({
    this.isValid = false,
    this.qrHistoryWithQuestionAnswer = const QrHistoryWithQuestionAnswer(),
  });

  @override
  List<Object> get props => [
        isValid,
        qrHistoryWithQuestionAnswer,
  ];

  QrDetails copyWith({
    bool? isValid,
    QrHistoryWithQuestionAnswer? qrHistoryWithQuestionAnswer,
  }) {
    return QrDetails(
      isValid: isValid ?? this.isValid,
      qrHistoryWithQuestionAnswer:
          qrHistoryWithQuestionAnswer ?? this.qrHistoryWithQuestionAnswer,
    );
  }
}
