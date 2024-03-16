import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:city_eye/src/presentation/blocs/history/history_bloc.dart';
import 'package:city_eye/src/presentation/screens/qr/skeleton/history_skeleton_widget.dart';
import 'package:city_eye/src/presentation/screens/qr/widgets/history_card_widget.dart';
import 'package:city_eye/src/presentation/screens/qr/widgets/history_header_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrHistoryScreen extends BaseStatefulWidget {
  final List<QrHistory> qrHistory;
  final TextEditingController searchController;
  final int historyQrType;
  final bool showSkeleton;
  final Function(int) onSwitchTabs;
  final Function(String) onSearch;
  final Function(List<QrHistory>, QrHistory) onChangeQrActivationState;
  final Function() onRefresh;

  const QrHistoryScreen({
    required this.qrHistory,
    required this.searchController,
    required this.historyQrType,
    required this.showSkeleton,
    required this.onSwitchTabs,
    required this.onSearch,
    required this.onChangeQrActivationState,
    required this.onRefresh,
    super.key,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _QrHistoryScreenState();
}

class _QrHistoryScreenState extends BaseState<QrHistoryScreen> {
  HistoryBloc get _bloc => BlocProvider.of<HistoryBloc>(context);

  @override
  Widget baseBuild(BuildContext context) {
    return Column(
      children: [
        HistoryHeaderWidget(
          firstPageTitle: S.of(context).isCurrent,
          secondPageTitle: S.of(context).previous,
          onTabFirstButton: () {
            FocusScope.of(context).unfocus();
            if (widget.historyQrType != 1) {
              widget.onSwitchTabs(1);
            }
          },
          onTabSecondButton: () {
            FocusScope.of(context).unfocus();
            if (widget.historyQrType != 2) {
              widget.onSwitchTabs(2);
            }
          },
          type: widget.historyQrType,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SearchTextFieldWidget(
              controller: widget.searchController,
              onChange: (value) {
                widget.onSearch(value);
              },
              searchText: S.of(context).searchWhatYouNeed,
              onClear: () {
                widget.onSearch('');
              }),
        ),
        widget.showSkeleton
            ? const HistorySkeletonWidget()
            : widget.qrHistory.isNotEmpty
                ? Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        widget.onRefresh();
                        return Future.value();
                      },
                      child: ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 17.0, left: 16.0, right: 16.0, bottom: 16),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: widget.qrHistory.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HistoryCardWidget(
                              history: widget.qrHistory[index],
                              qrTypeStatus: widget.historyQrType,
                              onTapDeActiveAction: (qrHistory) {
                                _showActionMessage(
                                  widget.qrHistory,
                                  widget.qrHistory[index],
                                  S
                                      .of(context)
                                      .areYouSureYouWantToDeactivateTheQR,
                                );
                              },
                              onTapActiveAction: (qrHistory) {
                                _showActionMessage(
                                  widget.qrHistory,
                                  widget.qrHistory[index],
                                  S
                                      .of(context)
                                      .areYouSureYouWantToActivateTheQr,
                                );
                              },
                              onTapCardWidget: (qrId) {
                                Navigator.pushNamed(
                                    context, Routes.qrDetailsScreen,
                                    arguments: {"qrId": qrId});
                              },
                            );
                          }),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: CustomEmptyListWidget(
                          imagePath: ImagePaths.historyEmptyScreen,
                          text: S.of(context).noQrCodeYet,
                          onRefresh: () {
                            widget.onRefresh();
                          },
                        ),
                      ),
                    ),
                  ),
      ],
    );
  }

  void _showActionMessage(
      List<QrHistory> histories, QrHistory qrHistory, String message) {
    FocusScope.of(context).unfocus();
    showActionDialogWidget(
        context: context,
        text: message,
        icon: ImagePaths.warning,
        primaryText: S.of(context).no,
        secondaryText: S.of(context).yes,
        primaryAction: () {
          Navigator.pop(context);
        },
        secondaryAction: () {
          FocusScope.of(context).unfocus();
          widget.onChangeQrActivationState(histories, qrHistory);
          Navigator.pop(context);
        });
  }
}
