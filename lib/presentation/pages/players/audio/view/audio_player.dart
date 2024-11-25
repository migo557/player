import 'package:flutter/material.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_actions_buttons_widget.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_background_blur_image_widget.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_position_and_duration_widget.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_seek_bar_widget.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_center_stack_widget.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_title_artist_favorite_button_row_widget.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_top_bar_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class AudioPlayerPage extends StatelessWidget {
  const AudioPlayerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          //-------- Background Blur Image ---------//
          const AudioPlayerBackgroundBlurImageWidget(),

          //--------------- TopBar ------------//
          const AudioPlayerTopBarWidget(),

          //----------------- [Thumbnail Image] [Gestures Boxes] [Volume Box] [Position Box] ---------------//

          const AudioPlayerCenterStackWidget(),

          //------------- Player Glassophate ----------------//
          Positioned(
            bottom: mq.height * 0.06,
            height: mq.height * 0.3,
            width: mq.width*0.88,
            left: mq.width*0.06,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
              child: Column(
                children: [
                  //------------   Music Title & Artist And Favorite Button  & Audio Quality Badge Row
                  AudioPlayerTitleArtistFavoriteButtonAudioQualityBadgeRowWidget(),
              
                  //------------ Seek Bar
                  AudioPlayerSeekBarWidget(),
              
                  //------------ Position & Duration
                  AudioPlayerPositionAndDurationWidget(),
              
                  //----- Buttons ----//
                  AudioPlayerActionsButtonsWidget()
                ],
              ).scrollVertical(),
            ).glassMorphic(),
          ),
        ],
      ),
    );
  }
}
