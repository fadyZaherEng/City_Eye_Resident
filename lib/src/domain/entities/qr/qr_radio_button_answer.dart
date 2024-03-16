class QrRadioButtonAnswer {
  final int answerId;
  final int questionId;
  final String answerTitle;
  bool isSelected;

  QrRadioButtonAnswer({
    required this.answerId,
    required this.questionId,
    required this.answerTitle,
    this.isSelected = false,
  });
}
