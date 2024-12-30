// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// enum Quality {
//   DSD, // Digital Stream Digital (Highest)
//   MQ, // Master Quality
//   HQ, // High Quality
//   SQ, // Standard Quality
//   LQ // Low Quality
// }

// Extension to add properties to Quality enum
// extension QualityProps on Quality {
//   String get label => name;

//   String get description {
//     switch (this) {
//       case Quality.DSD:
//         return 'Audiophile Grade (DSD)';
//       case Quality.MQ:
//         return 'Studio Master Quality';
//       case Quality.HQ:
//         return 'CD Quality or Better';
//       case Quality.SQ:
//         return 'High-Quality Streaming';
//       case Quality.LQ:
//         return 'Basic Quality';
//     }
//   }

//   Color get baseColor {
//     switch (this) {
//       case "DSD":
//         return const Color(0xFFFF6B6B);
//       case "MQ":
//         return const Color(0xFF9C27B0);
//       case "HQ":
//         return const Color(0xFF2196F3);
//       case "SQ":
//         return const Color(0xFF4CAF50);
//       case "LQ":
//         return Colors.grey;
//     }
//   }
// }

class QualityBadge extends HookWidget {
  final String quality;
  final bool isDark;
  final double size;
  final bool showAnimation;
  final VoidCallback? onTap;

  const QualityBadge({
    super.key,
    this.quality = "LQ",
    this.isDark = false,
    this.size = 12,
    this.showAnimation = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    final scaleAnimation = useAnimation(
      Tween<double>(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
    );

    final glowAnimation = useAnimation(
      Tween<double>(begin: 0.3, end: 0.5).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
    );

    useEffect(() {
      if (isHovered.value) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      return null;
    }, [isHovered.value]);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: GestureDetector(
        onTap: onTap,
        child: Transform.scale(
          scale: showAnimation ? scaleAnimation : 1.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size * 0.5,
              vertical: size * 0.167,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size * 0.333),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  baseColor(quality),
                  baseColor(quality).withValues(alpha: 0.8),
                  baseColor(quality).withValues(alpha: 0.9),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: baseColor(quality).withValues(
                    alpha:
                    showAnimation ? glowAnimation : 0.3,
                  ),
                  blurRadius: size * 0.333,
                  spreadRadius: size * 0.083,
                ),
              ],
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  quality,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size * 0.6,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color baseColor(String quality) {
    switch (quality) {
      case "DSD":
        return const Color(0xFFFF6B6B);
      case "MQ":
        return const Color(0xFF9C27B0);
      case "HQ":
        return const Color(0xFF2196F3);
      case "SQ":
        return const Color(0xFF4CAF50);
      case "LQ":
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
