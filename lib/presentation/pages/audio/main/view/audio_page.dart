import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/di/injection.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/audio_page_app_bar_widget.dart';
import 'package:open_player/presentation/common/widgets/miniplayer/mini_audio_player_widget.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/tabbar/audio_page_tab_bar_widget.dart';
import 'package:open_player/presentation/pages/audio/sub/albums/view/albums_page.dart';
import 'package:open_player/presentation/pages/audio/sub/artists/view/artists_page.dart';
import 'package:open_player/presentation/pages/audio/sub/playlists/view/playlists-page.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/view/songs_page.dart';
import '../../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../../logic/audio_page_tab_bar_cubit/audio_page_tab_bar_cubit.dart';
import '../../sub/favorites/view/audio_favorites_page.dart';

class AudioPage extends StatelessWidget {
  AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: BlocSelector<AudioPageTabBarCubit, AudioPageTabBarState,
          AudioPageTabBarState>(
        selector: (state) {
          return state;
        },
        builder: (context, state) {
          return DefaultTabController(
            length: 5,
            child: Column(
              children: [
                const MiniAudioPlayerWidget(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<AudiosBloc>().add(AudiosLoadEvent());
                    },
                    child: CustomScrollView(
                      controller: locator.get<ScrollController>(),
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        //-------------------- AppBar -------------------------//
                        const AudioPageAppBarWidget(),

                        //-------------------- Tab Bar----------------------///
                        const AudioPageTabBarWidget(),

                        //-------------- Tab Bar View --------------------//
                        _tabs[state.tabIndex]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ///---------- Tab Bar Pages List ---------------///
  final _tabs = [
    const SongsPage(),
    const AudioFavoritePage(),
    const ArtistsPage(),
    const AlbumsPage(),
    const PlaylistsPage(),
  ];
}
