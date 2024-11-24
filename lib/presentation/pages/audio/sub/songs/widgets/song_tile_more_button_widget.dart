import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/data/models/audio_model.dart';
import 'package:open_player/data/services/favorite_audio_hive_service/audio_hive_service.dart';
import 'package:open_player/data/services/file_service/file_service.dart';
import 'package:open_player/logic/audio_bloc/audios_bloc.dart';
import 'package:open_player/presentation/common/widgets/audio_info_sheet/audio_info_sheet_widget.dart';
import 'package:open_player/utils/app_menu.dart';
import 'package:velocity_x/velocity_x.dart';

class SongTileMoreButtonWidget extends StatelessWidget {
  const SongTileMoreButtonWidget({
    super.key,
    required this.path,
    required this.audio,
    required this.audios,
  });
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
              _renameMusic(context, path, audio.title),
              _deleteMusic(
                context,
                path,
                audios,
              ),
              _musicSetAsRingtone(),
              _more(context, audio),
            ]);
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(HugeIcons.strokeRoundedMoreVerticalCircle01),
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
                        context.read<AudiosBloc>().add(AudiosLoadEvent());
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

///--------------- D E L E T E
PopupMenuItem<dynamic> _deleteMusic(
  BuildContext context,
  String path,
  List<AudioModel> audios,
) {
  return PopupMenuItem(
    onTap: () {
      FileService().deleteFile(path).whenComplete(
        () {
          context.read<AudiosBloc>().add(AudiosLoadEvent());

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
