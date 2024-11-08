import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'brightness_state.dart';

class BrightnessCubit extends Cubit<BrightnessState> {
  Timer? _timer;

  BrightnessCubit() : super(BrightnessState.initialState());

  // Adjusts the brightness based on drag update
  void changeVideoPlayerBrightness(DragUpdateDetails details) {
    final double delta = details.primaryDelta! / -350;
    double newBrightness = state.videoPlayerBrightness - delta;

    // Bound the brightness between 0.0 and 1.0
    newBrightness = newBrightness.clamp(0.0, 1.0);

    // Only emit a new state if the brightness has changed
    if (newBrightness != state.videoPlayerBrightness) {
      emit(state.copyWith(videoPlayerBrightness: newBrightness));
    }
  }

  // Toggles visibility of the brightness control box
  FutureOr<void> brightnessBoxVisibilityToggle() {
    // Show the brightness control box
    emit(state.copyWith(showBrightnessBox: true));

    // Cancel any previous timers
    _timer?.cancel();

    // Start a new timer to hide the brightness box after 3 seconds
    _timer = Timer(
      const Duration(seconds: 3),
      () {
        emit(state.copyWith(showBrightnessBox: false));
      },
    );
  }
}
