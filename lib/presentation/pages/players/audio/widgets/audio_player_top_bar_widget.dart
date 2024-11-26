import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

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

          //--- More Button ---///
          IconButton(
            onPressed: () {},
            color: Colors.white,
            iconSize: 30,
            tooltip: "More",
            icon: const Icon(HugeIcons.strokeRoundedMoreVerticalCircle01),
          ),
        ],
      ),
    );
  }
}
