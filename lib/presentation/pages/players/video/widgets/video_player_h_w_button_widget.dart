import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';

class VideoPlayerHWButtonWidget extends StatelessWidget {
  const VideoPlayerHWButtonWidget({
    super.key,
    required this.context,
    required this.isEnabled,
  });
  final bool isEnabled;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<VideoPlayerBloc>().add(ToggleHardwareAccelerationEvent());
      },
      icon: Text(
        isEnabled ? 'HW' : 'SW',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
