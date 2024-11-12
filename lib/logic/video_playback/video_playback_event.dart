part of 'video_playback_bloc.dart';

sealed class VideoPlaybackEvent extends Equatable {
  const VideoPlaybackEvent();

  @override
  List<Object> get props => [];
}

class InitializeVideoPlaybackEvent extends VideoPlaybackEvent {
  const InitializeVideoPlaybackEvent({required this.path});
  final String path;

  @override
  List<Object> get props => [path];
}

class UpdateVideoPlaybackEvent extends VideoPlaybackEvent {
  const UpdateVideoPlaybackEvent(this.position, {required this.path});
  final String path;
  final int position;

  @override
  List<Object> get props => [path, position];
}

class HideVideoPlaybackResumeButtonEvent extends VideoPlaybackEvent {}
