import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/videos_bloc/videos_bloc.dart';
import 'package:open_player/presentation/pages/videos/widgets/video_page_sliver_app_bar_widget.dart';
import 'package:open_player/presentation/pages/videos/widgets/video_page_title_and_sorting_button_widget.dart';

import '../widgets/video_page_all_videos_view_widget.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
             onRefresh: () async {
          context.read<VideosBloc>().add(VideosLoadEvent());
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            //------------  AppBar -----------///
            VideoPageSliverAppBarWidget(),
        
            //----------- Top Title And Sorting Button Row ---------///
            VideoPageTitleAndSortingButtonWidget(),
        
            //----------- All Videos View -----------------///
            VideoPageAllVideosViewWidget(),
          ],
        ),
      ),
    );
  }
}
