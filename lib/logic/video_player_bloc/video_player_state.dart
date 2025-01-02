// video_player_state.dart
part of 'video_player_bloc.dart';

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
  const VideoPlayerReadyState({
    required this.vlcPlayerController,
    required this.playingVideoPath,
    required this.currentVideo
  });
  final VlcPlayerController vlcPlayerController;
  final String playingVideoPath;
  final VideoModel currentVideo;

  @override
  List<Object> get props => [
        vlcPlayerController,
        playingVideoPath,
      ];
}

/// Error state when video playback fails
final class VideoPlayerErrorState extends VideoPlayerState {
  final String message;

  const VideoPlayerErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
