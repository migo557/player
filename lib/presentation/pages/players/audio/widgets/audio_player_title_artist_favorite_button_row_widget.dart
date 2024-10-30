import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/app_fonts.dart';
import 'package:open_player/presentation/common/nothing_widget.dart';
import '../../../../../logic/audio_player_bloc/audio_player_bloc.dart';

class AudioPlayerTitleArtistFavoriteButtonRowWidget extends StatelessWidget {
  const AudioPlayerTitleArtistFavoriteButtonRowWidget({
    super.key,
  });

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
                ///------     Title & Artists    ------------///
                Expanded(
                  child: StreamBuilder(
                      stream: audioPlayerState.audioPlayerCombinedStream,
                      builder: (context, snapshot) {
                        int? currentIndex = snapshot.data?.currentIndex??audioPlayerState.audioPlayer.currentIndex;
                        String title =
                          currentIndex!=null?   audioPlayerState.audios[currentIndex].title:"";
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInDown(
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: AppFonts.poppins),
                              ),
                            ),
                            const Text(
                              "Solena Lame",
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  fontFamily: AppFonts.poppins),
                            ),
                          ],
                        );
                      }),
                ),

                //---------- Favorite Button -----------------///
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      HugeIcons.strokeRoundedFavourite,
                      color: Colors.white,
                    ))
              ],
            );
          }
          return nothing;
        },
      ),
    );
  }
}
