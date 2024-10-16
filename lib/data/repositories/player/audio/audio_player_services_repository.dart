import 'package:just_audio/just_audio.dart';

/// Abstract repository for audio player services.
abstract class AudioPlayerServicesRepository {
  /// Toggles play/pause state of the audio player.
  Future<void> playPauseAudio();
}

/// Implementation of the [AudioPlayerServicesRepository] using the Just Audio package.
final class AudioPlayerServices implements AudioPlayerServicesRepository {
  /// Creates an instance of [AudioPlayerServices].
  ///
  /// Requires an [AudioPlayer] instance to control audio playback.
  AudioPlayerServices({required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  Future<void> playPauseAudio() async {
    // Check if the audio is currently playing
    if (audioPlayer.playing) {
      // Pause the audio if it is currently playing
      await audioPlayer.pause();
    } else {
      // Play the audio if it is currently paused
      await audioPlayer.play();
    }
  }
}
