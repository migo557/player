import 'package:flutter/material.dart';

class GlassophateWidget extends StatelessWidget {
  const GlassophateWidget({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    this.intensity,
  });

  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;
  final double? intensity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (color ?? Colors.white).withOpacity(intensity ?? 0.12),
      child: Container(
        height: height ?? 0,
        width: width ?? 0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        child: child,
      ),
    );
  }
}
