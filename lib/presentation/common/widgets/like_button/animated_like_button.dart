import 'package:flutter/material.dart';

class AnimatedLikeButton extends StatelessWidget {
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Function()? onTap;
  final bool isLike;

  const AnimatedLikeButton({
    super.key,
    this.size = 35,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.grey,
    required this.onTap,
    required this.isLike
  });

  @override
  Widget build(BuildContext context) {


    



    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLike ? Icons.favorite : Icons.favorite_border,
        color: isLike ? activeColor : inactiveColor,
        size: size,
      ),
    );
  }
}
