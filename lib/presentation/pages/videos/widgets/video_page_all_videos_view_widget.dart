import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/app_fonts.dart';
import 'package:open_player/base/router/app_routes.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/logic/videos_bloc/videos_bloc.dart';

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
                  const Text("No videos found."),
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
          return SliverList.builder(
            itemCount: state.videos.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                context.read<AudioPlayerBloc>().add(AudioPlayerStopEvent());
                List data = [
                  index,
                  state.videos,
                ];

                GoRouter.of(context)
                    .push(AppRoutes.videoPlayerRoute, extra: data);
              },
              title: Text(
                state.videos[index].title,
                style:
                    const TextStyle(fontFamily: AppFonts.poppins, fontSize: 15),
              ),
              // leading: CircleAvatar(
              //   backgroundImage: MemoryImage(state.videos[index].thumbnail),
              // ),
              leading: const Icon(HugeIcons.strokeRoundedVideo01),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(HugeIcons.strokeRoundedMoreVerticalCircle01),
              ),
            ),
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
