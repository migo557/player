import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/presentation/pages/main/widgets/bottom-navbar/custom_bottom_nav_bar_widget.dart';
import 'package:open_player/presentation/pages/videos/view/video_page.dart';
import '../../../../logic/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '../../audio/main/view/audio_page.dart';
import '../../settings/setting/view/setting_page.dart';

class MainPage extends StatelessWidget {
   MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          return Stack(
            children: [
              //--------- Pages ---------------///
              _pages[state.index],

             
              //---------- Bottom Nav Bar----------//
              const CustomBottomNavBarWidget(),
            ],
          );
        },
      ),
    );
  }

  //--------- Pages ---------------//
  final _pages = [
    AudioPage(),
    const VideosPage(),
    const SettingPage(),
  ];
}
