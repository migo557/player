import 'package:open_player/data/models/audio_model.dart';

class AudioPlaylistModel {
  final String name;
  final DateTime created;
  final DateTime modified;
  final List<AudioModel> audios;

  AudioPlaylistModel(
      {required this.name,
      required this.created,
      required this.modified,
      required this.audios});
}
