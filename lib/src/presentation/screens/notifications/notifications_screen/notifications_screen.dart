import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/domain/usecase/set_qr_code_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_services_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_support_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_wall_item_id_use_case.dart';
import 'package:city_eye/src/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_screen/skeleton/skeleton_notification_screen.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_screen/widgets/empty_notification_widget.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_screen/widgets/notification_list_item_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends BaseStatefulWidget {
  final int id;

  const NotificationsScreen({this.id = -1, super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends BaseState<NotificationsScreen> {
  NotificationsBloc get _bloc => BlocProvider.of<NotificationsBloc>(context);
  List<NotificationItem> _notifications = [];

  Color borderColor = ColorSchemes.primary;
  var itemCount = 0;
  var _key;
  Timer? _timer;

  @override
  void initState() {
    _getNotificationsDataEvent();
    super.initState();
  }

  Future<void> _getNotificationsDataEvent() async {
    _bloc.add(GetNotificationsDataEvent());
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.white,
      appBar: buildAppBarWidget(context,
          title: S.of(context).notifications,
          isHaveBackButton: true, onBackButtonPressed: () {
        _bloc.add(NotificationsPopEvent());
      }),
      body: BlocConsumer<NotificationsBloc, NotificationsState>(
        listener: (context, state) {
          if (state is ShowLoadingState) {
            showLoading();
          } else if (state is HideLoadingState) {
            hideLoading();
          } else if (state is SuccessFetchNotificationsDataState) {
            _notifications = List<NotificationItem>.from(state.notifications);
          } else if (state is NotificationsPopState) {
            Navigator.pop(context);
          } else if (state is NotificationClickActionState) {
            Navigator.pushNamed(context, Routes.notificationsDetailsScreen,
                arguments: {
                  "isPushedNotification": false,
                  "details": state.notificationItem,
                });
          } else if (state is ScrollToItemState) {
            _scrollToIndex(state.key);
            getColor();
          } else if (state is FailedFetchNotificationsDataState) {
            showSnackBar(
              context: context,
              message: state.errorMessage,
              color: ColorSchemes.snackBarError,
              icon: ImagePaths.error,
            );
          } else if (state is UpdateNotificationSeenSuccessState) {
            for (int i = 0; i < _notifications.length; i++) {
              if (_notifications[i].id == state.notificationItem.id) {
                _notifications[i] = _notifications[i].copyWith(isSeen: true);
              }
            }
            _checkNotificationStatus(state.notificationItem);
          } else if (state is UpdateNotificationSeenFailedState) {
            showSnackBar(
              context: context,
              message: state.errorMessage,
              color: ColorSchemes.snackBarError,
              icon: ImagePaths.error,
            );
          }
        },
        builder: (context, state) {
          return state is ShowSkeletonState
              ? const SkeletonNotificationScreen()
              : _notifications.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.only(top: 6.0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        itemCount++;
                        if (widget.id != -1 &&
                            _notifications[index].id == widget.id) {
                          _key = _notifications[index].key;
                        }
                        if (itemCount <= _notifications.length &&
                            _key != null) {
                          _bloc.add(ScrollToItemEvent(key: _key));
                        }
                        return NotificationListItemWidget(
                          key: _notifications[index].key,
                          notification: _notifications[index],
                          onClickActionEvent: _updateNotificationsSeenEvent,
                          borderColor: _notifications[index].id == widget.id &&
                                  _key != null
                              ? borderColor
                              : ColorSchemes.notificationBorder,
                        );
                      })
                  : SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: EmptyNotificationWidget(
                        onRefresh: () {
                          _getNotificationsDataEvent();
                        },
                      ),
                    );
        },
      ),
    );
  }

  void _checkNotificationStatus(NotificationItem notificationItem) async {
    if (notificationItem.notificationSource.code == "notificationDetails") {
      _navigateToNotificationDetailsScreen(
          int.parse(notificationItem.targetId));
    } else if (notificationItem.notificationSource.code == "eventDetails") {
      _navigateToEventDetailsScreen(int.parse(notificationItem.targetId));
    } else if (notificationItem.notificationSource.code == "surveys") {
      Navigator.pushNamed(context, Routes.surveys, arguments: {
        "id": int.parse(notificationItem.targetId),
      });
    } else if (notificationItem.notificationSource.code == "qrDetails") {
      _navigateToQrDetailsScreen(int.parse(notificationItem.targetId));
    } else if (notificationItem.notificationSource.code ==
        "current_qrHistory") {
      // Note : first list item is for scroll item Id
      // and second list item is for go to History
      // and third list item is for go to current or previous
      await SetQrCodeIndexUseCase(injector())(
          [notificationItem.targetId, "1", "0"]).then((value) {
        _navigateToQrHistory();
      });
    } else if (notificationItem.notificationSource.code ==
        "previous_qrHistory") {
      // Note : first list item is for scroll item Id
      // and second list item is for go to History
      // and third list item is for go to current or previous
      await SetQrCodeIndexUseCase(injector())(
          [notificationItem.targetId, "1", "1"]).then((value) {
        _navigateToQrHistory();
      });
    } else if (notificationItem.notificationSource.code == "open_support") {
      // Note : first list item is for scroll item Id
      // and second list item is for go to History
      // and third list item is for go to open requests or all requests
      await SetSupportIndexUseCase(injector())(
          [notificationItem.targetId, "1", "open_support"]).then((value) {
        _navigateToMainScreen(1);
      });
    } else if (notificationItem.notificationSource.code == "all_support") {
      // Note : first list item is for scroll item Id
      // and second list item is for go to History
      // and third list item is for go to open requests or all requests
      await SetSupportIndexUseCase(injector())(
          [notificationItem.targetId, "1", "all_support"]).then((value) {
        _navigateToMainScreen(1);
      });
    } else if (notificationItem.notificationSource.code ==
        "support_completed") {
      // Note : first list item is for scroll item Id
      // and second list item is for go to History
      // and third list item is for go to open requests or all requests
      await SetSupportIndexUseCase(injector())(
          [notificationItem.targetId, "1", "support_completed"]).then((value) {
        _navigateToMainScreen(1);
      });
    } else if (notificationItem.notificationSource.code == "wall") {
      await SetWallItemIdUseCase(injector())(
              int.parse(notificationItem.targetId))
          .then((value) {
        _navigateToMainScreen(2);
      });
    } else if (notificationItem.notificationSource.code == "services") {
      await SetServicesIndexUseCase(injector())(
              int.parse(notificationItem.targetId))
          .then((value) {
        _navigateToMainScreen(3);
      });
    } else if (notificationItem.notificationSource.code == "gallery") {
      Navigator.pushNamed(context, Routes.gallery);
    } else if (notificationItem.notificationSource.code == "paymentDetails") {
      Navigator.pushNamed(context, Routes.paymentDetails, arguments: {
        "paymentId": int.parse(notificationItem.targetId),
      });
    } else if (notificationItem.notificationSource.code == "events") {
      Navigator.pushNamed(context, Routes.events, arguments: {
        "id": int.parse(notificationItem.targetId),
      });
    } else if (notificationItem.notificationSource.code == "familymember") {
      Navigator.pushNamed(context, Routes.profile, arguments: {
        "index": 4,
        "scrollToId": int.parse(notificationItem.targetId),
      });
    } else if (notificationItem.notificationSource.code == "support_comments") {
      Navigator.pushNamed(context, Routes.commentScreen, arguments: {
        'order': const Orders(),
        "id": int.parse(notificationItem.targetId),
      });
    } else if (notificationItem.notificationSource.code == "UnitContract") {
      Navigator.pushNamed(context, Routes.profile, arguments: {
        "index": 3,
        "scrollToId": int.parse(notificationItem.targetId),
      });
    } else {
      _bloc.add(NotificationClickActionEvent(notificationItem));
    }
  }

  Future<void> _navigateToNotificationDetailsScreen(int id) async {
    Navigator.pushNamed(context, Routes.notificationsDetailsScreen, arguments: {
      "isPushedNotification": true,
      "details": const NotificationItem(),
      "id": id,
    });
  }

  Future<void> _navigateToEventDetailsScreen(int id) async {
    await Navigator.pushNamed(context, Routes.eventDetails, arguments: {
      "eventId": id,
    });
  }

  Future<void> _navigateToQrDetailsScreen(int id) async {
    await Navigator.pushNamed(context, Routes.qrDetailsScreen, arguments: {
      "qrId": id,
    });
  }

  void _navigateToQrHistory() async {
    await Navigator.pushNamed(context, Routes.qr);
  }

  Future<void> _navigateToMainScreen(int index) async {
    Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false,
        arguments: {
          "selectIndex": index,
        });
  }

  Future<void> _scrollToIndex(GlobalKey key) async {
    Future.delayed(const Duration(milliseconds: 500));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  getColor() {
    _timer = Timer(const Duration(seconds: 2), () {
      borderColor = ColorSchemes.notificationBorder;
      setState(() {});
    });
  }

  void _updateNotificationsSeenEvent(NotificationItem notificationItem) {
    _bloc.add(
      UpdateNotificationSeenEvent(
        notificationItem: notificationItem,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
