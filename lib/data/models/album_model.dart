import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:open_player/data/models/audio_model.dart';
import 'package:open_player/presentation/common/widgets/quality_badge/quality_badge_widget.dart';

class AlbumModel {
  final String name;
  final String artist;
  final int songCount;
  final List<AudioModel> songs;
  final List<Picture> thumbnail;
  final DateTime? year;
  final Quality quality;

  AlbumModel({
    required this.name,
    required this.artist,
    required this.songCount,
    required this.songs,
    required this.thumbnail,
    required this.year,
    required this.quality,
  });
}
