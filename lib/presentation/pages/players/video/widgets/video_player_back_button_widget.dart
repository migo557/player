import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';

class VideoPlayerBackButtonWidget extends StatelessWidget {
  const VideoPlayerBackButtonWidget({
    super.key,
    required this.context,
    required this.state,
  });

  final BuildContext context;
  final VideoPlayerReadyState state;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        CupertinoIcons.back,
        color: Colors.white,
      ),
    );
  }
}
