import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedLikeButton extends StatelessWidget {
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Function()? onTap;
  final bool isLike;

  const AnimatedLikeButton(
      {super.key,
      this.size = 35,
      this.activeColor = Colors.red,
      this.inactiveColor = Colors.grey,
      required this.onTap,
      required this.isLike});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Roulette(
        animate: isLike,
        child: Icon(
          isLike ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
          color: isLike ? activeColor : inactiveColor,
          size: size,
        ),
      ),
    );
  }
}
