import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/db/hive_service.dart';
import 'package:open_player/base/router/router.dart';
import 'package:open_player/data/models/video_model.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class LastPlayedVideoPlayButtonWidget extends StatelessWidget {
  const LastPlayedVideoPlayButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final VideoModel? lastPlayedVideo = MyHiveBoxes.videoPlayback
        .get(MyHiveKeys.lastPlayedVideo, defaultValue: null);
    return Visibility(
      visible: lastPlayedVideo != null,
      child: FloatingActionButton(
        onPressed: () {
            final VideoModel? lastVideo = MyHiveBoxes.videoPlayback
              .get(MyHiveKeys.lastPlayedVideo, defaultValue: null);
          context.read<AudioPlayerBloc>().add(AudioPlayerStopEvent());
          if (lastVideo != null) {
            context.read<VideoPlayerBloc>().add(
                  VideoInitializeEvent(
                      videoIndex: 0, playlist: [lastVideo]),
                );
            GoRouter.of(context).push(AppRoutes.videoPlayerRoute);
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.play_arrow),
      ),
    ).pOnly(bottom: 30);
  }
}
