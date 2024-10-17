import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:open_player/data/repositories/player/audio/audio_player_services_repository.dart';
import 'package:open_player/logic/greeting/greeting_cubit.dart';
import 'package:open_player/logic/language_cubit/language_cubit.dart';

import '../../data/providers/audio/audio_provider.dart';
import '../../data/repositories/audio/audio_repository.dart';
import '../theme/themes.dart';

GetIt locator = GetIt.instance;

initializeLocator() {
  try {
    locator.registerSingleton<AppThemes>(AppThemes());
    log('AppThemes registered');


    locator.registerSingleton<ScrollController>(ScrollController());
    log('ScrollController registered');

    // Register AudioProvider
    locator.registerLazySingleton<AudioProvider>(() => AudioProvider());
    log('AudioProvider registered');

    // Register AudioRepository
    locator.registerLazySingleton<AudioRepository>(
        () => AudioRepository(locator<AudioProvider>()));
    log('AudioRepository registered');

    // Register AudioPlayer
    locator.registerLazySingleton<AudioPlayer>(() => AudioPlayer());
    log('Just Audio Player is registered');

    // Register AudioPlayer Services Repository
    locator.registerLazySingleton<AudioPlayerServices>(
        () => AudioPlayerServices(audioPlayer: locator<AudioPlayer>()));
    log('Just Audio Player Services Repository is registered');

    // Register Language Cubit
    locator.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
    log('Language registered');

    // Register Greeing Cubit
    locator.registerLazySingleton<GreetingCubit>(
        () => GreetingCubit(languageCubit: locator<LanguageCubit>()));
    log('Greeting registered');
  } catch (e, stackTrace) {
    log('Initialization error: $e', stackTrace: stackTrace);
  }
}
