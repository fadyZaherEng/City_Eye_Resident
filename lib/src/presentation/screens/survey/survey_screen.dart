import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:city_eye/src/presentation/blocs/survey/survey_bloc.dart';
import 'package:city_eye/src/presentation/blocs/survey/survey_event.dart';
import 'package:city_eye/src/presentation/blocs/survey/survey_state.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/survey_item_widget.dart';
import 'package:city_eye/src/presentation/screens/survey/skeleton/skeleton_survey_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurveyScreen extends BaseStatefulWidget {
  final int id;

  const SurveyScreen({this.id = -1, Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _SurveyScreenState();
}

class _SurveyScreenState extends BaseState<SurveyScreen> {
  SurveyBloc get _bloc => BlocProvider.of<SurveyBloc>(context);

  List<Survey> _surveys = [];

  TextEditingController surveyInformationEditingController =
      TextEditingController();

  Color borderColor = ColorSchemes.primary;
  var itemCount = 0;
  var _key;
  Timer? _timer;

  @override
  void initState() {
    _bloc.add(GetSurveysDataEvent());
    super.initState();
  }

  Future<void> _handleRefresh() async {
    _bloc.add(GetSurveysDataEvent());
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(context,
          title: S.of(context).surveys,
          isHaveBackButton: true, onBackButtonPressed: () {
        _popBackEvent();
      }),
      body: BlocConsumer<SurveyBloc, SurveyState>(
        listener: (context, state) {
          if (state is ShowLoadingState) {
            showLoading();
          } else if (state is HideLoadingState) {
            hideLoading();
          } else if (state is UpdateSurveyActionState) {
            _surveys = state.surveys;
          } else if (state is SurveyPopBackState) {
            Navigator.pop(context, _surveys);
          } else if (state is SubmitSurveySuccessState) {
            _surveys = state.survey;
          } else if (state is SubmitSurveyFailedState) {
            showSnackBar(
                context: context,
                message: state.errorMessage,
                color: ColorSchemes.snackBarError,
                icon: ImagePaths.error,
            );
          } else if (state is GetSurveyDataSuccessState) {
            _surveys = state.surveys;
          } else if (state is GetSurveyDataFailedState) {
            showSnackBar(
              context: context,
              message: state.errorMessage,
              color: ColorSchemes.snackBarError,
              icon: ImagePaths.error,
            );
          } else if (state is ScrollToItemState) {
            _scrollToIndex(state.key);
            getColor();
          }
        },
        builder: (context, state) {
          if (state is ShowSurveySkeletonState) {
            return Container(
                margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
                child: const SkeletonSurveyWidget());
          } else {
            return WillPopScope(
              onWillPop: () {
                Navigator.pop(context, _surveys);
                return Future.value(true);
              },
              child: _surveys.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () => _handleRefresh(),
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ListView.builder(
                              itemCount: _surveys.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                itemCount++;
                                if (widget.id != -1 &&
                                    _surveys[index].id == widget.id) {
                                  _key = _surveys[index].key;
                                }
                                if (itemCount <= _surveys.length &&
                                    _key != null) {
                                  _bloc.add(ScrollToItemEvent(key: _key));
                                }
                                return Column(
                                  children: [
                                    Padding(
                                      key: _surveys[index].key,
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 16, left: 16),
                                      child: SurveyItemWidget(
                                        survey: _surveys[index],
                                        borderColor:
                                            _surveys[index].id == widget.id &&
                                                    _key != null
                                                ? borderColor
                                                : ColorSchemes.white,
                                        textEditingController:
                                            surveyInformationEditingController,
                                        onSelectAction: (survey, surveyAction) {
                                          _selectSurveyActionEvent(
                                              survey: survey,
                                              surveyAction: surveyAction);
                                        },
                                        onChange: (value) {},
                                        boxShadows: const [
                                          BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.12),
                                              offset: Offset(0, 4),
                                              blurRadius: 32,
                                              spreadRadius: 0)
                                        ],
                                        width: double.infinity,
                                        onSendAction: (survey) {
                                          _sendSurveyActionEvent(
                                              survey: survey);
                                        },
                                        selectedSurveyAction:
                                            _surveys[index].selectAction,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                );
                              })),
                    )
                  : CustomEmptyListWidget(
                    imagePath: ImagePaths.emptySurveysHome,
                    text: S.of(context).noSurveys,
                    onRefresh: () => _handleRefresh(),
                  ),
            );
          }
        },
      ),
    );
  }

  void _popBackEvent() {
    _bloc.add(SurveyPopBackEvent());
  }

  void _selectSurveyActionEvent(
      {required Survey survey, required SurveyQuestionChoice surveyAction}) {
    _bloc.add(
        SelectSurveyActionEvent(survey: survey, surveyAction: surveyAction));
  }

  void _sendSurveyActionEvent({required Survey survey}) {
    _bloc.add(SendSurveyNeededInformationEvent(
        survey: survey,
        surveyNeededInformation: surveyInformationEditingController.text));
  }

  Future<void> _scrollToIndex(GlobalKey key) async {
    Future.delayed(const Duration(milliseconds: 300));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  getColor() {
    _timer = Timer(const Duration(seconds: 2), () {
      borderColor = ColorSchemes.white;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
