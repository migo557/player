import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'controls_visibility_state.dart';

class ControlsVisibilityCubit extends Cubit<ControlsVisibilityState> {
  Timer? videoTimer;
  ControlsVisibilityCubit()
      : super(ControlsVisibilityState(showVideoControls: false));

  toggleVideoControlsVisibilty() {
    
    emit(ControlsVisibilityState(showVideoControls: true));

    videoTimer?.cancel();

    videoTimer = Timer(
      Duration(seconds: 6),
      () {
       emit(ControlsVisibilityState(showVideoControls: false)); 
      },
    );
  }
}
