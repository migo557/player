import 'dart:io';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:hive/hive.dart';
import 'package:open_player/presentation/common/widgets/quality_badge/quality_badge_widget.dart';

part 'audio_model.g.dart';

@HiveType(typeId: 1)
class AudioModel {
  @HiveField(0)
  final String title;
   @HiveField(1)
  final String artists;
   @HiveField(2)
  final String album;
   @HiveField(3)
  final List<String> genre;
   @HiveField(4)
  final String ext;
   @HiveField(5)
  final String path;
   @HiveField(6)
  final int size;
   @HiveField(7)
  final int? bitrate;
   @HiveField(8)
  final List<Picture> thumbnail;
   @HiveField(9)
  final String? lyrics;
   @HiveField(10)
  final int? sampleRate;
   @HiveField(11)
  final String? language;
   @HiveField(12)
  final DateTime? year;
   @HiveField(13)
  final File file;
   @HiveField(14)
  final Quality quality;
   @HiveField(15)
  final DateTime lastModified;
   @HiveField(16)
  final DateTime lastAccessed;


  AudioModel({
    required this.title,
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
    required this.year,
    required this.file,
    required this.quality,
    required this.lastModified,
    required this.lastAccessed,
  });

  bool matchesSearch(String query) {
    return title.toLowerCase().contains(query) ||
        artists.toLowerCase().contains(query) ||
        album.toLowerCase().contains(query) ||
        genre.any((g) => g.toLowerCase().contains(query));
  }
}
