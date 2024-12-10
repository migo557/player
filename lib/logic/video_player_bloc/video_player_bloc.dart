import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:open_player/data/services/video/video_player_services.dart';
import '../../base/di/injection.dart';
import '../../data/models/video_model.dart';
part 'video_player_event.dart';
part 'video_player_state.dart';

/// BLoC for managing video player state and functionality
class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  Timer? buttonVisibility;
  VideoPlayerService videoPlayerServices = locator<VideoPlayerService>();

  VideoPlayerBloc() : super(const VideoPlayerInitialState()) {
    on<VideoInitializeEvent>(_videoInitialization);
    on<VideoStopEvent>(_videoStop);
    on<VideoPlayPauseToggleEvent>(_videoPlayPause);
  }

  FutureOr<void> _videoInitialization(
      VideoInitializeEvent event, Emitter<VideoPlayerState> emit) {
    videoPlayerServices.videoInitialization(event, emit);
  }

  FutureOr<void> _videoStop(
      VideoStopEvent event, Emitter<VideoPlayerState> emit) {
    videoPlayerServices.videoStop(event, emit);
  }

  FutureOr<void> _videoPlayPause(
      VideoPlayPauseToggleEvent event, Emitter<VideoPlayerState> emit) {}
}
