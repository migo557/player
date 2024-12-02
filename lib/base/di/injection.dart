import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:open_player/data/services/audio/audio_player_services.dart';
import 'package:open_player/data/services/video/video_player_services.dart';
import 'package:open_player/data/services/user/user_services.dart';
import 'package:open_player/data/services/video_playback_hive_service/video_playback_service.dart';
import 'package:open_player/logic/greeting/greeting_cubit.dart';
import 'package:open_player/logic/language_cubit/language_cubit.dart';
import '../../data/providers/audio/audio_provider.dart';
import '../../data/providers/videos/video_provider.dart';
import '../../data/repositories/audio/audio_repository.dart';
import '../../data/repositories/videos/video_repository.dart';
import '../theme/themes_data.dart';

GetIt locator = GetIt.instance;

initializeLocator() {
  try {
    locator.registerSingleton<AppThemes>(AppThemes());
    clog.checkSuccess(true, "AppThemes registred");

    // Register AudioProvider
    locator.registerLazySingleton<AudioProvider>(() => AudioProvider());
    clog.checkSuccess(true, "AudioProvider registred");

    // Register VideoProvider
    locator.registerLazySingleton<VideoProvider>(
      () => VideoProvider(),
    );
    clog.checkSuccess(true, "VideoProvider registred");

    // Register AudioRepository
    locator.registerLazySingleton<AudioRepository>(
        () => AudioRepository(locator<AudioProvider>()));
    clog.checkSuccess(true, "AudioRepository registred");

    // Register VideoRepository
    locator.registerLazySingleton<VideoRepository>(
        () => VideoRepository(locator<VideoProvider>()));
    clog.checkSuccess(true, "VideoRepository registred");

    // Register UserRepository
    locator.registerLazySingleton<UserServiceImpl>(() => UserServiceImpl());
    clog.checkSuccess(true, "UserRepository registred");

    // Register AudioPlayer
    locator.registerLazySingleton<AudioPlayer>(() => AudioPlayer());
    clog.checkSuccess(true, "JustAudio Player is registred");

    // Register AudioPlayer Services Repository
    locator.registerLazySingleton<AudioPlayerServiceImpl>(
        () => AudioPlayerServiceImpl(audioPlayer: locator<AudioPlayer>()));
    clog.checkSuccess(true, "AudioPlayer Services Class is registred");

    // Register VideoPlayer Services Repository
    locator.registerLazySingleton<VideoPlayerServiceImpl>(
        () => VideoPlayerServiceImpl());
    clog.checkSuccess(true, "VideoPlayer Services Class is registred");

    // Register Language Cubit
    locator.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
    clog.checkSuccess(true, "LanguageCubit registred");

    // Register Greeing Cubit
    locator.registerLazySingleton<GreetingCubit>(
        () => GreetingCubit(languageCubit: locator<LanguageCubit>()));
    clog.checkSuccess(true, "GreetingCubit registred");

    // Register Video PlaybackHive Service
    locator.registerLazySingleton<VideoPlaybackHiveService>(
        () => VideoPlaybackHiveService());
    clog.checkSuccess(true, "VideoPlayback Hive services registred");

    // Register Songs Page ScrollController
    locator.registerLazySingleton<ScrollController>(() => ScrollController(),
        instanceName: "audios");
    clog.checkSuccess(true, "Audios Page Scroll Controller registred");

    // Register Floating (Picture In Picture) Package
    // locator.registerLazySingleton<Floating>(() => Floating());
    // clog.checkSuccess(true, " Floating (Picture In Picture) registred");
  } catch (e) {
    clog.checkSuccess(
      false,
      'Initialization error: $e',
    );
  }
}
