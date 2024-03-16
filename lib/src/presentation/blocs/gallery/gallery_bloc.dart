import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/usecase/gallery_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gallery_event.dart';

part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryUseCase _galleryUseCase;

  GalleryBloc(this._galleryUseCase) : super(GalleryInitialState()) {
    on<GetGalleryEvent>(_onGetGalleryEvent);
    on<NavigateToGalleryPictureScreenEvent>(
        _onNavigateToGalleryPictureScreenEvent);
    on<NavigationPopEvent>(_onNavigationPopEvent);
  }

  var gallery = <Gallery>[];
  bool isLoaded = false;

  FutureOr<void> _onGetGalleryEvent(
      GetGalleryEvent event, Emitter<GalleryState> emit) async {

    if (event.isRefresh) {
      isLoaded = false;
    }
    if(isLoaded) {
      emit(GetGallerySuccessState(
        gallery: gallery,
      ));
      return;
    }

    emit(GetGallerySkeletonState());
    final DataState<List<Gallery>> galleryState = await _galleryUseCase();
    if (galleryState is DataSuccess<List<Gallery>>) {
      gallery = galleryState.data ?? const [];
      emit(GetGallerySuccessState(
        gallery: galleryState.data ?? const [],
      ));
      isLoaded = true;
    } else if (galleryState is DataFailed) {
      emit(GetGalleryErrorState(errorMessage: galleryState.message ?? ""));
    }
  }

  FutureOr<void> _onNavigateToGalleryPictureScreenEvent(
      NavigateToGalleryPictureScreenEvent event, Emitter<GalleryState> emit) {
    emit(NavigateToGalleryPictureScreenState(
      initialIndex: event.pictureId,
      images: event.galleryImages,
    ));
  }

  FutureOr<void> _onNavigationPopEvent(
      NavigationPopEvent event, Emitter<GalleryState> emit) {
    emit(NavigationPopState());
  }
}
