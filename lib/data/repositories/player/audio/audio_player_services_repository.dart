import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:color_log/color_log.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../logic/audio_player_bloc/audio_player_bloc.dart';
import '../../../models/audioplayercombinedstream_model.dart';

/// Abstract repository for audio player services.
abstract class AudioPlayerServicesRepository {
  /// Toggles play/pause state of the audio player.
  Future<void> playPauseAudio();

  /// Method to handle MusicPlayerInitializeEvent and Play Music.
  FutureOr<void> initializeEvent(
      Emitter<AudioPlayerState> emit, AudioPlayerInitializeEvent event);

  FutureOr<void> nextEvent(
      Emitter<AudioPlayerState> emit, AudioPlayerNextEvent event);

  FutureOr<void> previousEvent(
      Emitter<AudioPlayerState> emit, AudioPlayerPreviousEvent event);

  FutureOr<void> seekEvent(
      Emitter<AudioPlayerState> emit, AudioPlayerSeekEvent event);
}

/// Implementation of the [AudioPlayerServicesRepository] using the Just Audio package.
final class AudioPlayerServices implements AudioPlayerServicesRepository {
  /// Creates an instance of [AudioPlayerServices].
  ///
  /// Requires an [AudioPlayer] instance to control audio playback.
  AudioPlayerServices({required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  Future<void> playPauseAudio() async {
    // Check if the audio is currently playing
    if (audioPlayer.playing) {
      // Pause the audio if it is currently playing
      await audioPlayer.pause();
    } else {
      // Play the audio if it is currently paused
      await audioPlayer.play();
    }
  }

  /// Method to handle MusicPlayerInitializeEvent and Play Music.
  @override
  FutureOr<void> initializeEvent(
      Emitter<AudioPlayerState> emit, AudioPlayerInitializeEvent event) async {
    try {
      clog.debug("AudioPlayer LoadingState");
      emit(AudioPlayerLoadingState());
      final ConcatenatingAudioSource playlist = ConcatenatingAudioSource(
          children: event.pathList
              .map(
                (path) => ProgressiveAudioSource(Uri.file(path)),
              )
              .toList());

      audioPlayer.setAudioSource(playlist);
      audioPlayer.seek(const Duration(seconds: 0),
          index: event.initialMediaIndex);
      audioPlayer.play();

      //! Combine the position and duration and Buffered streams
      final combinedStream = Rx.combineLatest9(
        audioPlayer.playingStream,
        audioPlayer.positionStream,
        audioPlayer.durationStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.processingStateStream,
        audioPlayer.speedStream,
        audioPlayer.loopModeStream,
        audioPlayer.shuffleModeEnabledStream,
        audioPlayer.currentIndexStream,
        (playing, position, duration, buffered, processing, speed, loopMode,
                shuffleModeEnabled, currentIndex) =>
            AudioPlayerCombinedStream(
                playing: playing,
                position: position,
                duration: duration,
                bufferedPosition: buffered,
                processingState: processing,
                speed: speed,
                loopMode: loopMode,
                shuffleModeEnabled: shuffleModeEnabled,
                currentIndex: currentIndex),
      ).publish().autoConnect();

      emit(AudioPlayerSuccessState(
          audioPlayer: audioPlayer,
          audioPlayerCombinedStream: combinedStream,
          isSeeking: false,
          seekingPosition: 0));

      clog.checkSuccess(true, "AudioPlayer SuccessState");
    } catch (e) {
      emit(AudioPlayerErrorState(errorMessage: e.toString()));
      clog.debug(e.toString());
    }
  }

  @override
  FutureOr<void> nextEvent(
      Emitter<AudioPlayerState> emit, AudioPlayerNextEvent event) async {
    await audioPlayer.seekToNext();
  }

  @override
  FutureOr<void> previousEvent(
      Emitter<AudioPlayerState> emit, AudioPlayerPreviousEvent event) async {
    await audioPlayer.seekToPrevious();
  }

  @override
  FutureOr<void> seekEvent(
      Emitter<AudioPlayerState> emit, AudioPlayerSeekEvent event) async {
    audioPlayer.seek(Duration(seconds: event.position.toInt()));
  }
}
