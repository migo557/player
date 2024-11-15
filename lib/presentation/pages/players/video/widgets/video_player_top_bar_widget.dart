// video_player/presentation/pages/video_player_page.dart

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/Control_visibility/controls_visibility_cubit.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_icon_button_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../common/methods/set_orientation_potrait.dart';
import '../../../../common/methods/system_ui_mode.dart';

class VideoPlayerTopBarWidget extends HookWidget {
  const VideoPlayerTopBarWidget(
      {super.key, required this.state, required this.cState});

  final VideoPlayerReadyState state;
  final ControlsVisibilityState cState;

  @override
  Widget build(BuildContext context) {
    final showMoreIcons = useState(false);
    return SafeArea(
      top: true,
      bottom: false,
      left: false,
      right: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        child: Column(
          children: [
            //----------------- Top Menu ----------------//
            if (!cState.lockScreenTapping && cState.showVideoControls)
              FadeInDown(
                child: Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        ifOrientationLandscapeMakeItPotrait(context);
                        setToDefaultSystemTopBar();
                        context.pop();
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Now Playing",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    //---- More Buttons
                    IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.white),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => Card(
                            child: SizedBox(
                              height: 150,
                              child: Center(
                                child: "new features coming soon".text.make(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

            //----------- Second Row ----------//
            //---------- Floating  Buttons -----------------///
            if (cState.showVideoControls && !cState.lockScreenTapping)
              FadeInRight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //------------ Screen Rotation
                    VideoPlayerIconButtonWidget(
                      icon: HugeIcons.strokeRoundedScreenRotation,
                      onTap: () {
                        if (MediaQuery.orientationOf(context) ==
                            Orientation.landscape) {
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp]);
                        } else {
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.landscapeLeft]);
                        }
                        context
                            .read<ControlsVisibilityCubit>()
                            .toggleVideoControlsVisibilty();
                      },
                    ),
                
                    //------------ Audio Set Button
                    VideoPlayerIconButtonWidget(
                      icon: HugeIcons.strokeRoundedFileMusic,
                      onTap: () {
                        context
                            .read<ControlsVisibilityCubit>()
                            .toggleVideoControlsVisibilty();
                      },
                    ),
                
                    //------------ Change Aspect Ratio
                    // VideoPlayerIconButtonWidget(
                    //   icon: HugeIcons.strokeRoundedAspectRatio,
                    //   onTap: () {
                    //     state.vlcPlayerController.setVideoAspectRatio("16:9");
                    //     context
                    //         .read<ControlsVisibilityCubit>()
                    //         .toggleVideoControlsVisibilty();
                    //   },
                    // ),
                
                    //------------ Lock Button
                    if (showMoreIcons.value)
                      VideoPlayerIconButtonWidget(
                          icon: HugeIcons.strokeRoundedTouchLocked02,
                          onTap: () {
                            context
                                .read<ControlsVisibilityCubit>()
                                .toggleLockScreenButton();
                          }),
                
                    //---------- Picture in Picture
                    if (showMoreIcons.value)
                      VideoPlayerIconButtonWidget(
                          icon: HugeIcons.strokeRoundedPictureInPictureOn,
                          onTap: () {
                            context
                                .read<ControlsVisibilityCubit>()
                                .toggleVideoControlsVisibilty();
                          }),
                
                    //---------- Background Play Button
                    if (showMoreIcons.value)
                      VideoPlayerIconButtonWidget(
                          icon: HugeIcons.strokeRoundedHeadphones,
                          onTap: () {
                            state.vlcPlayerController.allowBackgroundPlayback
                                .toggle();
                            context
                                .read<ControlsVisibilityCubit>()
                                .toggleVideoControlsVisibilty();
                          }),
                
                    //---------- Arrow Button to toggle more buttons
                    VideoPlayerIconButtonWidget(
                        icon: showMoreIcons.value
                            ? HugeIcons.strokeRoundedCircleArrowLeft01
                            : HugeIcons.strokeRoundedCircleArrowRight01,
                        onTap: () {
                          showMoreIcons.value = !showMoreIcons.value;
                          context
                              .read<ControlsVisibilityCubit>()
                              .toggleVideoControlsVisibilty();
                        }),
                  ],
                ),
              ),

            //-------- Lock Screen Toching Button ----------//
            if (cState.lockScreenTapping)
              VideoPlayerIconButtonWidget(
                  icon: Icons.lock,
                  onTap: () {
                    context
                        .read<ControlsVisibilityCubit>()
                        .toggleLockScreenButton();
                    context
                        .read<ControlsVisibilityCubit>()
                        .toggleVideoControlsVisibilty();
                    context
                        .read<ControlsVisibilityCubit>()
                        .toggleVideoControlsVisibilty();
                  }),
          ],
        ),
      ),
    );
  }
}
