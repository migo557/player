import 'dart:io';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:color_log/color_log.dart';
import 'package:open_player/data/models/picture_model.dart';
import 'package:open_player/utils/audio_quality_calculator.dart';
import '../../../base/services/permissions/app_permission_service.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import '../../models/audio_model.dart';
import '../../providers/audio/audio_provider.dart';

abstract class AudioRepositoryBase {
  Future<List<AudioModel>> getAllAudioFiles();

  Future<List<AudioModel>> getAudioFilesFromSingleDirectory(
      Directory directory);

  Future<AudioModel> getAudioInfo(String audioPath);
}

class AudioRepository implements AudioRepositoryBase {
  final AudioProvider audioProvider;

  AudioRepository(this.audioProvider);

  @override
  Future<List<AudioModel>> getAllAudioFiles() async {
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

  @override
  Future<List<AudioModel>> getAudioFilesFromSingleDirectory(
      Directory directory) async {
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
          await audioProvider.fetchAudioFilePathsFromSingleDirectory(directory);

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

  @override
  Future<AudioModel> getAudioInfo(String audioPath) async {
    // Getting the image of a track can be heavy and slow the reading
    final metadata = readMetadata(File(audioPath), getImage: true);
    // Calculate audio quality
    final quality = AudioQualityCalculator.calculateQuality(
      bitrate: metadata.bitrate,
      sampleRate: metadata.sampleRate,
      // codec: metadata.format, // If available in your metadata
    );

    //----Thumbnail <I Made this My Custom PictureModel instead of using metadata package inbuilt Picture class for to compaitable with Hive>
    final List<PictureModel> thumbnails = metadata.pictures.map(
      (e) {
        return PictureModel(
          bytes: e.bytes,
          mimetype: e.mimetype,
        );
      },
    ).toList();

    return AudioModel(
      title: path.basenameWithoutExtension(audioPath),
      ext: path.extension(audioPath),
      path: audioPath,
      size: File(audioPath).statSync().size,
      thumbnail: thumbnails,
      album: metadata.album ?? "unknown",
      artists: metadata.artist ?? "unknown",
      genre: metadata.genres,
      bitrate: metadata.bitrate,
      lyrics: metadata.lyrics,
      sampleRate: metadata.sampleRate,
      language: metadata.language,
      year: metadata.year,
      quality: quality,
      lastModified: File(audioPath).lastModifiedSync(),
      lastAccessed: File(audioPath).lastAccessedSync(),
    );
  }
}
