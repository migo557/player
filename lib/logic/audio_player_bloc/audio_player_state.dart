part of 'audio_player_bloc.dart';

sealed class AudioPlayerState extends Equatable {
  const AudioPlayerState();
}

final class AudioPlayerInitialState extends AudioPlayerState {
  @override
  List<Object?> get props => [];
}

final class AudioPlayerLoadingState extends AudioPlayerState {
  @override
  List<Object?> get props => [];
}

class AudioPlayerSuccessState extends AudioPlayerState {
  const AudioPlayerSuccessState({
    required this.audioPlayer,
    required this.isSeeking,
    required this.seekingPosition,
    required this.audioPlayerCombinedStream,
  });

  final AudioPlayer audioPlayer;
  final bool isSeeking;
  final double seekingPosition;
  final Stream<AudioPlayerCombinedStream> audioPlayerCombinedStream;

  @override
  List<Object?> get props => [
        audioPlayer,
        audioPlayerCombinedStream,
        isSeeking,
        seekingPosition,
      ];


  AudioPlayerSuccessState copyWith({
    AudioPlayer? audioPlayer,
    bool? isSeeking,
    double? seekingPosition,
    Stream<AudioPlayerCombinedStream>? audioPlayerCombinedStream,
  }) {
    return AudioPlayerSuccessState(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isSeeking: isSeeking ?? this.isSeeking,
      seekingPosition: seekingPosition ?? this.seekingPosition,
      audioPlayerCombinedStream: audioPlayerCombinedStream ?? this.audioPlayerCombinedStream,
    );
  }
}

class AudioPlayerErrorState extends AudioPlayerState {
  const AudioPlayerErrorState({required this.errorMessage});

  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}
