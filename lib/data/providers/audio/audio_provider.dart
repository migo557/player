import 'dart:io';
import 'dart:isolate';
import 'package:color_log/color_log.dart';
import 'package:path/path.dart' as path;

/// A provider class that handles audio file operations
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

  /// Fetches all audio file paths from external storage directories
  /// Returns a list of audio file paths
  Future<List<String>> fetchAllAudioFilePaths() async {
    List<String> audioFiles = [];

    // Define potential directories
    List<Directory> directories = [
      Directory("/storage/emulated/0/"), // Internal storage
      Directory("/storage/sdcard1/"), // External storage
      Directory("/storage/extsd/") // SD card
    ];

    try {
      // Create a list to store all futures from isolates
      List<Future<List<String>>> futures = [];

      for (var directory in directories) {
        // Check if the directory exists before scanning
        if (await directory.exists()) {
          clog.info("ExternalStorageDirectory Path: ${directory.path}");
          futures.add(_scanInIsolate(directory.path));
        } else {
          clog.warning("Directory does not exist: ${directory.path}");
        }
      }

      // Wait for all isolates to complete and combine results
      final results = await Future.wait(futures);
      for (var result in results) {
        audioFiles.addAll(result);
      }
    } catch (e) {
      clog.error('Error in fetchAllAudioFilePaths: ${e.toString()}');
    }

    return audioFiles;
  }

  /// Creates an isolate to scan for audio files in the given directory
  /// Returns a future that completes with the list of audio paths
  Future<List<String>> _scanInIsolate(String directoryPath) async {
    final receivePort = ReceivePort();

    try {
      await Isolate.spawn(
          scanAudioFiles, [receivePort.sendPort, directoryPath]);

      // Get the result from the isolate
      final result = await receivePort.first as List<String>;
      return result;
    } catch (e) {
      clog.error('Error in _scanInIsolate: ${e.toString()}');
      return [];
    } finally {
      receivePort.close();
    }
  }
}

/// The isolate worker function that scans for audio files
/// Args should contain [SendPort, String] where String is the directory path
void scanAudioFiles(List<dynamic> args) {
  List<String> audioFilePaths = [];
  SendPort sendPort = args[0];
  final directoryPath = args[1];

  try {
    _scanDirectory(Directory(directoryPath), audioFilePaths);
    sendPort.send(audioFilePaths);
  } catch (e) {
    clog.error('Error in scanAudioFiles isolate: $e');
  }
}

void _scanDirectory(Directory directory, List<String> audioFilePaths) {
  try {
    if (directory.path.contains('/Android')) return;

    directory.listSync(recursive: false, followLinks: false).forEach((entity) {
      if (entity is Directory) {
        _scanDirectory(entity, audioFilePaths);
      } else if (entity is File) {
        String ext = path.extension(entity.path).toLowerCase();
        if (AudioProvider._supportedFormats.contains(ext)) {
          audioFilePaths.add(entity.path);
        }
      }
    });
  } catch (e) {
    clog.error('Error scanning directory ${directory.path}: $e');
  }
}
