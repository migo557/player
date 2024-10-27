import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/presentation/pages/main/widgets/bottom-navbar/custom_bottom_nav_bar_widget.dart';
import 'package:open_player/presentation/pages/videos/ui/video_page.dart';
import '../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../logic/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '../../../../logic/videos_bloc/videos_bloc.dart';
import '../../audio/main/ui/audio_page.dart';
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
