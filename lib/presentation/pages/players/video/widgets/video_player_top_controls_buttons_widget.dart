// import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_back_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_control_icon_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_h_w_button_widget.dart';


class VideoPlayerTopControlsButtonsWidget extends StatelessWidget {
  const VideoPlayerTopControlsButtonsWidget({
    super.key,
    required this.context,
    required this.state,
  });

  final VideoPlayerReadyState state;

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VideoPlayerBackButtonWidget(
            context: context,
            state: state,
          ),
          Row(
            children: [
              VideoPlayerControlIconButtonWidget(
                context: context,
                icon: HugeIcons.strokeRoundedAudioBook04,
                isActive: state.settings.playInBackground,
                onPressed: () {
                  context
                      .read<VideoPlayerBloc>()
                      .add(ToggleBackgroundPlaybackEvent());
                },
              ),
              VideoPlayerControlIconButtonWidget(
                context: context,
                icon: HugeIcons.strokeRoundedSubtitle,
                isActive: state.settings.showSubtitles,
                onPressed: () {
                  context.read<VideoPlayerBloc>().add(ToggleSubtitlesEvent());
                },
              ),
              VideoPlayerHWButtonWidget(
                context: context,
                isEnabled: state.settings.useHardwareAcceleration,
              ),
              VideoPlayerControlIconButtonWidget(
                context: context,
                icon: HugeIcons.strokeRoundedPictureInPictureOn,
                isActive: false,
                onPressed: () async {
                  // final floating = locator<Floating>();
                  // final currentStatus = await floating.pipStatus;
                  // if (await AppPermissionService.checkPipStatus() && currentStatus == PiPStatus.disabled) {
                  //       await floating.enable(const ImmediatePiP());
                  // }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
