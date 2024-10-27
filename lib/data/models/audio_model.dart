import 'package:flutter/services.dart';

class AudioModel {
  final String title;
  final String ext;
  final String path;
  final int fileSize;
  final Uint8List? thumbnail;
  AudioModel(
      {required this.title,
      required this.ext,
      required this.path,
      required this.fileSize,
      required this.thumbnail});
}
