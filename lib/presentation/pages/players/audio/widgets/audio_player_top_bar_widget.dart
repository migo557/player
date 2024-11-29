import 'package:flutter/cupertino.dart';
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
            onPressed: () {
              // TODO: Implement 
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Eqaualizer, Visualization, 3D sound'),
                  content: const Text('These features is on way'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
            color: Colors.white,
            iconSize: 25,
            tooltip: "More",
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
