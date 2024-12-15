import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/data/models/audio_model.dart';
import 'package:open_player/data/services/audio_playlist_service/audio_playlist_service.dart';
import 'package:open_player/data/services/favorite_audio_hive_service/audio_hive_service.dart';
import 'package:open_player/data/services/file_service/file_service.dart';
import 'package:open_player/logic/audio_bloc/audios_bloc.dart';
import 'package:open_player/presentation/common/widgets/audio_info_sheet/audio_info_sheet_widget.dart';
import 'package:open_player/presentation/common/widgets/create_new_playlist_button.dart';
import 'package:open_player/utils/app_menu.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../../logic/audio_playlist_bloc/audio_playlist_bloc.dart';

class SongTileMoreButtonWidget extends StatelessWidget {
  const SongTileMoreButtonWidget(
      {super.key,
      required this.path,
      required this.audio,
      required this.audios,
      required this.isPlaying});
  final bool isPlaying;
  final String path;
  final AudioModel audio;
  final List<AudioModel> audios;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        Offset position = details.globalPosition;
        AppMenuHelper.showPopMenuAtPosition(
            context: context,
            position: position,
            items: [
              _musicAddToFavorite(path),
              _musicAddToPlaylist(context, audio),
              _renameMusic(context, path, audio.title),
              _toggleHideMusic(context, path),
              _deleteMusic(
                context,
                path,
              ),
              _musicSetAsRingtone(),
              _more(context, audio),
              _share(audio),
            ]);
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          HugeIcons.strokeRoundedMoreVerticalCircle01,
          color: isPlaying ? Colors.white : null,
        ),
      ),
    );
  }
}

//----------------------------------------------------//
///-----------------  Widgets  --------------------///
///-------------------------------------------------///

///--------------- A D D  T O  F A V O R I T E
PopupMenuItem<dynamic> _musicAddToFavorite(path) {
  final isFavorite = FavoritesAudioHiveService().getFavoriteStatus(path);
  return PopupMenuItem(
    onTap: () {
      FavoritesAudioHiveService().toggleFavorite(path);
    },
    child: ListTile(
      title: Text(
        isFavorite ? "Remove from Favorites" : "Add to Favorite",
      ),
      trailing:
          Icon(isFavorite ? Icons.favorite : HugeIcons.strokeRoundedFavourite),
    ),
  );
}

///--------------- A D D  T O  P L A Y L I S T
PopupMenuItem<dynamic> _musicAddToPlaylist(
    BuildContext context, AudioModel audio) {
  return PopupMenuItem(
    onTap: () {
      showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  "Playlist".text.xl3.bold.make(),
                  Gap(10),
                  CreateNewPlaylistButton(),
                  BlocBuilder<AudioPlaylistBloc, AudioPlaylistState>(
                    builder: (context, state) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: state.playlists.length,
                            itemBuilder: (context, index) {
                              final playlist = state.playlists[index];
                              return ListTile(
                                title: state.playlists[index].name.text.make(),
                                leading: Icon(HugeIcons.strokeRoundedPlayList),
                                trailing: !AudioPlaylistService()
                                        .checkIfPlaylistAlreadyHaveAudio(
                                            playlist, audio)
                                    ? Icon(Icons.playlist_add)
                                    : null,
                                onTap: () {
                                  if (!AudioPlaylistService()
                                      .checkIfPlaylistAlreadyHaveAudio(
                                          playlist, audio)) {
                                    clog.debug("${playlist.name} is clicked");
                                    context.read<AudioPlaylistBloc>().add(
                                        AddAudioToPlaylistEvent(
                                            playlist, audio));

                                    VxToast.show(context,
                                        msg:
                                            "${audio.title} is added to the ${playlist.name} Playlist");
                                  }
                                  context.pop();
                                },
                                subtitle: AudioPlaylistService()
                                        .checkIfPlaylistAlreadyHaveAudio(
                                            playlist, audio)
                                    ? "Audio already exists".text.make()
                                    : null,
                              );
                            }),
                      );
                    },
                  ),
                ],
              ));
    },
    child: ListTile(
      title: Text(
        "Add to Playlist",
      ),
      trailing: Icon(Icons.playlist_add),
    ),
  );
}

///--------------- R E N A M E
PopupMenuItem<dynamic> _renameMusic(
    BuildContext context, String path, String songTitle) {
  final oldFileName = songTitle;
  final controller = TextEditingController(text: oldFileName);
  return PopupMenuItem(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            //-------- Column
            child: [
              Gap(5),
              "Rename".text.bold.xl2.make(),
              VxTextField(
                controller: controller,
              ),
              Gap(10),

              ///------ Buttons Row
              [
                ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FileService()
                        .renameFile(path, controller.text.trim())
                        .whenComplete(
                      () {
                        context.read<AudiosBloc>().add(AudiosLoadAllEvent());
                        context.pop();
                      },
                    );
                  },
                  child: Text("Rename"),
                ),
              ].row(alignment: MainAxisAlignment.spaceBetween),
            ].column(axisSize: MainAxisSize.min),
          ),
        ),
      );
    },
    child: const ListTile(
      title: Text(
        "Rename",
      ),
      trailing: Icon(Icons.text_snippet),
    ),
  );
}

///--------------- T O G G L E  H I D E
PopupMenuItem<dynamic> _toggleHideMusic(BuildContext context, String path) {
  final isHidden = FileService().isFileHidden(path);
  return PopupMenuItem(
    onTap: () async {
      await FileService().toggleHideFile(path);
      context.read<AudiosBloc>().add(AudiosLoadAllEvent());
    },
    child: ListTile(
      title: Text(
        isHidden ? "Unhide" : "Hide",
      ),
      trailing: Icon(isHidden ? Icons.visibility : Icons.visibility_off),
    ),
  );
}

///--------------- D E L E T E
PopupMenuItem<dynamic> _deleteMusic(
  BuildContext context,
  String path,
) {
  return PopupMenuItem(
    onTap: () {
      FileService().deleteFile(path).whenComplete(
        () {
          context.read<AudiosBloc>().add(AudiosLoadAllEvent());

          VxToast.show(context, msg: "Audio Deleted");
        },
      );
    },
    child: const ListTile(
      title: Text(
        "Delete",
      ),
      trailing: Icon(Icons.delete),
    ),
  );
}

///--------------- S E T  A S  R I N G T O N E
PopupMenuItem<dynamic> _musicSetAsRingtone() {
  return PopupMenuItem(
    onTap: () {},
    child: const ListTile(
      title: Text(
        "Set as ringtone",
      ),
      trailing: Icon(Icons.call),
    ),
  );
}

///--------------- Share
PopupMenuItem<dynamic> _share(AudioModel audio) {
  return PopupMenuItem(
    onTap: () async {
      await Share.shareXFiles([XFile(audio.path)]);
    },
    child: const ListTile(
      title: Text(
        "Share",
      ),
      trailing: Icon(HugeIcons.strokeRoundedShare01),
    ),
  );
}

///--------------- Show More
PopupMenuItem<dynamic> _more(BuildContext context, AudioModel audio) {
  return PopupMenuItem(
    onTap: () {
      showBottomSheet(
        context: context,
        enableDrag: true,
        showDragHandle: true,
        builder: (context) => AudioInfoSheetWidget(audio: audio),
      );
    },
    child: const ListTile(
      title: Text(
        "Info",
      ),
      trailing: Icon(HugeIcons.strokeRoundedInformationCircle),
    ),
  );
}
