import 'package:audio_metadata_reader/audio_metadata_reader.dart';

class AudioModel {
  final String title;
  final String artists;
  final String album;
  final List<String> genre;
  final String ext;
  final String path;
  final int size;
  final int? bitrate;
  final List<Picture> thumbnail;
  final String? lyrics;
  final int? sampleRate;
  final String? language;
  final DateTime? year;
  AudioModel(
      {required this.title,
      required this.ext,
      required this.path,
      required this.size,
      required this.thumbnail,
      required this.artists,
      required this.album,
      required this.genre,
      required this.bitrate,
      required this.lyrics,
      required this.sampleRate,
      required this.language,
      required this.year
      });
}
