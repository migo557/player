
class AudioQualityCalculator {
  static const int _dsd64SampleRate = 2822400;
  static const int _dsd128SampleRate = 5644800;
  static const int _dsd256SampleRate = 11289600;

  static String calculateQuality({
    required int? bitrate,
    required int? sampleRate,
    String? codec,
    int? bitDepth,
  }) {
    if (bitrate == null || sampleRate == null) return "LQ";

    final kbps = _normalizeKbps(bitrate);
    final khz = _normalizeKhz(sampleRate);

    // DSD Check with enhanced codec detection
    if (_isDSDQuality(codec, sampleRate)) {
      return "DSD";
    }

    // Master Quality check with bit depth consideration
    if (_isMasterQuality(khz, kbps, bitDepth)) {
      return "MQ";
    }

    // High Quality check
    if (_isHighQuality(khz, kbps, codec)) {
      return "HQ";
    }

    // Standard Quality check
    if (_isStandardQuality(khz, kbps)) {
      return "SQ";
    }

    return "LQ";
  }

  static bool _isDSDQuality(String? codec, int sampleRate) {
    return codec?.toLowerCase().contains('dsd') == true ||
        sampleRate == _dsd64SampleRate ||
        sampleRate == _dsd128SampleRate ||
        sampleRate == _dsd256SampleRate;
  }

  static bool _isMasterQuality(double khz, int kbps, int? bitDepth) {
    if (bitDepth != null && bitDepth >= 24) {
      return true;
    }

    return (khz >= 96 && kbps >= 3000) ||
        (khz >= 88.2 && kbps >= 2800) ||
        (khz >= 176.4 && kbps >= 5600) ||
        (khz >= 192 && kbps >= 6000);
  }

  static bool _isHighQuality(double khz, int kbps, String? codec) {
    // Check for lossless codecs
    if (codec != null &&
        (codec.toLowerCase().contains('flac') ||
            codec.toLowerCase().contains('alac'))) {
      return true;
    }

    return (khz >= 44.1 && kbps >= 1411) ||
        (khz >= 48 && kbps >= 1536) ||
        kbps >= 900;
  }

  static bool _isStandardQuality(double khz, int kbps) {
    return (khz >= 44.1 && kbps >= 256) ||
        (khz >= 32 && kbps >= 192) ||
        kbps >= 192;
  }

  static int _normalizeKbps(int bitrate) {
    return bitrate > 1000 ? bitrate ~/ 1000 : bitrate;
  }

  static double _normalizeKhz(int sampleRate) {
    return sampleRate / 1000;
  }

  static String getTechnicalSpecs({
    required int? bitrate,
    required int? sampleRate,
    String? codec,
    int? bitDepth,
  }) {
    if (bitrate == null || sampleRate == null) {
      return 'Unknown Format';
    }

    final kbps = _normalizeKbps(bitrate);
    final khz = (_normalizeKhz(sampleRate)).toStringAsFixed(1);
    final bitDepthStr = bitDepth != null ? '$bitDepth-bit' : '';
    final codecStr = codec != null ? ' / $codec' : '';

    return '$khz kHz${bitDepthStr.isNotEmpty ? ' / $bitDepthStr' : ''} / $kbps kbps$codecStr';
  }
}
