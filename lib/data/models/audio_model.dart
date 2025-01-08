import 'package:hive/hive.dart';
import 'package:open_player/data/models/picture_model.dart';

part 'audio_model.g.dart';

@HiveType(typeId: 1)
class AudioModel extends HiveObject {
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
  final List<PictureModel> thumbnail;
  @HiveField(9)
  final String? lyrics;
  @HiveField(10)
  final int? sampleRate;
  @HiveField(11)
  final String? language;
  @HiveField(12)
  final DateTime? year;

  @HiveField(13)
  final DateTime lastModified;
  @HiveField(14)
  final DateTime lastAccessed;
  @HiveField(15)
  final String quality;

  @HiveField(16)
  final int id;

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
      required this.year,
      required this.quality,
      required this.lastModified,
      required this.lastAccessed,
      required this.id});

  bool matchesSearch(String query) {
    return title.toLowerCase().contains(query) ||
        artists.toLowerCase().contains(query) ||
        album.toLowerCase().contains(query) ||
        genre.any((g) => g.toLowerCase().contains(query));
  }
}
