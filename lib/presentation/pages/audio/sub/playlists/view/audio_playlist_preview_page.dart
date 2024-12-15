import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:open_player/data/models/audio_playlist_model.dart';
import 'package:open_player/logic/audio_playlist_bloc/audio_playlist_bloc.dart';
import 'package:open_player/utils/formater.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../../base/assets/fonts/styles.dart';
import '../../../../../../base/assets/images/app_images.dart';
import '../../../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../../common/widgets/audio_tile_widget.dart';
import '../../../../../common/widgets/custom_back_button.dart';

class AudioPlaylistPreviewPage extends StatelessWidget {
  const AudioPlaylistPreviewPage({super.key, required this.playlist});

  final AudioPlaylistModel playlist;

  @override
  Widget build(BuildContext context) {
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
    return Scaffold(
      body: BlocSelector<AudiosBloc, AudiosState, AudiosSuccess?>(
        selector: (audiosState) {
          return audiosState is AudiosSuccess ? audiosState : null;
        },
        builder: (context, audioState) {
          if (audioState == null) return "No Audios found".text.make();
          return CustomScrollView(
            slivers: [
              _AppBar(
                  playlist: playlist,
                  scaffoldColor: scaffoldColor,
                  textColor: textColor),

              //------------- Music List ------///
              if (playlist.audios.isNotEmpty)
                SliverList.builder(
                  addAutomaticKeepAlives: true,
                  itemCount: playlist.audios.length,
                  itemBuilder: (context, index) {
                    return AudioTileWidget(
                      audios: playlist.audios,
                      index: index,
                      state: audioState,
                      showRemoveFromPlaylistButton: true,
                      playlistRemoveOnTap: () {
                        context.read<AudioPlaylistBloc>().add(
                            RemoveAudioFromPlaylistEvent(
                                playlist, playlist.audios[index]));
                      },
                    );
                  },
                ),

              if (playlist.audios.isEmpty)
                SliverToBoxAdapter(
                  child: "Empty Playlist".text.makeCentered(),
                )
            ],
          );
        },
      ),
    );
  }
}

//---------- APPBAR --------------//
class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.playlist,
    required this.scaffoldColor,
    required this.textColor,
  });

  final AudioPlaylistModel playlist;
  final Color scaffoldColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      expandedHeight: 300,
      floating: true,
      flexibleSpace: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.defaultProfile), fit: BoxFit.cover),
        ),
        child: [
          //------------- Album Background ----------//
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  scaffoldColor,
                  scaffoldColor.withOpacity(0.6),
                  scaffoldColor.withOpacity(0.1),
                ],
              )),
            ),
          ),

          ///--------- Album Thumbnail & Title Row ----------///
          [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(AppImages.defaultProfile),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                playlist.name.text.xl3
                    .color(textColor)
                    .fontFamily(AppFonts.poppins)
                    .fontWeight(FontWeight.w500)
                    .make(),
                "${playlist.audios.length} songs"
                    .text
                    .color(textColor.withOpacity(0.5))
                    .make(),
                "${Formatter.formatDate(playlist.created)} created"
                    .text
                    .xs
                    .gray500
                    .make(),
                "${Formatter.formatDateCustom(playlist.modified)} (${playlist.modified.hour}:${playlist.modified.minute}: ${playlist.modified.second} Time) \n last Modified"
                    .text
                    .xs
                    .gray500
                    .make(),
              ],
            ).centered()
          ].row().p12().positioned(bottom: 50),

          //-------- Back Button
          CustomBackButton().safeArea(),
        ].stack(),
      ),
    );
  }
}
