import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/data/models/video_model.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/logic/videos_bloc/videos_bloc.dart';
import 'package:open_player/presentation/pages/videos/widgets/video_page_title_and_sorting_button_widget.dart';

import '../../../../base/router/router.dart';

class VideoPageAllVideosViewWidget extends StatelessWidget {
  const VideoPageAllVideosViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosBloc, VideosState>(
      builder: (context, state) {
        if (state is VideosLoading) {
          // Show loading indicator while videos are being loaded
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is VideosSuccess) {
          // Show the list of videos
          if (state.videos.isEmpty) {
            return SliverToBoxAdapter(
              child: Column(
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
              ),
            );
          }

          //Filter out videos  whose title starts with dot
          final filteredVideos = state.videos
              .where((video) => !video.title.startsWith('.'))
              .toList();
          //----------- Sorting the filtered List ---------------//
          state.videos.sort((a, b) => a.title.compareTo(b.title));

          ///----------- List Builder ----------///
          return SliverList.builder(
            itemCount: filteredVideos.length,
            itemBuilder: (context, index) {
              final VideoModel video = filteredVideos[index];
              final String videoTitle = video.title;
              return ListTile(
                onTap: () {
                  context.read<AudioPlayerBloc>().add(AudioPlayerStopEvent());
                  context.read<VideoPlayerBloc>().add(VideoInitializeEvent(
                      videoIndex: index, playlist: state.videos));
                  GoRouter.of(context).push(
                    AppRoutes.videoPlayerRoute,
                  );
                },
                title: Text(
                  videoTitle,
                  style: TextStyle(
                    fontFamily: AppFonts.arizonia,
                    fontSize: 15,
                  ),
                ),
                // leading: CircleAvatar(
                //   backgroundImage: MemoryImage(state.videos[index].thumbnail),
                // ),
                leading: const Icon(HugeIcons.strokeRoundedVideo01),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(HugeIcons.strokeRoundedMoreVerticalCircle01),
                ),
              );
            },
          );
        } else if (state is VideosFailure) {
          // Display error message if loading failed
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(state.message),
              ),
            ),
          );
        } else if (state is VideosInitial) {
          // Initial state could be informative
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("Fetching videos..."),
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("Something went wrong."),
            ),
          );
        }
      },
    );
  }
}
