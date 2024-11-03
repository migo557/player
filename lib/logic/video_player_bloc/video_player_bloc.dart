import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_player/data/repositories/player/video/video_player_services_repository.dart';
import '../../base/di/dependency_injection.dart';
import '../../data/models/video_model.dart';
part 'video_player_event.dart';
part 'video_player_state.dart';

/// Constants for video player configuration
class VideoPlayerConstants {
  static const Duration buttonVisibilityDuration = Duration(seconds: 3);
}

/// BLoC for managing video player state and functionality
class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerServices videoPlayerServices = locator<VideoPlayerServices>();

  VideoPlayerBloc() : super(const VideoPlayerInitialState());
}
