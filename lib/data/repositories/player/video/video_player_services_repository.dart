import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../../base/di/dependency_injection.dart';
import '../../../../logic/video_player_bloc/video_player_bloc.dart';
import '../../../models/video_model.dart';

/// Logger instance for video player related logs
final _logger = Logger();

/// Abstract repository for video player services.
abstract class VideoPlayerServicesRepository {
  /// Initializes the video player with the given playlist and starting index
  Future<void> handleVideoInitialization(
      VideoInitializeEvent event, Emitter<VideoPlayerState> emit);

  /// Initializes video playback with the given playlist and index
  Future<void> initializePlayback(List<Media> playlist, int startIndex);

  /// Creates a video controller with default configuration
  VideoController createVideoController();

  /// Creates a media playlist from video models
  List<Media> createPlaylistFromVideos(List<VideoModel> videos);

  /// Handles stopping video playback
  Future<void> handleVideoStop(
      VideoStopEvent event, Emitter<VideoPlayerState> emit);

  /// Manages visibility of player controls with auto-hide timer
  Future<void> handleControlsVisibilityToggle(
    ToggleControlsVisibilityEvent event,
    Emitter<VideoPlayerState> emit,
    VideoPlayerState state,
  );

  /// Toggles background playback mode
  void handleBackgroundPlaybackToggle(ToggleBackgroundPlaybackEvent event,
      Emitter<VideoPlayerState> emit, VideoPlayerState state);

  /// Toggles hardware acceleration
  void handleHardwareAccelerationToggle(ToggleHardwareAccelerationEvent event,
      Emitter<VideoPlayerState> emit, VideoPlayerState state);

  /// Toggles subtitle visibility
  void handleSubtitlesToggle(ToggleSubtitlesEvent event,
      Emitter<VideoPlayerState> emit, VideoPlayerState state);
}

/// Implementation of the [VideoPlayerServicesRepository] using the Media Kit.
final class VideoPlayerServices implements VideoPlayerServicesRepository {
  // final Player player;
  Timer? _buttonsVisibilityTimer;
  Player player;
  VideoPlayerServices({required this.player});

  /// Initializes the video player with the given playlist and starting index
  @override
  Future<void> handleVideoInitialization(
      VideoInitializeEvent event, Emitter<VideoPlayerState> emit) async {
    try {
      VideoPlayerServices videoPlayerServices =
          VideoPlayerServices(player: locator<Player>());
      emit(const VideoPlayerLoadingState());

      final playlist =
          videoPlayerServices.createPlaylistFromVideos(event.playlist);
      final controller = videoPlayerServices.createVideoController();

      await videoPlayerServices.initializePlayback(playlist, event.videoIndex);

      emit(VideoPlayerReadyState(
        controller: controller,
        settings: const VideoPlayerSettings(),
      ));
    } catch (error, stackTrace) {
      _logger.e('Failed to initialize video player',
          error: error, stackTrace: stackTrace);
      emit(VideoPlayerErrorState(message: error.toString()));
    }
  }

  @override
  Future<void> initializePlayback(List<Media> playlist, int startIndex) async {
    await player.open(
      Playlist(playlist, index: startIndex),
      play: true,
    );
    await player.play();
  }

  /// Creates a video controller with default configuration
  @override
  VideoController createVideoController() {
    return VideoController(
      player,
      configuration: VideoPlayerConstants.defaultControllerConfig,
    );
  }

  /// Creates a media playlist from video models
  @override
  List<Media> createPlaylistFromVideos(List<VideoModel> videos) {
    return videos.map((video) => Media(video.path)).toList();
  }

  /// Handles stopping video playback
  @override
  Future<void> handleVideoStop(
      VideoStopEvent event, Emitter<VideoPlayerState> emit) async {
    try {
      await player.stop();
    } catch (error, stackTrace) {
      _logger.e('Failed to stop video player',
          error: error, stackTrace: stackTrace);
      emit(VideoPlayerErrorState(message: error.toString()));
    }
  }

  /// Manages visibility of player controls with auto-hide timer
  @override
  Future<void> handleControlsVisibilityToggle(
    ToggleControlsVisibilityEvent event,
    Emitter<VideoPlayerState> emit,
    VideoPlayerState state,
  ) async {
    if (state is! VideoPlayerReadyState) return;
    final currentState = state;

    // Show controls immediately
    emit(currentState.copyWith(
        settings: currentState.settings.copyWith(showControls: true)));

    // Reset auto-hide timer
    _buttonsVisibilityTimer?.cancel();
    _buttonsVisibilityTimer = Timer(
        VideoPlayerConstants.buttonVisibilityDuration,
        () => emit(currentState.copyWith(
            settings: currentState.settings.copyWith(showControls: false))));
  }

  /// Toggles background playback mode
  @override
  void handleBackgroundPlaybackToggle(ToggleBackgroundPlaybackEvent event,
      Emitter<VideoPlayerState> emit, VideoPlayerState state) {
    if (state is! VideoPlayerReadyState) return;
    final currentState = state;

    emit(currentState.copyWith(
        settings: currentState.settings.copyWith(
            playInBackground: !currentState.settings.playInBackground)));
  }

  /// Toggles hardware acceleration
  @override
  void handleHardwareAccelerationToggle(ToggleHardwareAccelerationEvent event,
      Emitter<VideoPlayerState> emit, VideoPlayerState state) {
    if (state is! VideoPlayerReadyState) return;
    final currentState = state;

    final newHWState = !currentState.settings.useHardwareAcceleration;
    final newController = VideoController(
      player,
      configuration:
          VideoControllerConfiguration(enableHardwareAcceleration: newHWState),
    );

    emit(currentState.copyWith(
        controller: newController,
        settings: currentState.settings
            .copyWith(useHardwareAcceleration: newHWState)));
  }

  /// Toggles subtitle visibility
  @override
  void handleSubtitlesToggle(ToggleSubtitlesEvent event,
      Emitter<VideoPlayerState> emit, VideoPlayerState state) {
    if (state is! VideoPlayerReadyState) return;
    final currentState = state;

    emit(currentState.copyWith(
        settings: currentState.settings
            .copyWith(showSubtitles: !currentState.settings.showSubtitles)));
  }
}
