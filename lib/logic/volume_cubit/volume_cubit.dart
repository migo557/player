import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'volume_state.dart';

class VolumeCubit extends Cubit<VolumeState> {
  Timer? _timer;
  final AudioPlayer audioPlayer;
  VolumeCubit({required this.audioPlayer}) : super(VolumeState.initial());

  FutureOr<void> changeAudioPlayerVolume({required details}) async {
    double delta = details.primaryDelta! / -350;
    state.audioPlayerVolume += delta;

    if (state.audioPlayerVolume < 0.0) {
      emit(state.copyWith(audioPlayerVolume: 0));
    } else if (state.audioPlayerVolume > 1.0) {
      emit(state.copyWith(audioPlayerVolume: 1));
    }
    emit(
      state.copyWith(audioPlayerVolume: state.audioPlayerVolume),
    );
    audioPlayer.setVolume(state.audioPlayerVolume);
  }

  FutureOr<void> audioPlayerVolumeBoxVisibilityToggle() {
     emit(state.copyWith(showVolumeBox: true));
    _timer?.cancel();

    _timer = Timer(
      const Duration(seconds: 3),
      () {
        emit(state.copyWith(showVolumeBox: false));
      },
    );
  }
}
