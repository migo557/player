import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/data/services/favorite_audio_hive_service/audio_hive_service.dart';
import 'package:open_player/presentation/common/widgets/like_button/animated_like_button.dart';
import 'package:open_player/presentation/common/widgets/nothing_widget.dart';
import 'package:open_player/presentation/common/widgets/quality_badge/quality_badge_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../../logic/audio_player_bloc/audio_player_bloc.dart';

class AudioPlayerTitleArtistFavoriteButtonAudioQualityBadgeRowWidget
    extends StatelessWidget {
  const AudioPlayerTitleArtistFavoriteButtonAudioQualityBadgeRowWidget(
      {super.key});

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mq.width * 0.03, vertical: mq.height * 0.02),
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, audioPlayerState) {
          if (audioPlayerState is AudioPlayerSuccessState) {
            return StreamBuilder(
              stream: audioPlayerState.audioPlayerCombinedStream,
              builder: (context, snapshot) {
                int? currentIndex = snapshot.data?.currentIndex ??
                    audioPlayerState.audioPlayer.currentIndex;
                String title = currentIndex != null
                    ? audioPlayerState.audios[currentIndex].title
                    : "";

                String artists = currentIndex != null
                    ? audioPlayerState.audios[currentIndex].artists
                    : "";

                Quality audioQuality = currentIndex != null
                    ? audioPlayerState.audios[currentIndex].quality
                    : Quality.MQ;

                String currentFilePath = currentIndex != null
                    ? audioPlayerState.audios[currentIndex].path
                    : "";

                bool isFavorite = FavoritesAudioHiveService()
                    .getFavoriteStatus(currentFilePath);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: [
                        //------------- TITLE ----------------//
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: "$title    "
                              .text
                              .white
                              .minFontSize(25)
                              .fontFamily(AppFonts.poppins)
                              .shadow(1, 1, 3, Colors.black38)
                              .make(),
                        ),

                        //------------------- ARTISTS ------------------//
                        [
                          artists.text.gray100
                              .minFontSize(10)
                              .maxFontSize(12)
                              .fontFamily(AppFonts.poppins)
                              .maxLines(1)
                              .shadow(1, 1, 1, Colors.black26)
                              .make()
                              .flexible(),
                          Gap(5),

                          //--------- Audio Quality
                          Dance(
                            duration: Duration(seconds: 3),
                            child: QualityBadge(
                              quality: audioQuality,
                            ),
                          ),
                        ].row(axisSize: MainAxisSize.min),
                      ].column(
                        crossAlignment: CrossAxisAlignment.start,
                      ),
                    ),

                    //------------- Like Button -------------//
                    AnimatedLikeButton(
                      isLike: isFavorite,
                      activeColor: Theme.of(context).primaryColor,
                      onTap: () {
                        FavoritesAudioHiveService()
                            .toggleFavorite(currentFilePath);
                      },
                    ).pOnly(left: 5)
                  ],
                );
              },
            );
          }
          return nothing;
        },
      ),
    );
  }
}
