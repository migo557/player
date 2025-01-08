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
  import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Abstract base class defining core functionality for audio file operations.
/// Implementations must provide methods for retrieving audio files and their metadata.
abstract class AudioRepositoryBase {
  Future<List<AudioModel>> getAllAudioFiles();
  Future<List<AudioModel>> getAudioFilesFromSingleDirectory(
      Directory directory);
  Future<AudioModel> getAudioInfo(String audioPath);
}

/// Implementation of [AudioRepositoryBase] that handles audio file discovery and metadata extraction.
///
/// This repository is responsible for:
/// - Scanning for audio files in the device storage
/// - Reading and parsing audio metadata
/// - Creating standardized [AudioModel] objects
/// - Handling error cases and providing fallback values
class AudioRepository implements AudioRepositoryBase {
  /// Provider that handles low-level audio file operations
  final AudioProvider audioProvider;

  AudioRepository(this.audioProvider);

  /// Retrieves all audio files from the device storage.
  ///
  /// Returns an empty list if:
  /// - Storage permissions are not granted
  /// - No audio files are found
  /// - An error occurs during file scanning
  @override
  Future<List<AudioModel>> getAllAudioFiles() async {
    try {
      final bool hasPermission = await AppPermissionService.storagePermission();

      if (!hasPermission) {
        clog.error('Storage permission not granted');
        clog.warning(' Let\'s Accessing it Storage permission again...');
        await AppPermissionService.storagePermission().then(
          (value) {
            clog.error(' Again Storage permission not granted');
          },
        );
        return [];
      }

      final List<String> audioPath =
          await audioProvider.fetchAllAudioFilePaths();
      final List<AudioModel> audios = await Future.wait(
        audioPath.map((audioPath) async {
          return await getAudioInfo(audioPath);
        }),
      );

      clog.info('Found ${audios.length} audio');
      return audios;
    } catch (e) {
      clog.error('Error fetching audio files: $e');
      return [];
    }
  }

  /// Retrieves audio files from a specific directory.
  ///
  /// [directory] The directory to scan for audio files.
  ///
  /// Returns an empty list if:
  /// - Storage permissions are not granted
  /// - The directory contains no audio files
  /// - An error occurs during file scanning
  @override
  Future<List<AudioModel>> getAudioFilesFromSingleDirectory(
      Directory directory) async {
    try {
      final bool hasPermission = await AppPermissionService.storagePermission();

      if (!hasPermission) {
        clog.error('Storage permission not granted');
        clog.warning(' Let\'s Accessing it Storage permission again...');
        await AppPermissionService.storagePermission().then(
          (value) {
            clog.error(' Again Storage permission not granted');
          },
        );
        return [];
      }

      final List<String> audioPath =
          await audioProvider.fetchAudioFilePathsFromSingleDirectory(directory);
      final List<AudioModel> audios = await Future.wait(
        audioPath.map((audioPath) async {
          return await getAudioInfo(audioPath);
        }),
      );

      clog.info('Found ${audios.length} audio');
      return audios;
    } catch (e) {
      clog.error('Error fetching audio files: $e');
      return [];
    }
  }

  /// Extracts metadata from an audio file and creates an [AudioModel].
  ///
  /// [audioPath] The path to the audio file.
  ///
  /// Returns a complete [AudioModel] with metadata if successful, or a placeholder
  /// model if the file is inaccessible or metadata cannot be read.
  ///
  /// This method handles various error cases and ensures that a valid model is
  /// always returned, maintaining application stability.
  @override
  Future<AudioModel> getAudioInfo(String audioPath) async {
    try {
      final File audioFile = File(audioPath);
      if (!await audioFile.exists()) {
        return _createPlaceholderAudioModel(audioPath);
      }

      dynamic metadata;
      try {
        metadata = readMetadata(audioFile, getImage: true);
      } catch (e) {
        clog.warning('Error reading metadata for $audioPath: $e');
        return _createPlaceholderAudioModel(audioPath);
      }

      // Extract metadata with safety checks
      final String title = _getSafeTitle(audioPath, metadata);
      final String artists = _getSafeArtist(metadata);
      final String album = _getSafeAlbum(metadata);
      final List<String> genre = _getSafeGenre(metadata);
      final int bitrate = metadata.bitrate ?? 0;
      final int sampleRate = metadata.sampleRate ?? 0;
      final String quality = _calculateSafeQuality(bitrate, sampleRate);
      final List<PictureModel> thumbnails = _getSafeThumbnails(metadata);

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
        year: metadata.year ?? DateTime(0000),
        quality: quality,
        lastModified: audioFile.lastModifiedSync(),
        lastAccessed: audioFile.lastAccessedSync(),
        id:  generateAudioId(audioPath, DateTime.now()),
      );
    } catch (e) {
      clog.error('Error processing audio file $audioPath: $e');
      return _createPlaceholderAudioModel(audioPath);
    }
  }

  /// Safely extracts the title from metadata or falls back to filename.
  /// Handles null values and cleanup of problematic characters.
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

  /// Safely extracts artist information from metadata.
  /// Returns "unknown" if no valid artist data is found.
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

  /// Safely extracts album information from metadata.
  /// Returns "unknown" if no valid album data is found.
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

  /// Safely extracts genre information from metadata.
  /// Returns an empty list if no valid genre data is found.
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

  /// Calculates audio quality based on bitrate and sample rate.
  /// Returns "unknown" if values are invalid or calculation fails.
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

  /// Safely extracts thumbnail data from metadata.
  /// Returns an empty list if no valid thumbnail data is found or processing fails.
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

  /// Cleans up text by removing problematic characters and whitespace.
  /// Returns an empty string if input is null or empty.
  String _cleanupText(String? text) {
    if (text == null || text.trim().isEmpty) return "";
    return text
        .replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '') // Remove control characters
        .trim()
        .replaceAll(
            RegExp(r'[^\x20-\x7E\x80-\xFF]'), ''); // Keep printable chars
  }

  /// Creates a placeholder [AudioModel] for cases where metadata cannot be read.
  /// Uses basic file information where available and provides default values.
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
      id: generateAudioId(audioPath, DateTime.now()),
      quality: "unknown",
      lastModified: audioFile.existsSync()
          ? audioFile.lastModifiedSync()
          : DateTime.now(),
      lastAccessed: audioFile.existsSync()
          ? audioFile.lastAccessedSync()
          : DateTime.now(),
    );
  }



int generateAudioId(String audioPath, DateTime lastModified) {
  // Combine path and timestamp for uniqueness
  final String combinedString = '$audioPath${lastModified.millisecondsSinceEpoch}';
  
  // Generate SHA-256 hash
  final bytes = utf8.encode(combinedString);
  final hash = sha256.convert(bytes);
  
  // Convert first 8 bytes of hash to integer
  final int id = hash.bytes.sublist(0, 8).fold<int>(0, 
    (int prev, int byte) => (prev << 8) | byte);
  
  // Ensure positive value by using unsigned right shift
  return id >>> 0;
}
}
