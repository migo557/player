import 'package:hive/hive.dart';
import 'package:open_player/data/models/audio_model.dart';

part 'audio_playlist_model.g.dart';

@HiveType(typeId: 2)
class AudioPlaylistModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final DateTime created;
  @HiveField(2)
  final DateTime modified;
  @HiveField(3)
  final List<AudioModel> audios;

  AudioPlaylistModel(
      {required this.name,
      required this.created,
      required this.modified,
      required this.audios});
}
