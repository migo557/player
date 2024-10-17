import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/audio_music_model.dart';

class AudioProvider {
  /// A list of supported audio file formats.
  static const List<String> _supportedFormats = [
    '.mp3',
    '.flac',
    '.wav',
    '.m4a',
    '.aac',
    '.ogg',
    '.wma'
  ];

  /// Fetches audio files from external storage directories and extracts their metadata.
  ///
  /// Returns a list of [AudioFileModel] containing metadata for each audio file found.
  /// This operation can be time-consuming due to file scanning and metadata extraction,
  /// so it should be called from an asynchronous context.
  Future<List<AudioFileModel>> fetchAudioFilesWithMetadata() async {
    List<AudioFileModel> audioFiles = [];
    List<Directory>? directories = await getExternalStorageDirectories();

    // Check if directories were retrieved successfully
    if (directories != null && directories.isNotEmpty) {
      for (var directory in directories) {
        // Use compute to run the file scanning in a separate isolate
        List<String> files = await compute(scanAudioFiles, directory.path);
        for (var filePath in files) {
          final audioFile = await _extractMetadata(filePath);
          if (audioFile != null) {
            audioFiles.add(audioFile);
          }
        }
      }
    }

    return audioFiles;
  }

  /// Extracts metadata from a given audio file.
  ///
  /// Takes the file path as input and returns an [AudioFileModel] containing its metadata.
  /// If an error occurs during metadata extraction, it logs the error and returns null.
  Future<AudioFileModel?> _extractMetadata(String filePath) async {
    try {
      // final FileMetaData fileMetadata =
      // await FlutterMediaMetadataNew.getMetadata(filePath);
      // return AudioFileModel(
      //     trackName: fileMetadata.trackName ?? "Unknown Name",
      //     albumName: fileMetadata.albumName ?? "Unknown",
      //     trackArtistNames: fileMetadata.trackArtistNames ?? ["Unknown"],
      //     albumArtistName: fileMetadata.albumArtistName ?? "Unknown",
      //     albumArt: fileMetadata.albumArt,
      //     authorName: fileMetadata.authorName ?? "Unknwon",
      //     bitrate: fileMetadata.bitrate ?? 0,
      //     albumLength: fileMetadata.albumLength ?? 0,
      //     discNumber: fileMetadata.discNumber ?? 0,
      //     filePath: filePath,
      //     genre: fileMetadata.genre ?? "Unknwon",
      //     mimeType: fileMetadata.mimeType ?? "Unknwon",
      //     trackDuration: fileMetadata.trackDuration ?? 0,
      //     trackNumber: fileMetadata.trackNumber ?? 0,
      //     writerName: fileMetadata.writerName ?? "Unknwon",
      //     year: fileMetadata.year ?? 0000);
    } catch (e) {
      log('Error fetching metadata for $filePath: $e');
      return null;
    }
    return null;
  }
}

/// Scans a directory for audio files with supported formats.
///
/// Takes the root path of the directory as input and returns a list of file paths
/// for audio files found within that directory. The scanning is done recursively
/// to include files in subdirectories. If an error occurs, it logs the error.
List<String> scanAudioFiles(String rootPath) {
  List<String> audioFilePaths = [];
  Directory directory = Directory(rootPath);
  try {
    // List all files in the directory and its subdirectories
    directory.listSync(recursive: true, followLinks: false).forEach((entity) {
      if (entity is File) {
        String extension = entity.path.split('.').last.toLowerCase();
        // Check if the file's extension is in the supported formats list
        if (AudioProvider._supportedFormats.contains('.$extension')) {
          audioFilePaths.add(entity.path);
        }
      }
    });
  } catch (e) {
    log('Error scanning directory: $e');
  }
  return audioFilePaths;
}
