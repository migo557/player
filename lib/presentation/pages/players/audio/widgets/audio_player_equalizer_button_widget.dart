import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

class AudioPlayerEqualizerButtonWidget extends StatelessWidget {
  const AudioPlayerEqualizerButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          context.pop();
          VxDialog.showCustom(
            context,
            child: SizedBox(
              height: 100,
              width: 200,
              child: "Currently not available".text.white.makeCentered().p8(),
            ).glassMorphic(),
          );
        },
        icon: Icon(
          Icons.tune,
          color: Colors.white,
          size: 35,
        ),
      ),
      "Equalizer".text.white.xs.make(),
    ].column();
  }
}
