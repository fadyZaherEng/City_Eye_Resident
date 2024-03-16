import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_seen_request.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/domain/usecase/notifications/get_notification_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/notifications/update_notification_seen_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_details_event.dart';

part 'notification_details_state.dart';

class NotificationDetailsBloc
    extends Bloc<NotificationDetailsEvent, NotificationDetailsState> {
  final GetNotificationDetailsUseCase _getNotificationDetailsDataUseCase;

  NotificationDetailsBloc(
    this._getNotificationDetailsDataUseCase,
  ) : super(ShowSkeletonState()) {
    on<BackEvent>(_onBackEvent);
    on<GetRemoteNotificationDetailsDataEvent>(
        _onGetNotificationDetailsDataEvent);
    on<SetLocalNotificationDetailsDataEvent>(
        _onSetLocalNotificationDetailsDataEvent);
    on<ShowSkeletonEvent>(_onShowSkeletonEvent);
    on<HideSkeletonEvent>(_onHideSkeletonEvent);
  }

  FutureOr<void> _onBackEvent(
      BackEvent event, Emitter<NotificationDetailsState> emit) {
    emit(BackState());
  }

  FutureOr<void> _onGetNotificationDetailsDataEvent(
      GetRemoteNotificationDetailsDataEvent event,
      Emitter<NotificationDetailsState> emit) async {
    emit(ShowSkeletonState());
    final notificationDetailsState = await _getNotificationDetailsDataUseCase(
      NotificationDetailsRequest(id: event.id),
    );
    if (notificationDetailsState is DataSuccess<NotificationItem>) {
      emit(SuccessGetNotificationDetailsDataState(
          notificationDetailsState.data ?? const NotificationItem()));
    } else if (notificationDetailsState is DataFailed) {
      emit(FailedNotificationDetailsDataState(
          notificationDetailsState.message ?? ""));
    }
  }

  FutureOr<void> _onSetLocalNotificationDetailsDataEvent(
      SetLocalNotificationDetailsDataEvent event,
      Emitter<NotificationDetailsState> emit) {
    emit(SetLocalNotificationDetailsDataState(event.localNotificationDetails));
  }

  FutureOr<void> _onShowSkeletonEvent(
      ShowSkeletonEvent event, Emitter<NotificationDetailsState> emit) {
    emit(ShowSkeletonState());
  }

  FutureOr<void> _onHideSkeletonEvent(
      HideSkeletonEvent event, Emitter<NotificationDetailsState> emit) {
    emit(HideSkeletonState());
  }
}
