

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/brightness_cubit/brightness_cubit.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/logic/volume_cubit/volume_cubit.dart';

import '../logic/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '../logic/language_cubit/language_cubit.dart';

extension LanguageCubitExtension on BuildContext {
  LanguageCubit get languageCubit => read<LanguageCubit>();
}


extension BottomNavigationCubitExtension on BuildContext {
  BottomNavBarCubit get bottomNavBarCubit => watch<BottomNavBarCubit>();
}



extension ThemeCubitExtension on BuildContext {
  ThemeCubit get themeCubit => watch<ThemeCubit>();
}

extension BrightnessExtension on BuildContext {
  BrightnessCubit get brightnessCubit => watch<BrightnessCubit>();
}



extension VolumeCubitExtension on BuildContext {
  VolumeCubit get volumeCubit => watch<VolumeCubit>();
}



extension HelloExt on String{
  String get a => "a";
}

