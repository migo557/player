import 'package:flutter/material.dart';
import 'dart:ui';

class PremiumGlassWidget extends StatelessWidget {
  const PremiumGlassWidget({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.borderRadius = 20,
    this.baseColor,
    this.blur = 1,
    this.shimmerOpacity = 0.0,
    this.borderWidth = 1.8,
  });

  final double? height;
  final double? width;
  final double borderRadius;
  final Color? baseColor;
  final double blur;
  final double shimmerOpacity;
  final double borderWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Outer glow effect
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: (baseColor ?? Colors.white).withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        // Main glass container
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: (baseColor ?? Colors.white).withOpacity(0.12),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: borderWidth,
                    strokeAlign: BorderSide.strokeAlignCenter),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.3, 0.6, 1.0],
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Shimmer effect overlay
                  Positioned.fill(
                    child: CustomPaint(
                      painter: ShimmerPainter(shimmerOpacity),
                    ),
                  ),
                  // Inner shadow
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      gradient: RadialGradient(
                        center: Alignment.topLeft,
                        radius: 1.5,
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Content
                  child,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom painter for shimmer effect
class ShimmerPainter extends CustomPainter {
  final double opacity;

  ShimmerPainter(this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0),
          Colors.white.withOpacity(opacity),
          Colors.white.withOpacity(0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(-size.width, 0, size.width * 3, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
