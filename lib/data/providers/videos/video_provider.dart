import 'dart:io';
import 'dart:isolate';
import 'package:color_log/color_log.dart';
import 'package:path/path.dart' as path;

/// A provider class that handles video file operations
class VideoProvider {
  /// List of supported video file extensions
  static const List<String> _supportedFormats = [
    '.mp4',
    '.avi',
    '.mov',
    '.mkv',
    '.wmv',
    '.flv',
    '.webm',
    '.m4v',
  ];

  /// Fetches all video file paths from external storage directories
  /// Returns a list of video file paths
  Future<List<String>> fetchAllVideoFilePaths() async {
    List<String> videoFiles = [];

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
        videoFiles.addAll(result);
      }
    } catch (e) {
      clog.error('Error in fetchAllVideoFilePaths: ${e.toString()}');
    }

    return videoFiles;
  }

  /// Creates an isolate to scan for video files in the given directory
  /// Returns a future that completes with the list of video paths
  Future<List<String>> _scanInIsolate(String directoryPath) async {
    final receivePort = ReceivePort();

    try {
      await Isolate.spawn(
          scanVideoFiles, [receivePort.sendPort, directoryPath]);

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

/// The isolate worker function that scans for video files
/// Args should contain [SendPort, String] where String is the directory path
void scanVideoFiles(List<dynamic> args) {
  List<String> videoFilePaths = [];
  SendPort sendPort = args[0];
  final directoryPath = args[1];

  try {
    _scanDirectory(Directory(directoryPath), videoFilePaths);
    sendPort.send(videoFilePaths);
  } catch (e) {
    clog.error('Error in scanVideoFiles isolate: $e');
  }
}

void _scanDirectory(Directory directory, List<String> videoFilePaths) {
  try {
    if (directory.path.contains('/Android')) return;

    directory.listSync(recursive: false, followLinks: false).forEach((entity) {
      if (entity is Directory) {
        _scanDirectory(entity, videoFilePaths);
      } else if (entity is File) {
        String ext = path.extension(entity.path).toLowerCase();
        if (VideoProvider._supportedFormats.contains(ext)) {
          videoFilePaths.add(entity.path);
        }
      }
    });
  } catch (e) {
    clog.error('Error scanning directory ${directory.path}: $e');
  }
}
