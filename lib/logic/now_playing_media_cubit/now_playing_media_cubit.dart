import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_player/data/models/audio_model.dart';

part 'now_playing_media_state.dart';

class NowPlayingMediaCubit extends Cubit<NowPlayingMediaState> {
  NowPlayingMediaCubit() : super(NowPlayingMediaState.initial());

  init({audioList}) {
    emit(NowPlayingMediaState(audioList: audioList));
  }
}
