import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import '../../base/di/dependency_injection.dart';
import '../../data/models/audio_model.dart';
import '../../data/models/audioplayercombinedstream_model.dart';
import '../../data/repositories/player/audio/audio_player_services_repository.dart';
part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer audioPlayer = locator.get<AudioPlayer>();
  final AudioPlayerServices audioServices = locator.get<AudioPlayerServices>();
  AudioPlayerBloc() : super(AudioPlayerInitialState()) {
    on<AudioPlayerInitializeEvent>(_audioPlayerInitializeEvent);
    on<AudioPlayerPlayPauseToggleEvent>(_audioPlayerPauseToggle);
    on<AudioPlayerNextEvent>(_audioPlayerNextEvent);
    on<AudioPlayerPreviousEvent>(_audioPlayerPreviousEvent);
    on<AudioPlayerSeekEvent>(_audioPlayerSeekEvent);
    on<AudioPlayerIsSeekingToggleEvent>(_audioPlayerIsSeekingToggleEvent);
    on<AudioPlayerShuffleEvent>(_audioPlayerShuffleEvent);
    on<AudioPlayerRepeatToggleEvent>(_audioPlayerRepeatToggleEvent);
  }

  /// Method to handle MusicPlayerInitializeEvent and Play Audio.
  FutureOr<void> _audioPlayerInitializeEvent(
      AudioPlayerInitializeEvent event, Emitter<AudioPlayerState> emit) async {
    audioServices.initializeEvent(emit, event);
  }

  /// Method to handle  Play And Pause Audio.
  FutureOr<void> _audioPlayerPauseToggle(
      AudioPlayerPlayPauseToggleEvent event, Emitter<AudioPlayerState> emit) {
    audioServices.playPauseAudio();
  }

  FutureOr<void> _audioPlayerNextEvent(
      AudioPlayerNextEvent event, Emitter<AudioPlayerState> emit) {
    audioServices.nextEvent(emit, event);
  }

  FutureOr<void> _audioPlayerPreviousEvent(
      AudioPlayerPreviousEvent event, Emitter<AudioPlayerState> emit) {
    audioServices.previousEvent(emit, event);
  }

  FutureOr<void> _audioPlayerSeekEvent(
      AudioPlayerSeekEvent event, Emitter<AudioPlayerState> emit) {
    audioServices.seekEvent(emit, event);
  }

  FutureOr<void> _audioPlayerIsSeekingToggleEvent(
      AudioPlayerIsSeekingToggleEvent event, Emitter<AudioPlayerState> emit) {
    final double position = event.position;
    final bool isSeeking = event.isSeeking;
    emit(event.state.copyWith(isSeeking: isSeeking, seekingPosition: position));
  }

  FutureOr<void> _audioPlayerShuffleEvent(
      AudioPlayerShuffleEvent event, Emitter<AudioPlayerState> emit) async {
    bool isShufle = !audioPlayer.shuffleModeEnabled;
    await audioPlayer.setShuffleModeEnabled(isShufle);
  }

  FutureOr<void> _audioPlayerRepeatToggleEvent(
      AudioPlayerRepeatToggleEvent event,
      Emitter<AudioPlayerState> emit) async {
    LoopMode loop = audioPlayer.loopMode;
    if (loop == LoopMode.all) {
      await audioPlayer.setLoopMode(LoopMode.one);
    }

    if (loop == LoopMode.one) {
      await audioPlayer.setLoopMode(LoopMode.off);
    }
    if (loop == LoopMode.off) {
      await audioPlayer.setLoopMode(LoopMode.all);
    }
  }
}
