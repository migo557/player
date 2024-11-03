import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/presentation/pages/players/audio/ui/audio_player.dart';
import 'package:open_player/presentation/pages/players/video/ui/video_player.dart';
import 'package:open_player/presentation/pages/settings/change_accent_color/ui/change_accent_color_page.dart';
import 'package:open_player/presentation/pages/settings/language/ui/language_page.dart';
import 'package:open_player/presentation/pages/settings/user_profile/ui/user_profile_page.dart';
import 'package:open_player/presentation/pages/splash/ui/splash_page.dart';
import 'package:open_player/presentation/pages/view_directory/ui/view_directory_page.dart';
import '../../presentation/pages/main/ui/main_page.dart';
import '../../presentation/pages/search/audio/ui/search_audio_page.dart';
import '../../presentation/pages/search/videos/ui/search_videos_page.dart';
import '../../presentation/pages/settings/setting/ui/setting_page.dart';
import 'app_routes.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.splashRoute,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.mainRoute,
      builder: (context, state) => MainPage(),
    ),
    GoRoute(
      path: AppRoutes.settingsRoute,
      builder: (context, state) => const SettingPage(),
    ),
    GoRoute(
      path: AppRoutes.userProfileRoute,
      name: AppRoutes.userProfileRoute,
      builder: (context, state) => const UserProfilePage(),
    ),
    GoRoute(
      path: AppRoutes.changeThemeRoute,
      builder: (context, state) => ChangeAccentColorPage(),
    ),
    GoRoute(
      name: AppRoutes.languageRoute,
      path: AppRoutes.languageRoute,
      builder: (context, state) => const LanguagePage(),
    ),
    GoRoute(
        name: AppRoutes.audioPlayerRoute,
        path: AppRoutes.audioPlayerRoute,
        builder: (context, state) {
          return const AudioPlayerPage();
        }),
    GoRoute(
        name: AppRoutes.videoPlayerRoute,
        path: AppRoutes.videoPlayerRoute,
        builder: (context, state) {
          final data = state.extra as List;
          return const VideoPlayerPage(
              // videoIndex: data[0] as int,
              // playlist: data[1] as List<VideoModel>,
              );
        }),
    GoRoute(
      name: AppRoutes.searchAudiosRoute,
      path: AppRoutes.searchAudiosRoute,
      builder: (context, state) => const SearchAudioPage(),
    ),
    GoRoute(
      name: AppRoutes.searchVideosRoute,
      path: AppRoutes.searchVideosRoute,
      builder: (context, state) => const SearchVideosPage(),
    ),
    GoRoute(
      name: AppRoutes.viewDirectoryRoute,
      path: AppRoutes.viewDirectoryRoute,
      builder: (context, state) => const ViewDirectoryPage(),
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text(' ${state.error}'),
      ),
    );
  },
);
