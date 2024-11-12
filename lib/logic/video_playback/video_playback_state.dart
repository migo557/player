part of 'video_playback_bloc.dart';

class VideoPlaybackHiveState extends Equatable {
  const VideoPlaybackHiveState(
      {required this.showResumeButton, required this.position});

  final bool showResumeButton;
  final int position;

  VideoPlaybackHiveState copyWith({bool? showResumeButton, int? position}) {
    return VideoPlaybackHiveState(
        showResumeButton: showResumeButton ?? this.showResumeButton,
        position: position ?? this.position);
  }

  @override
  List<Object> get props => [showResumeButton, position];
}
