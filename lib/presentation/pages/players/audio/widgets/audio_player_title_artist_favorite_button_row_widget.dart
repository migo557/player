import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/presentation/common/widgets/nothing_widget.dart';
import '../../../../../logic/audio_player_bloc/audio_player_bloc.dart';

class AudioPlayerTitleArtistFavoriteButtonRowWidget extends HookWidget {
  const AudioPlayerTitleArtistFavoriteButtonRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mq.width * 0.03, vertical: mq.height * 0.02),
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, audioPlayerState) {
          if (audioPlayerState is AudioPlayerSuccessState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: audioPlayerState.audioPlayerCombinedStream,
                    builder: (context, snapshot) {
                      int? currentIndex = snapshot.data?.currentIndex ??
                          audioPlayerState.audioPlayer.currentIndex;
                      String title = currentIndex != null
                          ? audioPlayerState.audios[currentIndex].title
                          : "";
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //------------- TITLE ----------------//
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              "$title    ",
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: AppFonts.poppins,
                              ),
                            ),
                          ),

                          //------------------- ARTISTS------------------//
                          const Text(
                            "Solena Lame",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontFamily: AppFonts.poppins,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(HugeIcons.strokeRoundedFavourite,
                      color: Colors.white),
                )
              ],
            );
          }
          return nothing;
        },
      ),
    );
  }
}
