// video_player_state.dart
part of 'video_player_bloc.dart';

/// Settings model to encapsulate all video player settings
class VideoPlayerSettings extends Equatable {
  final bool showSubtitles;
  final bool playInBackground;
  final bool showControls;
  final bool useHardwareAcceleration;

  const VideoPlayerSettings({
    this.showSubtitles = true,
    this.playInBackground = false,
    this.showControls = true,
    this.useHardwareAcceleration = true,
  });

  VideoPlayerSettings copyWith({
    bool? showSubtitles,
    bool? playInBackground,
    bool? showControls,
    bool? useHardwareAcceleration,
  }) {
    return VideoPlayerSettings(
      showSubtitles: showSubtitles ?? this.showSubtitles,
      playInBackground: playInBackground ?? this.playInBackground,
      showControls: showControls ?? this.showControls,
      useHardwareAcceleration: useHardwareAcceleration ?? this.useHardwareAcceleration,
    );
  }

  @override
  List<Object?> get props => [
    showSubtitles,
    playInBackground,
    showControls,
    useHardwareAcceleration,
  ];
}

/// Base state class for video player
sealed class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object> get props => [];
}

/// Initial state before video player initialization
final class VideoPlayerInitialState extends VideoPlayerState {
  const VideoPlayerInitialState();
}

/// Loading state while video is being prepared
final class VideoPlayerLoadingState extends VideoPlayerState {
  const VideoPlayerLoadingState();
}

/// State when video is ready to play
final class VideoPlayerReadyState extends VideoPlayerState {
  final VideoController controller;
  final VideoPlayerSettings settings;

  const VideoPlayerReadyState({
    required this.controller,
    required this.settings,
  });

  VideoPlayerReadyState copyWith({
    VideoController? controller,
    VideoPlayerSettings? settings,
  }) {
    return VideoPlayerReadyState(
      controller: controller ?? this.controller,
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object> get props => [controller, settings];
}

/// Error state when video playback fails
final class VideoPlayerErrorState extends VideoPlayerState {
  final String message;

  const VideoPlayerErrorState({required this.message});

  @override
  List<Object> get props => [message];
}