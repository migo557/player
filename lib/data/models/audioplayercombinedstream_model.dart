import 'package:just_audio/just_audio.dart';

class AudioPlayerStreamCombiner {
  bool playing;
  Duration position;
  Duration? duration;
  Duration bufferedPosition;
  ProcessingState processingState;
  double speed;
  LoopMode loopMode;
  bool shuffleModeEnabled;
  int? currentIndex;
  AudioPlayerStreamCombiner({
    required this.playing,
    required this.position,
    required this.duration,
    required this.bufferedPosition,
    required this.processingState,
    required this.speed,
    required this.loopMode,
    required this.shuffleModeEnabled,
    required this.currentIndex,
  });
}
