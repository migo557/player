import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:velocity_x/velocity_x.dart';

class AudioPlayerTopBarWidget extends StatelessWidget {
  const AudioPlayerTopBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(top: mq.height * 0.05),
      // color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //--- Back Button ---///
          IconButton(
            onPressed: () {
              context.pop();
            },
            color: Colors.white,
            iconSize: 30,
            tooltip: "Back",
            icon: const Icon(HugeIcons.strokeRoundedArrowDown01),
          ),
          const Spacer(),

          //--- Side Dialog ---///
          IconButton(
            onPressed: () {
              VxDialog.showCustom(
                context,
                child: SizedBox(
                  height: 150,
                  width: mq.width * 0.25,
                  child: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.equalizer,
                        color: Colors.white,
                      ),
                    ),
                    "Equalizer".text.white.xs.make(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.playlist_add_outlined,
                        color: Colors.white,
                      ),
                    ),
                        "Add to Playlist".text.xs.white.make(),
                  ].column(
                    alignment: MainAxisAlignment.center,
                  ).scrollVertical(),
                ).glassMorphic().pOnly(left: mq.width * 0.75),
              );
            },
            color: Colors.white,
            iconSize: 25,
            tooltip: "More",
            icon: const Icon(HugeIcons.strokeRoundedArrowLeft01),
          ),
        ],
      ),
    );
  }
}
