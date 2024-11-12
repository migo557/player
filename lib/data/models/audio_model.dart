import 'package:flutter/services.dart';

class AudioModel {
  final String title;
  final List<String> artists;
  final String album;
  final String genre;
  final String ext;
  final String path;
  final int size;
  final Uint8List? thumbnail;
  AudioModel(
      {required this.title,
      required this.ext,
      required this.path,
      required this.size,
      required this.thumbnail,
      required this.artists,
      required this.album,
      required this.genre,
      });
}
