import 'dart:io';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:color_log/color_log.dart';
import 'package:flutter/services.dart';
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
    try {
      final File audioFile = File(audioPath);
      if (!await audioFile.exists()) {
        // Return a placeholder model instead of throwing to prevent bloc state disruption
        return _createPlaceholderAudioModel(audioPath);
      }

      // Wrap metadata reading in try-catch to handle parsing errors
      dynamic metadata;
      try {
        metadata = readMetadata(audioFile, getImage: true);
      } catch (e) {
        clog.warning('Error reading metadata for $audioPath: $e');
        return _createPlaceholderAudioModel(audioPath);
      }

      // Safe extraction of metadata with null handling
      final String title = _getSafeTitle(audioPath, metadata);
      final String artists = _getSafeArtist(metadata);
      final String album = _getSafeAlbum(metadata);
      final List<String> genre = _getSafeGenre(metadata);
      final int bitrate = metadata.bitrate ?? 0;
      final int sampleRate = metadata.sampleRate ?? 0;
      final String quality = _calculateSafeQuality(bitrate, sampleRate);
      final List<PictureModel> thumbnails = _getSafeThumbnails(metadata);

      // Create the audio model with safe values
      return AudioModel(
        title: title,
        ext: path.extension(audioPath),
        path: audioPath,
        size: audioFile.statSync().size,
        thumbnail: thumbnails,
        album: album,
        artists: artists,
        genre: genre,
        bitrate: bitrate,
        lyrics: metadata.lyrics?.trim() ?? "",
        sampleRate: sampleRate,
        language: metadata.language?.trim() ?? "",
        year: metadata.year ?? 0,
        quality: quality,
        lastModified: audioFile.lastModifiedSync(),
        lastAccessed: audioFile.lastAccessedSync(),
      );
    } catch (e) {
      clog.error('Error processing audio file $audioPath: $e');
      // Return placeholder instead of throwing to maintain bloc state
      return _createPlaceholderAudioModel(audioPath);
    }
  }

// Helper methods for safe value extraction
  String _getSafeTitle(String audioPath, dynamic metadata) {
    try {
      final String fileName = path.basenameWithoutExtension(audioPath);
      final String? metadataTitle = metadata.title;
      return (metadataTitle != null && metadataTitle.trim().isNotEmpty)
          ? _cleanupText(metadataTitle)
          : _cleanupText(fileName);
    } catch (e) {
      return path.basenameWithoutExtension(audioPath);
    }
  }

  String _getSafeArtist(dynamic metadata) {
    try {
      final String? artist = metadata.artist;
      return (artist != null && artist.trim().isNotEmpty)
          ? _cleanupText(artist)
          : "unknown";
    } catch (e) {
      return "unknown";
    }
  }

  String _getSafeAlbum(dynamic metadata) {
    try {
      final String? album = metadata.album;
      return (album != null && album.trim().isNotEmpty)
          ? _cleanupText(album)
          : "unknown";
    } catch (e) {
      return "unknown";
    }
  }

  List<String> _getSafeGenre(dynamic metadata) {
    try {
      final genres = metadata.genres;
      if (genres != null && genres is List) {
        return genres
            .map((g) => _cleanupText(g.toString()))
            .where((g) => g.isNotEmpty)
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  String _calculateSafeQuality(int bitrate, int sampleRate) {
    try {
      if (bitrate > 0 && sampleRate > 0) {
        return AudioQualityCalculator.calculateQuality(
          bitrate: bitrate,
          sampleRate: sampleRate,
        );
      }
      return "unknown";
    } catch (e) {
      return "unknown";
    }
  }

  List<PictureModel> _getSafeThumbnails(dynamic metadata) {
    try {
      if (metadata.pictures != null) {
        return metadata.pictures.map<PictureModel>((e) {
          return PictureModel(
            bytes: e.bytes ?? Uint8List(0),
            mimetype: e.mimetype ?? "image/jpeg",
          );
        }).toList();
      }
      return [];
    } catch (e) {
      clog.warning('Error processing thumbnails: $e');
      return [];
    }
  }

  String _cleanupText(String? text) {
    if (text == null || text.trim().isEmpty) return "";
    return text
        .replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '')
        .trim()
        .replaceAll(RegExp(r'[^\x20-\x7E\x80-\xFF]'), '');
  }

  AudioModel _createPlaceholderAudioModel(String audioPath) {
    final File audioFile = File(audioPath);
    return AudioModel(
      title: path.basenameWithoutExtension(audioPath),
      ext: path.extension(audioPath),
      path: audioPath,
      size: audioFile.existsSync() ? audioFile.statSync().size : 0,
      thumbnail: [],
      album: "unknown",
      artists: "unknown",
      genre: [],
      bitrate: 0,
      lyrics: "",
      sampleRate: 0,
      language: "",
      year: DateTime(0000),
      quality: "unknown",
      lastModified: audioFile.existsSync()
          ? audioFile.lastModifiedSync()
          : DateTime.now(),
      lastAccessed: audioFile.existsSync()
          ? audioFile.lastAccessedSync()
          : DateTime.now(),
    );
  }
}
