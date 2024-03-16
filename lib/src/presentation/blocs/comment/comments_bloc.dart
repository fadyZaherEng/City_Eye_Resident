import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/comments_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/send_comment_request.dart';
import 'package:city_eye/src/domain/entities/support/comments.dart';
import 'package:city_eye/src/domain/usecase/get_order_comments_use_case.dart';
import 'package:city_eye/src/domain/usecase/send_order_comment_use_case.dart';
import 'package:equatable/equatable.dart';

part 'comments_event.dart';

part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetOrderCommentsUseCase _getOrderCommentsUseCase;
  final SendOrderCommentUseCase _sendOrderCommentUseCase;
  List<Comments> _comments = [];

  CommentsBloc(
    this._getOrderCommentsUseCase,
    this._sendOrderCommentUseCase,
  ) : super(CommentsInitial()) {
    on<GetCommentsEvent>(_onGetCommentsEvent);
    on<AskForCameraPermissionEvent>(_onAskForCameraPermissionEvent);
    on<CameraPressedEvent>(_onCameraPressedEvent);
    on<GalleryPressedEvent>(_onGalleryPressedEvent);
    on<MediaIconPressedEvent>(_onMediaIconPressedEvent);
    on<SendPressedEvent>(_onSendPressedEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<ScrollToLastIndexEvent>(_onScrollToLastIndexEvent);
  }

  FutureOr<void> _onGetCommentsEvent(
      GetCommentsEvent event, Emitter<CommentsState> emit) async {
    if (event.showLoading) {
      emit(ShowSkeletonState());
    }

    DataState dataState = await _getOrderCommentsUseCase(CommentsRequest(
      requestId: event.orderId,
    ));
    if (dataState is DataSuccess) {
      _comments = dataState.data as List<Comments>;
      emit(GetCommentsSuccessState(comments: _comments));
    } else {
      emit(GetCommentsErrorState(errorMessage: dataState.message ?? ""));
    }

    // if(event.showLoading){
    //   emit(HideLoadingState());
    // }
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<CommentsState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onAskForCameraPermissionEvent(
      AskForCameraPermissionEvent event, Emitter<CommentsState> emit) {
    emit(AskForCameraPermissionState(
      onTab: event.onTab,
      isGallery: event.isGallery,
    ));
  }

  FutureOr<void> _onCameraPressedEvent(
      CameraPressedEvent event, Emitter<CommentsState> emit) {
    emit(OpenCameraState());
  }

  FutureOr<void> _onGalleryPressedEvent(
      GalleryPressedEvent event, Emitter<CommentsState> emit) {
    emit(OpenGalleryState());
  }

  FutureOr<void> _onMediaIconPressedEvent(
      MediaIconPressedEvent event, Emitter<CommentsState> emit) {
    emit(OpenMediaBottomSheetState());
  }

  FutureOr<void> _onSendPressedEvent(
      SendPressedEvent event, Emitter<CommentsState> emit) async {
    emit(ShowLoadingState());

    DataState dataState = await _sendOrderCommentUseCase(
        event.imagePath,
        SendCommentRequest(
          requestId: event.orderId,
          message: event.message,
          isImage: event.isImage,
        ));

    if (dataState is DataSuccess) {
      _comments = dataState.data as List<Comments>;
      emit(SendCommentSuccessState(comments: _comments));
    } else {
      emit(GetCommentsErrorState(errorMessage: dataState.message ?? ""));
    }

    emit(HideLoadingState());
  }

  FutureOr<void> _onScrollToLastIndexEvent(
      ScrollToLastIndexEvent event, Emitter<CommentsState> emit) async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit(ScrollToLastIndexState());
  }
}
