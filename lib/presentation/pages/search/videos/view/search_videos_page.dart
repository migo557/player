import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/presentation/common/widgets/custom_video_tile_widget.dart';
import 'package:open_player/presentation/common/widgets/nothing_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../../data/models/video_model.dart';
import '../../../../../logic/videos_bloc/videos_bloc.dart';

class SearchVideosPage extends HookWidget {
  const SearchVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchText = useState("");

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: [
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(CupertinoIcons.back)),
            Expanded(
              child: VxTextField(
                autofocus: true,
                onChanged: (v) {
                  searchText.value = v.toLowerCase().trim();
                },
                hint: "Search videos",
                borderType: VxTextFieldBorderType.none,
                fillColor: Colors.transparent,
              ),
            ),
          ].row()),
      body: BlocSelector<VideosBloc, VideosState, VideosSuccess?>(
        selector: (state) {
          return state is VideosSuccess ? state : null;
        },
        builder: (context, state) {
          if (state == null) return nothing;
          // Show the list of videos
          if (state.videos.isEmpty) {
            return [
              "No videos found. refresh now".text.make(),
              IconButton(
                onPressed: () {
                  context.read<VideosBloc>().add(VideosLoadEvent());
                },
                icon: const Icon(HugeIcons.strokeRoundedRefresh),
              ),
            ].column(
              alignment: MainAxisAlignment.center,
            );
          }

          //Filter out videos  whose title starts with dot &  Sorting the filtered List
          final filteredVideos = state.videos
              .where((video) => !video.title.startsWith('.'))
              .toList()..sort((a, b) => a.title.compareTo(b.title));

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
              return CustomVideoTileWidget(
                  filteredVideos: filteredVideos,
                  videoTitle: videoTitle,
                  video: video,
                  index: index);
            },
          );
        },
      ),
    );
  }
}
