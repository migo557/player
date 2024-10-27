import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:open_player/data/repositories/player/video/video_player_services_repository.dart';
import '../../base/di/dependency_injection.dart';
import '../../data/models/video_model.dart';
part 'video_player_event.dart';
part 'video_player_state.dart';

/// Constants for video player configuration
class VideoPlayerConstants {
  static const Duration buttonVisibilityDuration = Duration(seconds: 3);
  static const VideoControllerConfiguration defaultControllerConfig =
      VideoControllerConfiguration(enableHardwareAcceleration: true);
}

/// BLoC for managing video player state and functionality
class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerServices videoPlayerServices = locator<VideoPlayerServices>();

  VideoPlayerBloc() : super(const VideoPlayerInitialState()) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<VideoInitializeEvent>(videoPlayerServices.handleVideoInitialization);
    on<VideoStopEvent>(videoPlayerServices.handleVideoStop);
    on<ToggleControlsVisibilityEvent>(
      (event, emit) {
        videoPlayerServices.handleControlsVisibilityToggle(event, emit, state);
      },
    );
    on<ToggleSubtitlesEvent>(
      (event, emit) {
        videoPlayerServices.handleSubtitlesToggle(event, emit, state);
      },
    );
    on<ToggleBackgroundPlaybackEvent>(
      (event, emit) {
        videoPlayerServices.handleBackgroundPlaybackToggle(event, emit, state);
      },
    );

    on<ToggleHardwareAccelerationEvent>(
      (event, emit) {
        videoPlayerServices.handleHardwareAccelerationToggle(
            event, emit, state);
      },
    );
  }
}
