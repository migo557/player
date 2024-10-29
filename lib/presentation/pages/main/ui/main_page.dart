import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/app_fonts.dart';
import 'package:open_player/base/assets/images/app-images.dart';
import 'package:open_player/presentation/common/nothing_widget.dart';
import 'package:open_player/presentation/pages/main/widgets/bottom-navbar/custom_bottom_nav_bar_widget.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_actions_buttons_widget.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_play_pause_button_widget.dart';
import 'package:open_player/presentation/pages/videos/ui/video_page.dart';
import '../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../logic/audio_player_bloc/audio_player_bloc.dart';
import '../../../../logic/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '../../../../logic/videos_bloc/videos_bloc.dart';
import '../../audio/main/ui/audio_page.dart';
import '../../players/audio/ui/audio_player.dart';
import '../../settings/setting/ui/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    context.read<AudiosBloc>().add(AudiosLoadEvent());
    context.read<VideosBloc>().add(VideosLoadEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double mqWidth = MediaQuery.sizeOf(context).width;
    final double mqHeight = MediaQuery.sizeOf(context).height;
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
