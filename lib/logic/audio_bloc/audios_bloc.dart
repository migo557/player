import 'package:bloc/bloc.dart';
import 'package:color_log/color_log.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/audio_model.dart';
import '../../data/repositories/audio/audio_repository.dart';

part 'audios_event.dart';
part 'audios_state.dart';

// Bloc
class AudiosBloc extends Bloc<AudiosEvent, AudiosState> {
  final AudioRepository audioRepository;

  AudiosBloc({required this.audioRepository}) : super(AudiosInitial()) {
    on<AudiosLoadEvent>(_onLoadAudios);
  }

  Future<void> _onLoadAudios(
    AudiosLoadEvent event,
    Emitter<AudiosState> emit,
  ) async {
    try {
      emit(AudiosLoading());
      final List<AudioModel> songs = await audioRepository.getAudioFiles();
      emit(AudiosSuccess(songs: songs));
    } catch (e) {
      clog.error('Error in AudiosBloc: $e');
      emit(AudiosFailure(e.toString()));
    }
  }



  
}
