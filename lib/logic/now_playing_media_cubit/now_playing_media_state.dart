part of 'now_playing_media_cubit.dart';

class NowPlayingMediaState extends Equatable {
  const NowPlayingMediaState({required this.audioList});
  final List<AudioModel> audioList;

  factory NowPlayingMediaState.initial() => const NowPlayingMediaState(audioList: []);

  @override
  List<Object> get props => [audioList];
}
