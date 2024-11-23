import 'dart:io';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:color_log/color_log.dart';
import 'package:open_player/data/services/favorite_audio_hive_service/audio_hive_service.dart';
import '../../../base/services/permissions/app_permission_service.dart';
import 'package:path/path.dart' as path;
import '../../models/audio_model.dart';
import '../../providers/audio/audio_provider.dart';

class AudioRepository {
  final AudioProvider audioProvider;

  AudioRepository(this.audioProvider);

  Future<List<AudioModel>> getAudioFiles() async {
    try {
      final bool hasPermission = await AppPermissionService.storagePermission();

      if (!hasPermission) {
        clog.error('Storage permission not granted');
        clog.warning(' Let;s Accessing it Storage permission again...');
        await AppPermissionService.storagePermission().then(
          (value) {
            clog.error(' Again Storage permission not granted');
          },
        );
        return [];
      }

      final List<String> audioPath =
          await audioProvider.fetchAllAudioFilePaths();

      final List<AudioModel> audios =
          await Future.wait(audioPath.map((audioPath) async {
        return await getAudioInfo(audioPath);
      }));

      clog.info('Found ${audios.length} audio');
      return audios;
    } catch (e) {
      clog.error('Error fetching audio files: $e');
      return [];
    }
  }

  Future<AudioModel> getAudioInfo(String audioPath) async {
    // Getting the image of a track can be heavy and slow the reading
    final metadata = readMetadata(File(audioPath), getImage: true);

    metadata.year;

    return AudioModel(
      title: path.basenameWithoutExtension(audioPath),
      ext: path.extension(audioPath),
      path: audioPath,
      size: File(audioPath).statSync().size,
      thumbnail: metadata.pictures,
      album: metadata.album ?? "unknown",
      artists: metadata.artist ?? "unknown",
      genre: metadata.genres,
      bitrate: metadata.bitrate,
      lyrics: metadata.lyrics,
      sampleRate: metadata.sampleRate,
      language: metadata.language,
      year: metadata.year
    );
  }
}
