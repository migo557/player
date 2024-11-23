import 'package:bloc/bloc.dart';
import 'package:color_log/color_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/video_model.dart';
import '../../data/repositories/videos/video_repository.dart';

part 'videos_event.dart';
part 'videos_state.dart';

// Bloc
class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final VideoRepository videoRepository;
  List<VideoModel> cacheVideosList = [];

  VideosBloc({required this.videoRepository}) : super(VideosInitial()) {
    on<VideosLoadEvent>(_onLoadVideos);
  }

  Future<void> _onLoadVideos(
    VideosLoadEvent event,
    Emitter<VideosState> emit,
  ) async {
    try {
      emit(VideosLoading());
      if (cacheVideosList.isEmpty) {
        cacheVideosList = await videoRepository.getVideoFiles();
        emit(VideosSuccess(cacheVideosList));
      } else {
        emit(VideosSuccess(cacheVideosList));

        final freshList = await videoRepository.getVideoFiles();
        if (!listEquals(
            cacheVideosList, freshList)) {
          cacheVideosList = freshList;
          emit(VideosSuccess(cacheVideosList));
        }
      }
    } catch (e) {
      clog.error('Error in VideosBloc: $e');
      emit(VideosFailure(e.toString()));
    }
  }
}


