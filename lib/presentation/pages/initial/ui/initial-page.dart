import 'package:flutter/material.dart';
import 'package:open_player/presentation/pages/initial/widgets/bottom-navbar/custom_bottom_nav_bar_widget.dart';
import 'package:open_player/presentation/pages/video/ui/video-page.dart';
import '../../audio/main/ui/audio-page.dart';
import '../../settings/setting/ui/setting-page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //--------- Pages ---------------///
          _pages[index],

          //---------- Bottom Nav Bar----------//
          CustomBottomNavBarWidget(
            index: index,
          ),
        ],
      ),
    );
  }

  //--------- Pages ---------------//
  final _pages = [
    const AudioPage(),
    const VideosPage(),
    const SettingPage(),
  ];
}
