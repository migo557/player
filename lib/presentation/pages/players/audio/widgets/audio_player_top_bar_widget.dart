import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/data/models/audio_model.dart';
import 'package:open_player/presentation/common/methods/show_add_to_playlist_modal_bottom_sheet.dart';
import 'package:open_player/presentation/common/widgets/nothing_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../logic/audio_player_bloc/audio_player_bloc.dart';

class AudioPlayerTopBarWidget extends StatelessWidget {
  const AudioPlayerTopBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(top: mq.height * 0.05),
      // color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //--- Back Button ---///
          IconButton(
            onPressed: () {
              context.pop();
            },
            color: Colors.white,
            iconSize: 30,
            tooltip: "Back",
            icon: const Icon(HugeIcons.strokeRoundedArrowDown01),
          ),
          const Spacer(),

          //--- Side Dialog ---///
          BlocSelector<AudioPlayerBloc, AudioPlayerState,
              AudioPlayerSuccessState?>(
            selector: (state) {
              return state is AudioPlayerSuccessState ? state : null;
            },
            builder: (context, state) {
              if (state == null) return nothing;

              return IconButton(
                onPressed: () {
                  VxDialog.showCustom(
                    context,
                    child: SlideInRight(
                      child: SizedBox(
                        height: 210,
                        width: mq.width * 0.25,
                        child: [
                          //----- Add to Playlist
                          StreamBuilder(
                              stream: state.audioPlayer.currentIndexStream,
                              builder: (context, snapshot) {
                                final int? currentIndex = snapshot.data ??
                                    state.audioPlayer.currentIndex;
                                final AudioModel? audio = currentIndex != null
                                    ? state.audios[currentIndex]
                                    : null;
                                return IconButton(
                                  onPressed: () {
                                    if (audio != null) {
                                      context.pop();
                                      showAddToPlaylistModalBottomSheet(
                                          context, audio);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.playlist_add_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                );
                              }),
                          "Add to Playlist".text.xs.white.make(),

                          //------- Equalizer
                          IconButton(
                            onPressed: () {
                              context.pop();
                              VxDialog.showCustom(
                                context,
                                child: SizedBox(
                                  height: 100,
                                  width: 200,
                                  child: "Currently not available"
                                      .text
                                      .white
                                      .makeCentered()
                                      .p8(),
                                ).glassMorphic(),
                              );
                            },
                            icon: Icon(
                              Icons.equalizer,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          "Equalizer".text.white.xs.make(),

                          //------- Speed Changer
                          IconButton(
                            onPressed: () {
                              context.pop();
                              VxDialog.showCustom(
                                context,
                                child: SizedBox(
                                  height: 100,
                                  width: 200,
                                  child: "Currently not available"
                                      .text
                                      .white
                                      .makeCentered()
                                      .p8(),
                                ).glassMorphic(),
                              );
                            },
                            icon: Icon(
                              Icons.speed,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          "Speed".text.white.xs.make(),
                        ]
                            .column(
                              alignment: MainAxisAlignment.center,
                            )
                            .scrollVertical(),
                      ).glassMorphic().pOnly(left: mq.width * 0.75),
                    ),
                  );
                },
                color: Colors.white,
                iconSize: 25,
                tooltip: "More",
                icon: const Icon(HugeIcons.strokeRoundedArrowLeft01),
              );
            },
          ),
        ],
      ),
    );
  }
}
