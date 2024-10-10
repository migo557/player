import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

GetIt locator = GetIt.instance;

initializeLocator() {
  try {
    locator.registerSingleton<AudioPlayer>(AudioPlayer());
    log('AudioPlayer registered');    

    locator.registerSingleton<ScrollController>(ScrollController());
    log('ScrollController registered');

  } catch (e, stackTrace) {
    log('Initialization error: $e', stackTrace: stackTrace); 
  }
  
  
  }