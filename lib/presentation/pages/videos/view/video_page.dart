import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:open_player/logic/videos_bloc/videos_bloc.dart';
import 'package:open_player/presentation/pages/videos/widgets/last_played_video_play_button_widget.dart';
import 'package:open_player/presentation/pages/videos/widgets/video_page_sliver_app_bar_widget.dart';
import 'package:open_player/presentation/pages/videos/widgets/video_page_title_and_sorting_button_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/video_page_all_videos_view_widget.dart';

class VideosPage extends HookWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState(VideoFilter.all);
    return Scaffold(
      //-------- Last Played Video Button Widget
      floatingActionButton: LastPlayedVideoPlayButtonWidget().pOnly(bottom: 60),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<VideosBloc>().add(VideosLoadEvent());
        },
        child: Scrollbar(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              //------------  AppBar -----------///
              VideoPageSliverAppBarWidget(),

              //----------- Top Title And Sorting Button Row ---------///
              VideoPageTitleAndSortingButtonWidget(
                selectedFilter: selectedFilter,
              ),

              //----------- All Videos View -----------------///
              VideoPageAllVideosViewWidget(
                selectedFilter: selectedFilter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
