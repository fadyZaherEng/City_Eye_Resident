import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_page_field.dart';
import 'package:city_eye/src/domain/entities/profile/info.dart';
import 'package:city_eye/src/domain/entities/qr/qr_radio_button_answer.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_choice.g.dart';

@JsonSerializable()
class RemoteChoice {
  @JsonKey(name: 'optionId')
  final int? optionId;
  @JsonKey(name: 'optionValue')
  final String? optionValue;

  const RemoteChoice({
    this.optionId = 0,
    this.optionValue = "",
  });


  factory RemoteChoice.fromJson(Map<String, dynamic> json) =>
      _$RemoteChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteChoiceToJson(this);
}

extension RemoteChoiceExtension on RemoteChoice {
  Choice mapToDomain() {
    return Choice(
      id: optionId ?? 0,
      value: optionValue ?? "",
      isSelected: false,
    );
  }
}

extension RemoteChoiceListExtension on List<RemoteChoice>? {
  List<Choice> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}


extension RemoteRadioAnswerExtension on RemoteChoice {
  QrRadioButtonAnswer mapToQrRadioButtonAnswer(int questionId) {
    return QrRadioButtonAnswer(
      answerId: optionId ?? 0,
      answerTitle: optionValue ?? "",
      questionId: questionId,
      isSelected: false,
    );
  }
}

extension RemoteRadioAnswersExtension on List<RemoteChoice>? {
  List<QrRadioButtonAnswer> mapToQrRadioButtonAnswers(int questionId) {
    return this?.map((e) => e.mapToQrRadioButtonAnswer(questionId)).toList() ?? [];
  }
}
