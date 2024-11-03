import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:open_player/presentation/pages/search/audio/widgets/audio_search_app_bar_widget.dart';

import '../../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../common/nothing_widget.dart';
import '../../../audio/sub/songs/widgets/song_tile_widget.dart';

class SearchAudioPage extends HookWidget {
  const SearchAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final query = useState("");

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //------- App Bar --------//
          AudioSearchAppBarWidget(query: query),

          //-------- Audios List -------------------///
          BlocSelector<AudiosBloc, AudiosState, AudiosSuccess?>(
            selector: (state) => state is AudiosSuccess ? state : null,
            builder: (context, state) {
              if (state == null) return nothing;

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final audios = state.songs
                        .where((audio) =>
                            audio.title.toLowerCase().contains(query.value))
                        .toList();

                    if (audios.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text("No Result")),
                      );
                    }

                    return SongTileWidget(
                      index: index,
                      state: state,
                      audio: audios[index],
                    );
                  },
                  childCount: state.songs
                      .where((audio) =>
                          audio.title.toLowerCase().contains(query.value))
                      .length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
