import 'package:flutter/services.dart';

class VideoModel {
  final String title;
  final String ext;
  final String path;
  final int fileSize;
  final Uint8List? thumbnail;
  final DateTime lastAccessed;
  final DateTime lastModified;

  VideoModel(
      {required this.title,
      required this.ext,
      required this.path,
      required this.fileSize,
      required this.thumbnail,
      required this.lastAccessed,
      required this.lastModified
      });
}
