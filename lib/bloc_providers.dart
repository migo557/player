import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:open_player/base/di/injection.dart';
import 'package:open_player/data/services/user/user_services.dart';
import 'package:open_player/data/repositories/videos/video_repository.dart';
import 'package:open_player/data/services/video_playback_hive_service/video_playback_service.dart';
import 'package:open_player/logic/audio_page_tab_bar_cubit/audio_page_tab_bar_cubit.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/logic/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:open_player/logic/brightness_cubit/brightness_cubit.dart';
import 'package:open_player/logic/greeting/greeting_cubit.dart';
import 'package:open_player/logic/language_cubit/language_cubit.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/logic/user_data/user_data_cubit.dart';
import 'package:open_player/logic/video_playback/video_playback_bloc.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/logic/videos_bloc/videos_bloc.dart';
import 'base/services/storage/storage_services.dart';
import 'logic/Control_visibility/controls_visibility_cubit.dart';
import 'logic/audio_bloc/audios_bloc.dart';
import 'logic/volume_cubit/volume_cubit.dart';
import 'data/repositories/audio/audio_repository.dart';

///?----------------   B L O C   P R O V I D E R S   -------------///
///////////////////////////////////////////////////////////////////
blocProviders() {
  return [
    BlocProvider(
      create: (context) => BottomNavBarCubit(),
    ),
    BlocProvider(
      create: (context) => AudioPageTabBarCubit(),
    ),
    BlocProvider(
      create: (context) => ThemeCubit(),
    ),
    BlocProvider(
      create: (context) => LanguageCubit(),
    ),
    BlocProvider(
      create: (context) =>
          GreetingCubit(languageCubit: locator<LanguageCubit>()),
    ),
    BlocProvider(
      create: (context) =>
          AudiosBloc(audioRepository: locator<AudioRepository>()),
    ),
    BlocProvider(
      create: (context) =>
          VideosBloc(videoRepository: locator<VideoRepository>()),
    ),
    BlocProvider(
      create: (context) => UserDataCubit(
          userRepository: locator<UserServiceImpl>(),
          storageService: StorageService()),
    ),
    BlocProvider(
      create: (context) => AudioPlayerBloc(),
    ),
    BlocProvider(
      create: (context) => VideoPlayerBloc(),
    ),
    BlocProvider(
      create: (context) => VolumeCubit(
        audioPlayer: locator<AudioPlayer>(),
      ),
    ),
    BlocProvider(
      create: (context) => BrightnessCubit(),
    ),
    BlocProvider(
      create: (context) => ControlsVisibilityCubit(),
    ),
    BlocProvider(
      create: (context) => VideoPlaybackHiveBloc(
          videoPlaybackHiveService: locator<VideoPlaybackHiveService>()),
    ),
  ];
}
