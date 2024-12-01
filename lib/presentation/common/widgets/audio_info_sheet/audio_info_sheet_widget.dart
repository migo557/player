import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:open_player/data/models/audio_model.dart';
import 'package:open_player/utils/formater.dart';
import 'package:velocity_x/velocity_x.dart';

class AudioInfoSheetWidget extends StatelessWidget {
  const AudioInfoSheetWidget({super.key, required this.audio});

  final AudioModel audio;

  @override
  Widget build(BuildContext context) {
    return [
      if (audio.thumbnail.isNotEmpty) Image.memory(audio.thumbnail.first.bytes),
      _Tile(
        leading: "Title",
        title: audio.title,
      ),
      _Tile(
        leading: "Album",
        title: audio.album,
      ),
      _Tile(
        leading: "Artists",
        title: audio.artists,
      ),
      _Tile(
        leading: "Genre",
        title: audio.genre.isNotEmpty ? audio.genre.join(",") : "idk",
      ),
      _Tile(
        leading: "Size",
        title: Formatter.formatBitSize(audio.size),
      ),
      _Tile(
        leading: "Bitrate",
        title: audio.bitrate != null
            ? Formatter.formatBitrate(audio.bitrate!)
            : "idk",
      ),
      _Tile(
        leading: "SampleRate",
        title: audio.sampleRate,
      ),
      _Tile(
        leading: "Year",
        title: audio.year != null ? Formatter.formatDate(audio.year!) : "idk",
      ),
      _Tile(
        leading: "Extension",
        title:  audio.ext,
      ),
      Gap(100),
    ].column().scrollVertical();
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.leading,
    required this.title,
  });

  final String leading;
  final  title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: "$leading : ".text.make(),
      title: "${title}".text.make(),
    );
  }
}
