import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:open_player/data/models/audio_model.dart';

class CustomAudioSource extends ProgressiveAudioSource {
  final AudioModel audioModel;

  CustomAudioSource({
    required this.audioModel,
    Map<String, String>? headers,
    ProgressiveAudioSourceOptions? options,
  }) : super(
          Uri.file(audioModel.path),
          headers: headers ?? {'hashcode': audioModel.path.hashCode.toString()},
          tag: MediaItem(
            id: audioModel.path,
            album: audioModel.album,
            title: audioModel.title,
            genre: audioModel.genre.toString(),
            artist: audioModel.artists,
            artUri: audioModel.thumbnail.isNotEmpty
                ? Uri.dataFromBytes(
                    audioModel.thumbnail.first.bytes,
                    mimeType: audioModel.thumbnail.first.mimetype
                  )
                : null,
      
          ),
          options: options ??
              const ProgressiveAudioSourceOptions(
                androidExtractorOptions: AndroidExtractorOptions(
                  constantBitrateSeekingAlwaysEnabled: true,
                ),
                darwinAssetOptions:
                    DarwinAssetOptions(preferPreciseDurationAndTiming: true),
              ),
        );

  // Helper method to create a playlist from a list of AudioModel
  static ConcatenatingAudioSource createPlaylist(List<AudioModel> audioList) {
    return ConcatenatingAudioSource(
      children: audioList
          .map((audio) => CustomAudioSource(
                audioModel: audio,
              ))
          .toList(),
    );
  }

  // Get the underlying AudioModel
  AudioModel get model => audioModel;

  // Add custom methods to access audio properties
  String get title => audioModel.title;
  String get extension => audioModel.ext;
  String get filePath => audioModel.path;
  int get size => audioModel.size;
}
