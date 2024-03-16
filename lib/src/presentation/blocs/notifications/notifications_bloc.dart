import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_seen_request.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/domain/usecase/notifications/get_notifications_use_case.dart';
import 'package:city_eye/src/domain/usecase/notifications/update_notification_seen_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase _getNotificationsDataUseCase;
  final UpdateNotificationSeenUseCase _updateNotificationSeenUseCase;

  NotificationsBloc(
    this._getNotificationsDataUseCase,
    this._updateNotificationSeenUseCase,
  ) : super(ShowSkeletonState()) {
    on<GetNotificationsDataEvent>(_onGetNotificationsDataEvent);
    on<NotificationsPopEvent>(_onNotificationsPopEvent);
    on<NotificationClickActionEvent>(_onNotificationClickActionEvent);
    on<ScrollToItemEvent>(_onScrollToItemEvent);
    on<UpdateNotificationSeenEvent>(_onUpdateNotificationSeenEvent);
  }

  FutureOr<void> _onGetNotificationsDataEvent(
      GetNotificationsDataEvent event, Emitter<NotificationsState> emit) async {
    emit(ShowSkeletonState());
    await Future.delayed(const Duration(seconds: 1));
    final notificationsState = await _getNotificationsDataUseCase();
    if (notificationsState is DataSuccess<List<NotificationItem>>) {
      List<NotificationItem> notifications = notificationsState.data ?? [];
      for (var i = 0; i < notifications.length; i++) {
        GlobalKey key = GlobalKey();
        notifications[i] = notifications[i].copyWith(key: key);
      }
      emit(SuccessFetchNotificationsDataState(notifications: notifications));
    } else if (notificationsState is DataFailed) {
      emit(FailedFetchNotificationsDataState(
          errorMessage: notificationsState.message ?? ""));
    }
  }

  FutureOr<void> _onNotificationsPopEvent(
      NotificationsPopEvent event, Emitter<NotificationsState> emit) {
    emit(NotificationsPopState());
  }

  FutureOr<void> _onNotificationClickActionEvent(
      NotificationClickActionEvent event, Emitter<NotificationsState> emit) {
    emit(NotificationClickActionState(event.notificationItem));
  }

  FutureOr<void> _onScrollToItemEvent(
      ScrollToItemEvent event, Emitter<NotificationsState> emit) {
    emit(ScrollToItemState(key: event.key));
  }

  FutureOr<void> _onUpdateNotificationSeenEvent(
      UpdateNotificationSeenEvent event,
      Emitter<NotificationsState> emit) async {
    emit(ShowLoadingState());
    NotificationSeenRequest notificationSeenRequest = NotificationSeenRequest(
      notificationId: int.parse(
        event.notificationItem.notificationId,
      ),
    );

    final DataState dataState =
        await _updateNotificationSeenUseCase(notificationSeenRequest);

    if (dataState is DataSuccess) {
      emit(UpdateNotificationSeenSuccessState(
          dataState.message ?? "", event.notificationItem));
    } else if (dataState is DataFailed) {
      emit(UpdateNotificationSeenFailedState(
          dataState.message ?? "", event.notificationItem));
    }
    emit(HideLoadingState());
  }
}
