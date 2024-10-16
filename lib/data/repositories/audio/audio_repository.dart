import 'dart:developer';
import 'package:open_player/data/models/audio_music_model.dart';

import '../../providers/audio/audio_provider.dart';

class AudioRepository {
  final AudioProvider _audioProvider;

  AudioRepository(this._audioProvider);

  Future<List<AudioFileModel>> getAudioFiles() async {
    try {
      final List<AudioFileModel> tracks =
          await _audioProvider.fetchAudioFilesWithMetadata();
      return tracks; // Already filtered by AudioProvider
    } catch (e) {
      log('Error fetching audio files: $e');
      return [];
    }
  }
}
