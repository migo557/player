



import 'package:open_player/presentation/common/widgets/quality_badge/quality_badge_widget.dart';

class AudioQualityCalculator {
  static Quality calculateQuality({
    required int? bitrate,
    required int? sampleRate,
    String? codec,
  }) {
    // Convert bitrate to kbps if it's in bps
    final kbps =
        (bitrate ?? 0) > 1000 ? (bitrate ?? 0) ~/ 1000 : (bitrate ?? 0);
    final khz = (sampleRate ?? 0) ~/ 1000;

    // Check for DSD quality (Direct Stream Digital)
    if (codec?.toLowerCase().contains('dsd') == true ||
        sampleRate == 2822400 || // DSD64
        sampleRate == 5644800 || // DSD128
        sampleRate == 11289600) {
      // DSD256
      return  Quality.DSD;
    }

    // Check for Master Quality (MQ)
    if ((khz >= 96 && kbps >= 3000) || // 96kHz/24bit or higher
        (khz >= 88.2 && kbps >= 2800) || // 88.2kHz/24bit
        (khz >= 176.4 && kbps >= 5600) || // 176.4kHz/24bit
        (khz >= 192 && kbps >= 6000)) {
      // 192kHz/24bit
      return  Quality.MQ;
    }

    // Check for High Quality (HQ)
    if ((khz >= 44.1 && kbps >= 1411) || // CD Quality (16bit/44.1kHz)
        (khz >= 48 && kbps >= 1536) || // 48kHz/16bit
        (sampleRate ?? 0) >= 88200 || // High sample rate
        kbps >= 900) {
      // High bitrate lossy
      return  Quality.HQ;
    }

    // Check for Standard Quality (SQ)
    if ((khz >= 44.1 && kbps >= 256) || // Standard streaming quality
        (khz >= 32 && kbps >= 192) || // Decent quality
        kbps >= 192) {
      // Minimum acceptable quality
      return  Quality.SQ;
    }

    // Everything else is considered Low Quality (LQ)
    return  Quality.LQ;
  }

  // Helper method to get quality description
  static String getQualityDescription(Quality quality) {
    switch (quality) {
      case Quality.DSD:
        return 'DSD (Direct Stream Digital)';
      case Quality.MQ:
        return 'Master Quality (Hi-Res Audio)';
      case Quality.HQ:
        return 'High Quality (CD Quality or Better)';
      case Quality.SQ:
        return 'Standard Quality (Good Streaming Quality)';
      case Quality.LQ:
        return 'Low Quality (Below Standard)';
    }
  }

  // Helper method to get technical specs string
  static String getTechnicalSpecs({
    required int? bitrate,
    required int? sampleRate,
    String? codec,
  }) {
    final kbps =
        (bitrate ?? 0) > 1000 ? (bitrate ?? 0) ~/ 1000 : (bitrate ?? 0);
    final khz = ((sampleRate ?? 0) / 1000).toStringAsFixed(1);

    return '${khz}kHz / ${kbps}kbps${codec != null ? ' / $codec' : ''}';
  }
}
