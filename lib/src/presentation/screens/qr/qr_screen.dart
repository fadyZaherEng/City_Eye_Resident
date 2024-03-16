import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/android_date_picker.dart';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:city_eye/src/core/utils/ios_date_picker.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_searchable_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/entities/qr/day.dart';
import 'package:city_eye/src/domain/entities/qr/day_time.dart';
import 'package:city_eye/src/domain/entities/qr/guests_type.dart';
import 'package:city_eye/src/domain/entities/qr/qr_configuration.dart';
import 'package:city_eye/src/domain/entities/qr/qrs_type.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/get_qr_code_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_qr_code_index_use_case.dart';
import 'package:city_eye/src/presentation/blocs/qr_configuration/qr_configuration_bloc.dart';
import 'package:city_eye/src/presentation/screens/qr/create_qr_screen.dart';
import 'package:city_eye/src/presentation/screens/qr/qr_history_screen.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_tap_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/web_view_html_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class QrScreen extends BaseStatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _QrScreenState();
}

class _QrScreenState extends BaseState<QrScreen>
    with SingleTickerProviderStateMixin {
  QrConfigurationBloc get _bloc =>
      BlocProvider.of<QrConfigurationBloc>(context);

  //QrVariables
  int _currentIndex = 0;
  late TabController _tabController;
  bool isShowDiscardDialog = false;

  //Create Qr Variables
  final TextEditingController _selectDateController = TextEditingController();
  final TextEditingController _visitorNameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  DateTime? _selectedDate;
  QrConfiguration _qrConfiguration = const QrConfiguration();
  GuestsType _guestsType = const GuestsType();
  QrsType _qrsType = const QrsType();
  List<PageField> _questions = [];
  bool _showCreateQrSkeleton = true;
  QrErrorMessages _qrErrorMessages = QrErrorMessages(
    dateKey: GlobalKey(),
    daysKey: GlobalKey(),
    timeKey: GlobalKey(),
    visitorKey: GlobalKey(),
  );

  //Single QR
  List<DayTime> singleQrAvailableTimes = [];

  //Multiple QR
  List<Day> multipleQrAvailableDays = [];
  List<Day> multipleQrOrderedSelectedDays = [];

  //History Qr Variables
  final TextEditingController _searchController = TextEditingController();
  List<QrHistory> _qrHistories = [];
  int _historyQrType = 1;
  bool _showQrHistorySkeleton = true;

  DateTime firstDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    super.initState();
    _historyQrType =
        int.parse(GetQrCodeIndexUseCase(injector())().last) == 0 ? 1 : 2;
    _tabController = TabController(length: 2, vsync: this);
    // _selectDateController.text = _selectedDate.toString().split(" ")[0];
    _tabController.index =
        int.parse(GetQrCodeIndexUseCase(injector())()[1]) == 1 ? 1 : 0;
    _currentIndex = _tabController.index;

    _bloc.add(GetQrConfigurationEvent());
    if (int.parse(GetQrCodeIndexUseCase(injector())()[1]) != 0) {
      _getQrHistoryEvent();
    }
  }

  @override
  void deactivate() async {
    await SetQrCodeIndexUseCase(injector())(["0", "0", "0"]);
    super.deactivate();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<QrConfigurationBloc, QrConfigurationState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is NavigateBackState) {
          Navigator.of(context).pop();
        } else if (state is SwitchQrTabsState) {
          _historyQrType = 1;
          if (_currentIndex != 1 && _currentIndex != state.index) {
            _getQrHistoryEvent();
          }
          _currentIndex = state.index;
        } else if (state is ShowHistorySkeletonState) {
          _showQrHistorySkeleton = true;
        } else if (state is HideHistorySkeletonState) {
          _showQrHistorySkeleton = false;
        } else if (state is SwitchHistoryTabsState) {
          _historyQrType = state.historyQrType;
          _getQrHistoryEvent();
        } else if (state is GetQrHistorySuccessState) {
          _qrHistories = state.history;
          _bloc.add(QrHistorySearchEvent(
              qrHistories: _qrHistories, value: _searchController.text.trim()));
        } else if (state is GetQrHistoryErrorState) {
          _showMessageDialog(
            message: state.message,
            icon: ImagePaths.error,
            onTab: () {
              _navigateBackEvent();
            },
          );
        } else if (state is QrHistorySearchState) {
          _qrHistories = state.history;
        } else if (state is ChangeQrActivationStatusSuccessState) {
          _qrHistories = state.history;
        } else if (state is ChangeQrActivationStatusErrorState) {
          _showMessageDialog(
            message: state.message,
            icon: ImagePaths.error,
            onTab: () {
              _navigateBackEvent();
            },
          );
        } else if (state is ShowCreateQrSkeleton) {
          _showCreateQrSkeleton = true;
        } else if (state is HideCreateQrSkeleton) {
          _showCreateQrSkeleton = false;
        } else if (state is GetQrConfigurationSuccessState) {
          _qrConfiguration = state.qrConfiguration;
          _guestsType = _qrConfiguration.guestsTypes[0].deepClone();
          _qrsType = _guestsType.qrTypes[0].deepClone();
          _questions = _qrConfiguration.guestsTypes[0].questions
              .map((e) => e.deepClone())
              .toList();
        } else if (state is GetQrConfigurationErrorState) {
          _showMessageDialog(
            message: state.message,
            icon: ImagePaths.error,
            onTab: () {
              _navigateBackEvent();
            },
          );
        } else if (state is SelectGuestTypeState) {
          isShowDiscardDialog = false;
          _qrErrorMessages.dateErrorMessage = null;
          _qrErrorMessages.daysErrorMessage = null;
          _qrErrorMessages.timeErrorMessage = null;
          _qrErrorMessages.visitorNameErrorMessage = null;
          _guestsType = state.guestsType;
          _qrsType = _guestsType.qrTypes[0].deepClone();
          _questions = _guestsType.questions.map((e) => e.deepClone()).toList();
          _selectDateController.text = "";
          _selectedDate = null;
          _visitorNameController.text = "";
          singleQrAvailableTimes = [];
          multipleQrAvailableDays = [];
          multipleQrOrderedSelectedDays = [];
        } else if (state is SelectQrTypeState) {
          isShowDiscardDialog = true;
          _qrErrorMessages.timeErrorMessage = null;
          _qrErrorMessages.daysErrorMessage = null;
          _qrsType = state.qrsType;

          if (_selectedDate != null) {
            //if date not equal and QR is Single we should get the available times for the selected date
            singleQrAvailableTimes =
                getDayAvailableTimes(getDayNameFromDate(_selectedDate));
            //if date not equal and QR is Multiple we should get the available days for the selected date
            multipleQrAvailableDays =
                getDaysInRange(DateTime.now(), _selectedDate ?? DateTime.now());
            for (int i = 0; i < multipleQrAvailableDays.length; i++) {
              for (int j = 0;
                  j < multipleQrAvailableDays[i].times.length;
                  j++) {
                multipleQrAvailableDays[i].times[j] = multipleQrAvailableDays[i]
                    .times[j]
                    .copyWith(isSelected: false);
              }
            }
            for (int j = 0; j < singleQrAvailableTimes.length; j++) {
              if (singleQrAvailableTimes[j].isSelected) {
                singleQrAvailableTimes[j] =
                    singleQrAvailableTimes[j].copyWith(isSelected: false);
              }
            }
            multipleQrOrderedSelectedDays = [];
          }
        } else if (state is AnswerQuestionState) {
          isShowDiscardDialog = true;
          _questions = state.questions;
        } else if (state is SelectImageQuestionState) {
          _showMediaBottomSheet(
            questions: state.questions,
            question: state.question,
          );
        } else if (state is DeleteImageQuestionState) {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBackEvent();
              _deleteAnswerQuestionEvent(
                state.questions,
                state.question,
              );
            },
            onSecondaryAction: () {
              _navigateBackEvent();
            },
            primaryText: S.of(context).yes,
            secondaryText: S.of(context).no,
            text: S.of(context).areYouSureYouWantToDeleteThisImage,
          );
        } else if (state is ShowSearchableBottomSheetState) {
          _openSearchableBottomSheet(
            state.questions,
            state.question,
            state.isMultiChoice,
          );
        } else if (state is OpenRulesBottomSheetState) {
          showRulesBottomSheet();
        } else if (state is OpenDatePickerState) {
          _openDatePicker(state.onDateSelected);
        } else if (state is SelectDateState) {
          _selectedDate = state.dateTime;
          //When Select a new Date We Reset All Errors
          _qrErrorMessages.dateErrorMessage = null;
          _qrErrorMessages.timeErrorMessage = null;
          _qrErrorMessages.daysErrorMessage = null;

          //if Qr Single We Should Get The Day Name From The Selected Date
          //Then Get The Time When Matching the day with days list in the guests type
          //Then display all the times avaialble
          singleQrAvailableTimes =
              getDayAvailableTimes(getDayNameFromDate(_selectedDate));
          multipleQrAvailableDays =
              getDaysInRange(firstDate, _selectedDate ?? DateTime.now());
          for (int i = 0; i < multipleQrAvailableDays.length; i++) {
            for (int j = 0; j < multipleQrAvailableDays[i].times.length; j++) {
              multipleQrAvailableDays[i].times[j] = multipleQrAvailableDays[i]
                  .times[j]
                  .copyWith(isSelected: false);
            }
          }
          multipleQrOrderedSelectedDays = [];
        } else if (state is DeleteDateState) {
          _selectDateController.text = "";
          _selectedDate = null;
          _qrErrorMessages.dateErrorMessage = S.of(context).thisFieldIsRequired;
          _qrErrorMessages.timeErrorMessage = null;
          _qrErrorMessages.daysErrorMessage = null;
          multipleQrAvailableDays = [];
          singleQrAvailableTimes = [];
          multipleQrOrderedSelectedDays = [];
        } else if (state is SelectSingleQRTimeState) {
          isShowDiscardDialog = true;
          _qrErrorMessages.timeErrorMessage = null;
          singleQrAvailableTimes = state.availableTimes;
        } else if (state is SelectMultipleQRTimeState) {
          isShowDiscardDialog = true;
          _qrErrorMessages.timeErrorMessage = null;
          multipleQrOrderedSelectedDays = state.multipleQrOrderedDays;
        } else if (state is SelectDayState) {
          isShowDiscardDialog = true;
          multipleQrAvailableDays = state.days;
          _qrErrorMessages = state.qrErrorMessages;
          if (state.selectedDay.isSelected) {
            multipleQrOrderedSelectedDays.add(state.selectedDay);
          } else {
            multipleQrOrderedSelectedDays
                .removeWhere((element) => element.id == state.selectedDay.id);
          }
          if (multipleQrOrderedSelectedDays.isEmpty) {
            _qrErrorMessages.daysErrorMessage =
                S.of(context).thisFieldIsRequired;
          } else {
            _qrErrorMessages.daysErrorMessage = null;
          }
        } else if (state is CreateQrSuccessState) {
          Navigator.pushReplacementNamed(
            context,
            Routes.qrDetailsScreen,
            arguments: {
              "qrId": state.createQrResponse.qrId,
            },
          );
        } else if (state is CreateQrErrorState) {
          _showMessageDialog(
              message: state.message,
              icon: ImagePaths.error,
              onTab: () {
                _navigateBackEvent();
              });
        } else if (state is QrValidationErrorState) {
          _qrErrorMessages = state.qrErrorMessages;
          _questions = state.questions;
          _scrollToFirstErrorSection(_qrErrorMessages, _questions);
        } else if (state is ValidateVisitorNameState) {
          isShowDiscardDialog = true;
          if (_visitorNameController.text.trim().isEmpty) {
            _qrErrorMessages.visitorNameErrorMessage =
                S.of(context).thisFieldIsRequired;
          } else {
            List<String> words = _visitorNameController.text.trim().split(' ');
            if (words.length < 2 || words.any((word) => word.length < 2)) {
              _qrErrorMessages.visitorNameErrorMessage =
                  S.of(context).enterTwoWordsEachWordContains2Characters;
            } else {
              _qrErrorMessages.visitorNameErrorMessage = null;
            }
          }
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (isShowDiscardDialog == false) {
              _navigateBackEvent();
            } else {
              _showActionDialog(
                icon: ImagePaths.warning,
                onPrimaryAction: () {
                  _navigateBackEvent();
                  _navigateBackEvent();
                },
                onSecondaryAction: () {
                  _navigateBackEvent();
                },
                primaryText: S.of(context).discard,
                secondaryText: S.of(context).keep,
                text: S.of(context).allChangesWillBeLostIfYouLeaveThisPage,
              );
            }
            return false;
          },
          child: Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: S.of(context).qrCodeTitle,
              isHaveBackButton: true,
              onBackButtonPressed: () {
                if (isShowDiscardDialog == false) {
                  _navigateBackEvent();
                } else {
                  _showActionDialog(
                    icon: ImagePaths.warning,
                    onPrimaryAction: () {
                      _navigateBackEvent();
                      _navigateBackEvent();
                    },
                    onSecondaryAction: () {
                      _navigateBackEvent();
                    },
                    primaryText: S.of(context).discard,
                    secondaryText: S.of(context).keep,
                    text: S.of(context).allChangesWillBeLostIfYouLeaveThisPage,
                  );
                }
              },
            ),
            body: CustomTabBarWidget(
              contentOfTapOne: CreateQRScreen(
                qrConfiguration: _qrConfiguration,
                showSkeleton: _showCreateQrSkeleton,
                guestsType: _guestsType,
                qrsType: _qrsType,
                questions: _questions,
                scrollController: _scrollController,
                selectDateController: _selectDateController,
                visitorNameController: _visitorNameController,
                selectedDate: _selectedDate,
                qrErrorMessages: _qrErrorMessages,
                selectGuestType: (guestsType) {
                  if (_guestsType.id == guestsType.id) return;
                  if (isShowDiscardDialog == false) {
                    _selectGuestTypeEvent(guestsType);
                  } else {
                    _showActionDialog(
                      icon: ImagePaths.warning,
                      onPrimaryAction: () {
                        _navigateBackEvent();
                        _selectGuestTypeEvent(guestsType);
                      },
                      onSecondaryAction: () {
                        _navigateBackEvent();
                      },
                      primaryText: S.of(context).discard,
                      secondaryText: S.of(context).keep,
                      text:
                          S.of(context).allChangesWillBeLostIfYouLeaveThisPage,
                    );
                  }
                },
                selectQrsType: (qrsType) {
                  _selectQrTypeEvent(qrsType);
                },
                onValidateVisitorName: () {
                  _bloc.add(ValidateVisitorNameEvent());
                },
                selectSingleAnswer: (questions, question, answerId) {
                  _selectSingleSelectionAnswerEvent(
                    questions,
                    question,
                    answerId,
                  );
                },
                selectMultipleAnswer: (questions, question, answerId) {
                  _selectMultipleAnswerEvent(
                    questions,
                    question,
                    answerId,
                  );
                },
                answerQuestion: (questions, question, answer) {
                  _answerQuestionEvent(
                    questions,
                    question,
                    answer,
                  );
                },
                deleteAnswer: (questions, question) {
                  _deleteAnswerQuestionEvent(
                    questions,
                    question,
                  );
                },
                selectImage: (questions, question) {
                  _selectImageQuestion(
                    questions,
                    question,
                  );
                },
                deleteImage: (questions, question) {
                  _deleteImageQuestion(
                    questions,
                    question,
                  );
                },
                openSearchableQuestion: (questions, question) {
                  _showSearchableBottomSheetEvent(
                    questions,
                    question,
                  );
                },
                openRulesBottomSheet: () {
                  _openRulesBottomSheetEvent();
                },
                onCreateQR: (questions) {
                  _bloc.add(
                    CreateQrEvent(
                      guestsType: _guestsType,
                      qrsType: _qrsType,
                      questions: questions,
                      selectedDate: _selectedDate,
                      firstDate: firstDate,
                      visitorName:
                          _visitorNameController.text.trim().toString(),
                      days: multipleQrOrderedSelectedDays,
                      availableTimes: singleQrAvailableTimes,
                      qrErrorMessages: _qrErrorMessages,
                    ),
                  );
                },
                onSelectDate: () {
                  _bloc.add(OpenDatePickerEvent(onDateSelected: (selectedDate) {
                    /*if (isDateHoliday(selectedDate!)) {
                      showToastMessage(S
                          .of(context)
                          .sorryThereAreNoAvailableTimesOnThisDayPleaseChoose);
                      _selectDateController.text = "";
                    } else if (isWeekEnd(selectedDate) &&
                        _qrsType.code == QRType.single.name) {
                      showToastMessage(
                          "${S.of(context).sorry} ${_guestsType.name} ${S.of(context).entryNotAllowedDuringCommunityVacationKindlyChooseAnotherDate}");
                      _selectDateController.text = "";
                    } else */
                    if (getDayAvailableTimes(getDayNameFromDate(selectedDate))
                            .isEmpty &&
                        _qrsType.code == QRType.single.name) {
                      showSnackBar(
                        context: context,
                        message: S
                            .of(context)
                            .sorryThereAreNoAvailableTimesOnThisDayPleaseChoose,
                        color: ColorSchemes.snackBarWarning,
                        icon: ImagePaths.warning,
                      );
                      _selectDateController.text = "";
                      _bloc.add(DeleteDateEvent());
                    } else {
                      if (selectedDate == _selectedDate) return;
                      _bloc.add(SelectDateEvent(selectedDate: selectedDate));
                    }
                  }));
                },
                onDeleteDate: () {
                  _bloc.add(DeleteDateEvent());
                },
                singleQrAvailableTimes: singleQrAvailableTimes,
                onSelectSingleQrTime: (dayTimes, dayTime) {
                  _bloc.add(SelectSingleQRTimeEvent(
                    dayTimes: singleQrAvailableTimes,
                    selectedTime: dayTime,
                  ));
                },
                multipleQrAvailableDays: multipleQrAvailableDays,
                onSelectMultipleQrDays: (days, day) {
                  _bloc.add(SelectDayEvent(
                    days: multipleQrAvailableDays,
                    selectedDay: day,
                    qrErrorMessages: _qrErrorMessages,
                  ));
                },
                multipleQrOrderedSelectedDays: multipleQrOrderedSelectedDays,
                onSelectMultipleQrTime: (days, day, dayTime) {
                  _bloc.add(SelectMultipleQRTimeEvent(
                    days: days,
                    selectedDay: day,
                    selectedTime: dayTime,
                  ));
                },
              ),
              contentOfTapTwo: QrHistoryScreen(
                qrHistory: _qrHistories,
                searchController: _searchController,
                historyQrType: _historyQrType,
                showSkeleton: _showQrHistorySkeleton,
                onRefresh: () {
                  _getQrHistoryEvent();
                },
                onSwitchTabs: (value) {
                  _bloc.add(SwitchHistoryTabsEvent(historyQrType: value));
                },
                onChangeQrActivationState: (qrHistories, qrHistory) {
                  _bloc.add(ChangeQrActivationStatusEvent(
                      qrHistories: qrHistories, qrHistory: qrHistory));
                },
                onSearch: (value) {
                  _bloc.add(QrHistorySearchEvent(
                      qrHistories: _qrHistories, value: value));
                },
              ),
              titleOfTapOne: S.of(context).createQrCode,
              titleOfTapTwo: S.of(context).history,
              currentIndex: (index) {
                _bloc.add(SwitchQrTabsEvent(index: index));
              },
              tabController: _tabController,
            ),
          ),
        );
      },
    );
  }

  void _openRulesBottomSheetEvent() {
    _bloc.add(OpenRulesBottomSheetEvent());
  }

  void _showSearchableBottomSheetEvent(
      List<PageField> questions, PageField question) {
    _bloc.add(ShowSearchableBottomSheetEvent(
      questions: questions,
      question: question,
      isMultiChoice: question.code == QuestionsCode.searchableMulti,
    ));
  }

  void _deleteImageQuestion(List<PageField> questions, PageField question) {
    _bloc.add(DeleteImageQuestionEvent(
      questions: questions,
      question: question,
    ));
  }

  void _selectImageQuestion(List<PageField> questions, PageField question) {
    _bloc.add(SelectImageQuestionEvent(
      questions: questions,
      question: question,
    ));
  }

  void _answerQuestionEvent(
      List<PageField> questions, PageField question, answer) {
    _bloc.add(AddAnswerToQuestionEvent(
        questions: questions, question: question, answer: answer));
  }

  void _selectMultipleAnswerEvent(
      List<PageField> questions, PageField question, int answerId) {
    _bloc.add(SelectMultiSelectionAnswerEvent(
        questions: questions, question: question, answerId: answerId));
  }

  void _selectSingleSelectionAnswerEvent(
      List<PageField> questions, PageField question, int answerId) {
    _bloc.add(SelectSingleSelectionAnswerEvent(
      questions: questions,
      question: question,
      answerId: answerId,
    ));
  }

  void _selectQrTypeEvent(QrsType qrsType) {
    if (_qrsType.code == qrsType.code) return;
    _bloc.add(SelectQrTypeEvent(qrsType: qrsType));
  }

  void _selectGuestTypeEvent(GuestsType guestsType) async {
    _bloc.add(SelectGuestTypeEvent(guestsType: guestsType));
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {});
  }

  void _deleteAnswerQuestionEvent(
    List<PageField> questions,
    PageField question,
  ) {
    _bloc.add(DeleteAnswerQuestionEvent(
      questions: questions,
      question: question,
    ));
  }

  void _getQrHistoryEvent() {
    _bloc.add(GetQrHistoryEvent(qrType: _historyQrType));
  }

  void _navigateBackEvent() {
    _bloc.add(NavigateBackEvent());
  }

  void _updateSearchableSingleQuestionEvent(
      List<PageField> questions, PageField pageField, Choice choice) {
    _bloc.add(UpdateSearchableSingleQuestionEvent(
      questions: questions,
      question: pageField,
      answer: choice,
    ));
  }

  void _updateSearchableMultiQuestionEvent(
      List<PageField> questions, PageField pageField, List<Choice> choices) {
    _bloc.add(UpdateSearchableMultiQuestionEvent(
      questions: questions,
      question: pageField,
      answer: choices,
    ));
  }

  Future<void> _getImage(
    ImageSource img,
    List<PageField> questions,
    PageField question,
  ) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: img);
    XFile? imageFile = pickedFile;
    if (imageFile != null) {
      XFile? compressedImage = await compressFile(File(imageFile.path));
      if (compressedImage != null) {
        _answerQuestionEvent(
          questions,
          question,
          compressedImage.path,
        );
      }
    }
  }

  void _showMediaBottomSheet({
    required List<PageField> questions,
    required PageField question,
  }) {
    FocusScope.of(context).unfocus();
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        _navigateBackEvent();
        if (await PermissionServiceHandler()
            .handleServicePermission(setting: Permission.camera)) {
          _getImage(ImageSource.camera, questions, question);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBackEvent();
              openAppSettings();
            },
            onSecondaryAction: () {
              _navigateBackEvent();
            },
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: S.of(context).youShouldHaveCameraPermission,
          );
        }
      },
      onTapGallery: () async {
        _navigateBackEvent();
        if (await PermissionServiceHandler().handleServicePermission(
            setting:
                PermissionServiceHandler.getSingleImageGalleryPermission())) {
          _getImage(ImageSource.gallery, questions, question);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBackEvent();
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                    setting: PermissionServiceHandler
                        .getSingleImageGalleryPermission())) {}
              });
            },
            onSecondaryAction: () {
              _navigateBackEvent();
            },
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: Platform.isAndroid
                ? S.of(context).youShouldHaveCameraPermission
                : S.of(context).youShouldHaveStoragePermission,
          );
        }
      },
    );
  }

  void _openSearchableBottomSheet(
    List<PageField> questions,
    PageField question,
    bool isMultiChoice,
  ) {
    showSearchableBottomSheet(
      context: context,
      pageField: question,
      isMultiChoice: isMultiChoice,
      onSaveMultiChoice: (pageField, choices) {
        _updateSearchableMultiQuestionEvent(
          questions,
          pageField,
          choices,
        );
      },
      onChoicesSelected: (pageField, choice) {
        _updateSearchableSingleQuestionEvent(
          questions,
          pageField,
          choice,
        );
        _navigateBackEvent();
      },
    );
  }

  void _showMessageDialog({
    required String message,
    required Function() onTab,
    required String icon,
  }) {
    showMassageDialogWidget(
      context: context,
      text: message,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: onTab,
    );
  }

  void _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    FocusScope.of(context).unfocus();
    showActionDialogWidget(
      context: context,
      text: text,
      primaryText: primaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryText: secondaryText,
      secondaryAction: () {
        onSecondaryAction();
      },
      icon: icon,
    );
  }

  void showRulesBottomSheet() {
    FocusScope.of(context).unfocus();
    showBottomSheetWidget(
        context: context,
        content: WebViewHtmlContentWidget(
          webViewHtmlContent: _guestsType.rules ?? "",
        ),
        titleLabel: S.of(context).rules,
        height: MediaQuery.of(context).size.height * 0.7);
  }

  DateTime _getFirstDate() {
    while (isDateHoliday(firstDate) || isWeekEnd(firstDate)) {
      firstDate = firstDate.add(const Duration(days: 1));
    }

    return firstDate;
  }

  void _openDatePicker(Function(DateTime?) onDateSelected) {
    if (true) {
      androidDatePicker(
          context: context,
          firstDate: _getFirstDate(),
          activeDates: _guestsType.isHoliday
              ? _qrConfiguration.qrCompoundConfiguration.holidays
                  .map((e) => DateTime.parse(e.date))
                  .where((element) =>
                      element.isAfter(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day)) &&
                      element.isBefore(
                          DateTime.parse(_guestsType.qrPeriodRequest)))
                  .toList()
              : [],
          restrictedDays: _guestsType.isWeekend
              ? _qrConfiguration.qrCompoundConfiguration.weekEndDays
              : [],
          onSelectDate: (date) {
            if (date == null) return;
            _selectDateController.text = date.toString().split(" ")[0];
            onDateSelected(date);
          },
          selectedDate: _selectedDate,
          lastDate: DateTime.parse(_guestsType.qrPeriodRequest));
    } else {
      DateTime tempDate =
          _selectedDate == null ? DateTime.now() : _selectedDate!;
      iosDatePicker(
        context: context,
        selectedDate: _selectedDate,
        maximumDate: DateTime.parse(_guestsType.qrPeriodRequest),
        minimumDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        onChange: (date) {
          tempDate = DateTime.parse(date.toString());
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
        onDone: () {
          if (tempDate != _selectedDate) {
            _selectedDate = tempDate;
          }
          _selectDateController.text = _selectedDate.toString().split(" ")[0];
          onDateSelected(tempDate);
          Navigator.of(context).pop();
        },
      );
    }
  }

  //Check if the Date Entered is Holiday or Not in Case of Any Type of QR
  bool isDateHoliday(DateTime selectedDate) {
    if (_qrConfiguration.qrCompoundConfiguration.holidays.isEmpty) return false;
    for (int i = 0;
        i < _qrConfiguration.qrCompoundConfiguration.holidays.length;
        i++) {
      if (DateTime(
              DateTime.parse(
                      _qrConfiguration.qrCompoundConfiguration.holidays[i].date)
                  .year,
              DateTime.parse(
                      _qrConfiguration.qrCompoundConfiguration.holidays[i].date)
                  .month,
              DateTime.parse(
                      _qrConfiguration.qrCompoundConfiguration.holidays[i].date)
                  .day)
          .isAtSameMomentAs(selectedDate)) {
        return true;
      }
    }

    return false;
  }

  bool isWeekEnd(DateTime selectedDate) {
    if (!_guestsType.isWeekend) return false;
    for (int i = 0;
        i < _qrConfiguration.qrCompoundConfiguration.weekEndDays.length;
        i++) {
      if (getDayNameFromDate(selectedDate)
              .replaceAll("أ", "ا")
              .replaceAll("ة", "ه")
              .toLowerCase() ==
          _qrConfiguration.qrCompoundConfiguration.weekEndDays[i].name
              .replaceAll("أ", "ا")
              .replaceAll("ة", "ه")
              .toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  List<Day> getDaysInRange(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    DateTime currentDay = startDate;

    while (currentDay.isBefore(endDate.add(Duration(days: 1)))) {
      days.add(currentDay);
      currentDay = currentDay.add(Duration(days: 1));
    }
    Set<Day> daysList = {};
    for (int i = 0; i < days.length; i++) {
      for (int j = 0; j < _guestsType.days.length; j++) {
        if (_guestsType.days[j].name
                .toLowerCase()
                .replaceAll("أ", "ا")
                .toLowerCase() ==
            getDayNameFromDate(days[i])
                .replaceAll("أ", "ا")
                .replaceAll("ة", "ه")
                .toLowerCase()) {
          daysList.add(_guestsType.days[j]);
        }
      }
    }
    if (_guestsType.isWeekend) {
      for (var weekend
          in _qrConfiguration.qrCompoundConfiguration.weekEndDays) {
        daysList.removeWhere((element) => weekend.code == element.code);
      }
    }
    return daysList.toList();
  }

  List<DayTime> getDayAvailableTimes(String day) {
    if (day.isEmpty) return [];
    try {
      return _guestsType.days
          .firstWhere((element) {
            return element.name
                    .toLowerCase()
                    .replaceAll("أ", "ا")
                    .replaceAll('ة', 'ه')
                    .toLowerCase() ==
                day.replaceAll("أ", "ا").replaceAll('ة', 'ه').toLowerCase();
          })
          .times
          .toList();
    } catch (e) {
      return [];
    }
  }

  String getDayNameFromDate(DateTime? dateTime) {
    if (dateTime == null) return "";

    return DateFormat('EEEE').format(dateTime);
  }

  void _scrollToFirstErrorSection(
      QrErrorMessages qrErrorMessages, List<PageField> questions) {
    if (qrErrorMessages.dateErrorMessage != null) {
      Scrollable.ensureVisible(
        (qrErrorMessages.dateKey?.currentContext ?? context),
        duration: const Duration(milliseconds: 500),
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
        curve: Curves.easeInOut,
      );
    } else if (qrErrorMessages.daysErrorMessage != null) {
      Scrollable.ensureVisible(
        (qrErrorMessages.daysKey?.currentContext ?? context),
        duration: const Duration(milliseconds: 500),
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
        curve: Curves.easeInOut,
      );
    } else if (qrErrorMessages.timeErrorMessage != null) {
      Scrollable.ensureVisible(
        (qrErrorMessages.timeKey?.currentContext ?? context),
        duration: const Duration(milliseconds: 500),
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
        curve: Curves.easeInOut,
      );
    } else if (qrErrorMessages.visitorNameErrorMessage != null) {
      Scrollable.ensureVisible(
        (qrErrorMessages.visitorKey?.currentContext ?? context),
        duration: const Duration(milliseconds: 500),
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
        curve: Curves.easeInOut,
      );
    } else {
      for (int i = 0; i < questions.length; i++) {
        if (questions[i].notAnswered || !questions[i].isValid) {
          Scrollable.ensureVisible(
            (questions[i].key?.currentContext ?? context),
            duration: const Duration(milliseconds: 500),
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
            curve: Curves.easeInOut,
          );
          break;
        }
      }
    }
  }
}

class QrErrorMessages {
  String? dateErrorMessage;
  GlobalKey? dateKey;
  String? daysErrorMessage;
  GlobalKey? daysKey;
  String? timeErrorMessage;
  GlobalKey? timeKey;
  String? visitorNameErrorMessage;
  GlobalKey? visitorKey;

  QrErrorMessages({
    this.dateErrorMessage,
    this.daysErrorMessage,
    this.timeErrorMessage,
    this.visitorNameErrorMessage,
    this.daysKey,
    this.timeKey,
    this.visitorKey,
    this.dateKey,
  });

  @override
  String toString() {
    return 'QrErrorMessages{dateErrorMessage: $dateErrorMessage, dateKey: $dateKey, daysErrorMessage: $daysErrorMessage, daysKey: $daysKey, timeErrorMessage: $timeErrorMessage, timeKey: $timeKey, visitorNameErrorMessage: $visitorNameErrorMessage, visitorKey: $visitorKey}';
  }
}

enum QRType {
  single,
  multiple,
}
