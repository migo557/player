import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'controls_visibility_state.dart';

class ControlsVisibilityCubit extends Cubit<ControlsVisibilityState> {
  Timer? videoTimer;
  ControlsVisibilityCubit()
      : super(ControlsVisibilityState(
            showVideoControls: false, lockScreenTapping: false));

  toggleVideoControlsVisibilty() {
    emit(state.copyWith(showVideoControls: true));

    videoTimer?.cancel();

    videoTimer = Timer(
      Duration(seconds: 6),
      () {
        emit(state.copyWith(showVideoControls: false));
      },
    );
  }

  toggleLockScreenButton() {
    emit(state.copyWith(lockScreenTapping: !state.lockScreenTapping));
  }
}
