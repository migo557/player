import 'dart:developer';
import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_kit/media_kit.dart';
import 'package:open_player/data/repositories/player/audio/audio_player_services_repository.dart';
import 'package:open_player/data/repositories/player/video/video_player_services_repository.dart';
import 'package:open_player/data/repositories/user/user_repository.dart';
import 'package:open_player/logic/greeting/greeting_cubit.dart';
import 'package:open_player/logic/language_cubit/language_cubit.dart';
// import 'package:floating/floating.dart';
import '../../data/providers/audio/audio_provider.dart';
import '../../data/providers/videos/video_provider.dart';
import '../../data/repositories/audio/audio_repository.dart';
import '../../data/repositories/videos/video_repository.dart';
import '../theme/themes.dart';

GetIt locator = GetIt.instance;

initializeLocator() {
  try {
    locator.registerSingleton<AppThemes>(AppThemes());
    clog.checkSuccess(true, "AppThemes registred");

    locator.registerSingleton<ScrollController>(ScrollController());
    log('ScrollController registered');

    // Register AudioProvider
    locator.registerLazySingleton<AudioProvider>(() => AudioProvider());
    clog.checkSuccess(true, "AudioProvider registred");

    // Register VideoProvider
    locator.registerLazySingleton<VideoProvider>(() => VideoProvider());
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
    locator.registerLazySingleton<UserRepository>(
        () => UserRepository());
    clog.checkSuccess(true, "UserRepository registred");

    // Register AudioPlayer
    locator.registerLazySingleton<AudioPlayer>(() => AudioPlayer());
    clog.checkSuccess(true, "JustAudio Player is registred");

    // Register AudioPlayer Services Repository
    locator.registerLazySingleton<AudioPlayerServices>(
        () => AudioPlayerServices(audioPlayer: locator<AudioPlayer>()));
    clog.checkSuccess(true, "AudioPlayer Services Class is registred");

        // Register VideoPlayer Services Repository
    locator.registerLazySingleton<VideoPlayerServices>(
        () => VideoPlayerServices(player: locator<Player>()));
    clog.checkSuccess(true, "VideoPlayer Services Class is registred");

    // Register Language Cubit
    locator.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
    clog.checkSuccess(true, "LanguageCubit registred");

    // Register Greeing Cubit
    locator.registerLazySingleton<GreetingCubit>(
        () => GreetingCubit(languageCubit: locator<LanguageCubit>()));
    clog.checkSuccess(true, "GreetingCubit registred");
 
// Register Video Info Package
    locator.registerLazySingleton<Player>(() => Player(
          configuration: const PlayerConfiguration(
            title: 'Video Player',
            bufferSize: 128 * 1024 * 1024,
            vo: 'gpu',
            logLevel: MPVLogLevel.error,
          ),
        ));
    clog.checkSuccess(true, " Media Kit Player registred");



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
