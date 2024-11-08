// video_player/presentation/pages/video_player_page.dart

class VlcPlayerValue {
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final bool isBuffering;
  final bool isEnded;
  final int volume;
  final double playbackSpeed;

  const VlcPlayerValue({
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.isBuffering = false,
    this.volume = 100,
    this.playbackSpeed = 1.0,
    this.isEnded = false,
  });

  VlcPlayerValue copyWith({
    Duration? position,
    Duration? duration,
    bool? isPlaying,
    bool? isBuffering,
    int? volume,
    double? playbackSpeed,
  }) {
    return VlcPlayerValue(
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      isBuffering: isBuffering ?? this.isBuffering,
      volume: volume ?? this.volume,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
    );
  }
}
