import 'package:flutter/material.dart';

class VideoPlayerControlIconButtonWidget extends StatelessWidget {
  const VideoPlayerControlIconButtonWidget({
    super.key,
    required this.context,
    required this.icon,
    required this.isActive,
    required this.onPressed,
  });
  final IconData icon;
  final bool isActive;
  final VoidCallback onPressed;

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: isActive ? Theme.of(context).primaryColor : Colors.white,
      ),
    );
  }
}
