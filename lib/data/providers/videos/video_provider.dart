

import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class VideoProvider {
  static const List<String> _supportedFormats = [
    '.mp4',
    '.avi',
    '.mov',
    '.mkv',
    '.wmv',
    '.flv',
    '.webm',
    '.m4v'
  ];

  Future<List<String>> fetchVideoFilePaths() async {
    List<String> videoFiles = [];
    List<Directory>? directories = await getExternalStorageDirectories();

    if (directories != null && directories.isNotEmpty) {
      for (var directory in directories) {
        List<String> files = await compute(scanVideoFiles, directory.path);
        videoFiles.addAll(files);
      }
    }

    return videoFiles;
  }
}

List<String> scanVideoFiles(String rootPath) {
  List<String> videoFilePaths = [];
  Directory directory = Directory(rootPath);

  try {
    directory.listSync(recursive: true, followLinks: false).forEach((entity) {
      if (entity is File) {
        String extension = entity.path.split('.').last.toLowerCase();
        if (VideoProvider._supportedFormats.contains('.$extension')) {
          videoFilePaths.add(entity.path);
        }
      }
    });
  } catch (e) {
    log('Error scanning directory: $e');
  }

  return videoFilePaths;
}
