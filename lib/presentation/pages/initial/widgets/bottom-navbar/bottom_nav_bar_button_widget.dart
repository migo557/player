import 'package:flutter/material.dart';

class BottomNavBarButtonWidget extends StatelessWidget {
  const BottomNavBarButtonWidget({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });
  final  bool isSelected;
  final Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        color: isSelected? Theme.of(context).primaryColor:null,
        iconSize: 35,
        onPressed: onPressed,
        icon:  Icon(icon),
      ),
    );
  }
}
