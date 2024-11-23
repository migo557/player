import 'package:flutter/material.dart';

enum Quality {
  DSD, // Digital Stream Digital (Highest)
  MQ, // Master Quality
  HQ, // High Quality
  SQ, // Standard Quality
  LQ // Low Quality
}

class QualityBadge extends StatelessWidget {
  final Quality quality;
  final bool isDark;
  final double size;

  const QualityBadge({
    super.key,
    this.quality = Quality.SQ,
    this.isDark = false,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _getGradientColors(),
        ),
        boxShadow: [
          BoxShadow(
            color: _getMainColor().withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getQualityText(),
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.6,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getQualityText() {
    switch (quality) {
      case Quality.SQ:
        return 'SQ';
      case Quality.HQ:
        return 'HQ';
      case Quality.MQ:
        return 'MQ';
      case Quality.DSD:
        return 'DSD';
      case Quality.LQ:
        return "LQ";

        
    }
  }

  Color _getMainColor() {
    switch (quality) {
      case Quality.SQ:
        return const Color(0xFF4CAF50); // Green
      case Quality.HQ:
        return const Color(0xFF2196F3); // Blue
      case Quality.MQ:
        return const Color(0xFF9C27B0); // Purple
      case Quality.DSD:
        return const Color(0xFFFF6B6B); // Red
      case Quality.LQ:
        return Colors.grey;
    }
  }

  List<Color> _getGradientColors() {
    final baseColor = _getMainColor();
    return [
      baseColor,
      baseColor.withOpacity(0.8),
      baseColor.withOpacity(0.9),
    ];
  }
}
