// video_player/presentation/pages/video_player_page.dart

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_icon_button_widget.dart';

import '../../../../common/methods/set_orientation_potrait.dart';
import '../../../../common/methods/system_ui_mode.dart';

class VideoPlayerTopBarWidget extends StatelessWidget {
  final String? title;

  const VideoPlayerTopBarWidget({
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            FadeInDown(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      ifOrientationLandscapeMakeItPotrait(context);
                      setToDefaultSystemTopBar();
                      context.pop();
                    },
                  ),
                  Expanded(
                    child: Text(
                      title ?? "Now Playing",
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
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            //---------- Floating  Buttons -----------------///
            FadeInRight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //---------- Picture in Picture
                  VideoPlayerIconButtonWidget(
                      icon: HugeIcons.strokeRoundedPictureInPictureOn,
                      onTap: () {}),

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
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
