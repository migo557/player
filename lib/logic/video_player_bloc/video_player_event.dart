// video_player_event.dart
part of 'video_player_bloc.dart';

/// Base event class for video player
sealed class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object> get props => [];
}

/// Event to initialize video playback
final class VideoInitializeEvent extends VideoPlayerEvent {
  final int videoIndex;
  final List<VideoModel> playlist;

  const VideoInitializeEvent({
    required this.videoIndex,
    required this.playlist,
  });

  @override
  List<Object> get props => [videoIndex, playlist];
}

/// Event to stop video playback
final class VideoStopEvent extends VideoPlayerEvent {}

final class VideoPlayPauseToggleEvent extends VideoPlayerEvent {}


/// Event to toggle subtitle visibility
final class ToggleSubtitlesEvent extends VideoPlayerEvent {}

/// Event to toggle background playback
final class ToggleBackgroundPlaybackEvent extends VideoPlayerEvent {}




