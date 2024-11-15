import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/presentation/common/widgets/nothing_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../../base/assets/fonts/styles.dart';
import '../../../../../base/router/router.dart';
import '../../../../../data/models/video_model.dart';
import '../../../../../logic/audio_player_bloc/audio_player_bloc.dart';
import '../../../../../logic/video_player_bloc/video_player_bloc.dart';
import '../../../../../logic/videos_bloc/videos_bloc.dart';

class SearchVideosPage extends HookWidget {
  const SearchVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchText = useState("");

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(CupertinoIcons.back)),
            Expanded(
              child: TextField(
                autofocus: true,
                onChanged: (v) {
                  searchText.value = v.toLowerCase().trim();
                },
                decoration: InputDecoration(
                  hintText: "Search the videos",
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocSelector<VideosBloc, VideosState, VideosSuccess?>(
        selector: (state) {
          return state is VideosSuccess ? state : null;
        },
        builder: (context, state) {
          if (state == null) return nothing;
          // Show the list of videos
          if (state.videos.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("No videos found. refresh now"),
                IconButton(
                  onPressed: () {
                    context.read<VideosBloc>().add(VideosLoadEvent());
                  },
                  icon: const Icon(HugeIcons.strokeRoundedRefresh),
                ),
              ],
            );
          }

          //Filter out videos  whose title starts with dot
          final filteredVideos = state.videos
              .where((video) => !video.title.startsWith('.'))
              .toList();
          //----------- Sorting the filtered List ---------------//
          state.videos.sort((a, b) => a.title.compareTo(b.title));

          final searchVideos = filteredVideos
              .where(
                (video) => video.title.toLowerCase().contains(searchText.value),
              )
              .toList();

          ///----------- List Builder ----------///
          return ListView.builder(
            itemCount: searchVideos.length,
            itemBuilder: (context, index) {
              final VideoModel video = searchVideos[index];
              final String videoTitle = video.title;
              return ListTile(
                visualDensity: VisualDensity.comfortable,
                onTap: () {
                  context.read<AudioPlayerBloc>().add(AudioPlayerStopEvent());
                  context.read<VideoPlayerBloc>().add(VideoInitializeEvent(
                      videoIndex: index, playlist: searchVideos));
                  GoRouter.of(context).push(
                    AppRoutes.videoPlayerRoute,
                  );
                },
                title: videoTitle.text
                    .fontFamily(AppFonts.poppins)
                    .maxFontSize(14)
                    .make(),
                leading: const Icon(HugeIcons.strokeRoundedFileVideo),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(HugeIcons.strokeRoundedMoreVerticalCircle01),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
