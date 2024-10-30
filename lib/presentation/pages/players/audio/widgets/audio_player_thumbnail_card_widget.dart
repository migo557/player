import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:open_player/base/assets/images/app-images.dart';

class AudioPlayerThumbnailCardWidget extends StatelessWidget {
  const AudioPlayerThumbnailCardWidget({
    super.key,
    required this.mq,
  });

  final Size mq;

  @override
  Widget build(BuildContext context) {
    return FadeInDownBig(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
        child: Card(
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
                //--                  Image             --//
                image: const DecorationImage(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  image: AssetImage(AppImages.defaultProfile),
                )),
          ),
        ),
      ),
    );
  }
}
