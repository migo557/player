import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/di/dependency_injection.dart';
import 'package:open_player/data/repositories/user/user_repository.dart';
import 'package:open_player/data/repositories/videos/video_repository.dart';
import 'package:open_player/logic/audio_page_tab_bar_cubit/audio_page_tab_bar_cubit.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/logic/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:open_player/logic/greeting/greeting_cubit.dart';
import 'package:open_player/logic/language_cubit/language_cubit.dart';
import 'package:open_player/logic/now_playing_media_cubit/now_playing_media_cubit.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/logic/user_data/user_data_cubit.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/logic/videos_bloc/videos_bloc.dart';

import '../../base/services/user/storage_services.dart';
import '../../logic/audio_bloc/audios_bloc.dart';
import '../repositories/audio/audio_repository.dart';

///?----------------   B L O C   P R O V I D E R S   -------------///
///////////////////////////////////////////////////////////////////
myBlocProviders() {
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
          userRepository: locator<UserRepository>(),
          storageService: StorageService()),
    ),
        BlocProvider(
      create: (context) => AudioPlayerBloc(),
    ),
    BlocProvider(
      create: (context) => VideoPlayerBloc(),
    ),
     BlocProvider(
      create: (context) => NowPlayingMediaCubit(),
    )
  ];
}
