import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:color_log/color_log.dart';
import 'package:equatable/equatable.dart';

import '../../data/services/video_playback_hive_service/video_playback_service.dart';

part 'video_playback_event.dart';
part 'video_playback_state.dart';

class VideoPlaybackHiveBloc
    extends Bloc<VideoPlaybackEvent, VideoPlaybackHiveState> {
  VideoPlaybackHiveService videoPlaybackHiveService;
  VideoPlaybackHiveBloc({required this.videoPlaybackHiveService})
      : super(VideoPlaybackHiveState(showResumeButton: false, position: 0)) {
    on<InitializeVideoPlaybackEvent>(_initializeVideoPlaybackEvent);
    on<UpdateVideoPlaybackEvent>(_updateVideoPlaybackEvent);
    on<HideVideoPlaybackResumeButtonEvent>(_hideVideoPlaybackResumeButtonEvent);
  }

  FutureOr<void> _initializeVideoPlaybackEvent(
      InitializeVideoPlaybackEvent event,
      Emitter<VideoPlaybackHiveState> emit) async {
    try {
      int? value = videoPlaybackHiveService.getValue(event.path);
      if (value != null) {
        emit(VideoPlaybackHiveState(showResumeButton: true, position: value));

        await Future.delayed(Duration(seconds: 6));
        emit(state.copyWith(showResumeButton: false));
      }
    } catch (e) {
      clog.error(e.toString());
    }
  }

  FutureOr<void> _updateVideoPlaybackEvent(
      UpdateVideoPlaybackEvent event, Emitter<VideoPlaybackHiveState> emit) {
    String videoPath = event.path;
    int position = event.position;

    try {
      videoPlaybackHiveService.update(videoPath, position);
      emit(state.copyWith(showResumeButton: false));
    } catch (e) {
      clog.error(e.toString());
    }
  }

  FutureOr<void> _hideVideoPlaybackResumeButtonEvent(
      HideVideoPlaybackResumeButtonEvent event,
      Emitter<VideoPlaybackHiveState> emit) {
    emit(state.copyWith(showResumeButton: false));
  }
}
