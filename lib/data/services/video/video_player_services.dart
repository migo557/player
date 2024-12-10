import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:open_player/data/models/video_model.dart';

import '../../../logic/video_player_bloc/video_player_bloc.dart';

/// Abstract repository for video player services.
abstract class VideoPlayerServiceBase {
  FutureOr<void> videoInitialization(
      VideoInitializeEvent event, Emitter<VideoPlayerState> emit);
  FutureOr<void> videoStop(
      VideoStopEvent event, Emitter<VideoPlayerState> emit);

  FutureOr<void> videoPlayPause(
      VideoPlayPauseToggleEvent event, Emitter<VideoPlayerState> emit);
}

/// Implementation of the [VideoPlayerServiceBase] using VLC Player.
final class VideoPlayerService implements VideoPlayerServiceBase {
  late VlcPlayerController vlcPlayerController;

  @override
  FutureOr<void> videoInitialization(
      VideoInitializeEvent event, Emitter<VideoPlayerState> emit) {
    emit(VideoPlayerLoadingState());
    try {
      List<VideoModel> videos = event.playlist;
      int videoIndex = event.videoIndex;
      vlcPlayerController = VlcPlayerController.file(
        File(videos[videoIndex].path),
        hwAcc: HwAcc.full,
        autoPlay: true,
        options: VlcPlayerOptions(),
        autoInitialize: true,
      );

      emit(
        VideoPlayerReadyState(
          vlcPlayerController: vlcPlayerController,
          playingVideoPath: videos[videoIndex].path,
        ),
      );
    } catch (e) {
      emit(VideoPlayerErrorState(message: e.toString()));
    }
  }

  @override
  FutureOr<void> videoStop(
      VideoStopEvent event, Emitter<VideoPlayerState> emit) {
    vlcPlayerController.stop();
  }

  @override
  FutureOr<void> videoPlayPause(
      VideoPlayPauseToggleEvent event, Emitter<VideoPlayerState> emit) async {
    bool isPlaying = await vlcPlayerController.isPlaying() ?? false;
    if (isPlaying) {
      vlcPlayerController.pause();
    } else {
      vlcPlayerController.pause();
    }
  }
}
