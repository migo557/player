import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:open_player/base/assets/images/app-images.dart';
import 'package:open_player/utils/duration/formatDuration.dart';

import '../../../../../logic/audio_player_bloc/audio_player_bloc.dart';
import '../../../../common/nothing_widget.dart';

class AudioPlayerThumbnailWidget extends StatelessWidget {
  const AudioPlayerThumbnailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return Positioned(
      top: mq.height * 0.16,
      height: mq.height * 0.45,
      width: mq.width,
      //------ Gesture Detector for audio [For Volume], [Seek] and [Next][Previous] changing
      child: GestureDetector(
        child: Stack(
          children: [
            //-------- Thumbnail Card --------//
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
              child: Card(
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      //--                  Image             --//
                      image: const DecorationImage(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        image: AssetImage(AppImages.defaultProfile),
                      )),
                ),
              ),
            ),

            //------- Seeking  Position
            BlocSelector<AudioPlayerBloc, AudioPlayerState,
                AudioPlayerSuccessState?>(
              selector: (state) {
                return state is AudioPlayerSuccessState ? state : null;
              },
              builder: (context, state) {
                if (state == null) return nothing;

                

                return Visibility(
                  visible: state.isSeeking,
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          formatDuration(
                              Duration(seconds: state.seekingPosition.toInt())),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
