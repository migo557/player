import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/presentation/pages/initial/widgets/bottom-navbar/custom_bottom_nav_bar_widget.dart';
import 'package:open_player/presentation/pages/video/ui/video_page.dart';
import '../../../../logic/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '../../audio/main/ui/audio-page.dart';
import '../../settings/setting/ui/setting_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
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
