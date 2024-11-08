import 'dart:io';
import 'package:color_log/color_log.dart';
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
    return AudioModel(
      title: path.basenameWithoutExtension(audioPath),
      ext: path.extension(audioPath),
      path: audioPath,
      size: File(audioPath).statSync().size,
      thumbnail: null,
      album:"" ,
      artists:[""] ,
      genre: "",
    );
  }
}
