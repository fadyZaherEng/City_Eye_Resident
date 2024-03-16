import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/wall/wall.dart';
import 'package:city_eye/src/domain/entities/wall/wall_attachment.dart';
import 'package:city_eye/src/domain/usecase/wall/get_wall_list_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wall_event.dart';

part 'wall_state.dart';

class WallBloc extends Bloc<WallEvent, WallState> {
  final GetWallListUseCase _getWallListUseCase;

  WallBloc(this._getWallListUseCase) : super(WallInitialState()) {
    on<GetWallEvent>(_onGetWallEvent);
    on<NavigateToWallPictureScreenEvent>(_onNavigateToWallPictureScreenEvent);
    on<ScrollToItemEvent>(_onScrollToItemEvent);
  }
  var walls = <Wall>[];
  bool isLoaded = false;
  FutureOr<void> _onGetWallEvent(
      GetWallEvent event, Emitter<WallState> emit) async {
    if (event.isRefresh) {
      isLoaded = false;
    }
    if(isLoaded) {
      for (int i = 0; i < walls.length; i++) {
        GlobalKey key = GlobalKey();
        walls[i] = walls[i].copyWith(key: key);
      }
      emit(GetWallSuccessState(walls: walls));
      return;
    }
    emit(GetWallSkeletonState());
    final DataState<List<Wall>> dataState = await _getWallListUseCase();
    if (dataState is DataSuccess) {
      walls = dataState.data ?? [];
      if (dataState.data!.isNotEmpty) {
        for (int i = 0; i < walls.length; i++) {
          GlobalKey key = GlobalKey();
          walls[i] = walls[i].copyWith(key: key);
        }
        emit(GetWallSuccessState(walls: walls));
        isLoaded = true;
      } else {
        emit(EmptyWallState());
        isLoaded = false;
      }
    } else {
      emit(GetWallErrorState(errorMessage: dataState.message ?? ""));
    }
  }

  FutureOr<void> _onNavigateToWallPictureScreenEvent(
      NavigateToWallPictureScreenEvent event, Emitter<WallState> emit) {
    emit(NavigateToWallPictureScreenState(
      initialIndex: event.pictureId,
      images: event.wallImages,
    ));
  }

  FutureOr<void> _onScrollToItemEvent(
      ScrollToItemEvent event, Emitter<WallState> emit) {
    emit(ScrollToItemState(key: event.key));
  }
}
