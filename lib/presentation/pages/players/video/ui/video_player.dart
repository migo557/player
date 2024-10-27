// import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_error_view_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_top_controls_buttons_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_view_widget.dart';
import '../../../../../data/models/video_model.dart';
import '../../../../../logic/video_player_bloc/video_player_bloc.dart';

/// Widget that displays the video player screen
class VideoPlayerPage extends StatefulWidget {
  final int videoIndex;
  final List<VideoModel> playlist;

  const VideoPlayerPage({
    super.key,
    required this.videoIndex,
    required this.playlist,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    context.read<VideoPlayerBloc>().add(
          VideoInitializeEvent(
            videoIndex: widget.videoIndex,
            playlist: widget.playlist,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
            builder: (context, state) => _buildVideoPlayerContent(state),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayerContent(VideoPlayerState state) {
    return switch (state) {
      VideoPlayerReadyState() => _buildVideoPlayer(state),
      VideoPlayerLoadingState() => const Center(
          child: CircularProgressIndicator(),
        ),
      VideoPlayerErrorState() => VideoPlayerErrorViewWidget(
          state: state,
        ),
      _ => const Center(
          child: Text('Something went wrong'),
        ),
    };
  }

  Widget _buildVideoPlayer(VideoPlayerReadyState state) {
    return
        // PiPSwitcher(
        // childWhenEnabled: VideoViewWidget(state: state),
        // childWhenDisabled:
        Stack(
      children: [
        VideoViewWidget(state: state),
        if (state.settings.showControls)
          VideoPlayerTopControlsButtonsWidget(context: context, state: state),
      ],
    );
    // );
  }
}
