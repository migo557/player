import 'package:flutter/material.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/app_bar_widget.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/tabbar/audio_page_tab_bar_view_widget.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/tabbar/audio_page_tab_bar_widget.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: CustomScrollView(
          slivers: [
            //-------------------- AppBar -------------------------//
            const AudioPageAppBarWidget(),

            //-------------------- Tab Bar----------------------///
            AudioPageTabBarWidget(),

            //-------------- Tab Bar View --------------------//
            AudioPageTabBarViewWidget()
          ],
        ),
      ),
    );
  }
}
