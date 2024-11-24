import 'package:intl/intl.dart';



class Formatter {
  // Format bitrate from bits to kb/s
  static String formatBitrate(int bitsPerSecond) {
    final kbps = (bitsPerSecond / 1000).toStringAsFixed(1);
    return '$kbps kb/s';
  }
  // Format bits to appropriate unit (Kb, Mb, Gb, etc.)
  static String formatBitSize(int bits) {
    const unit = 1024;
    if (bits < unit) {
      return '$bits b';
    }
    if (bits < unit * unit) {
      return '${(bits / unit).toStringAsFixed(1)} Kb';
    }
    if (bits < unit * unit * unit) {
      return '${(bits / (unit * unit)).toStringAsFixed(1)} Mb';
    }
    if (bits < unit * unit * unit * unit) {
      return '${(bits / (unit * unit * unit)).toStringAsFixed(1)} Gb';
    }
    return '${(bits / (unit * unit * unit * unit)).toStringAsFixed(1)} Tb';
  }

  // Format bytes to appropriate unit (KB, MB, GB, etc.)
  static String formatByteSize(int bytes) {
    const unit = 1024;
    if (bytes < unit) {
      return '$bytes B';
    }
    if (bytes < unit * unit) {
      return '${(bytes / unit).toStringAsFixed(1)} KB';
    }
    if (bytes < unit * unit * unit) {
      return '${(bytes / (unit * unit)).toStringAsFixed(1)} MB';
    }
    if (bytes < unit * unit * unit * unit) {
      return '${(bytes / (unit * unit * unit)).toStringAsFixed(1)} GB';
    }
    return '${(bytes / (unit * unit * unit * unit)).toStringAsFixed(1)} TB';
  }

  // Format date to various patterns
  static String formatDate(DateTime date, {String pattern = 'dd/MM/yyyy'}) {
    return DateFormat(pattern).format(date);
  }

  // Format to relative time (e.g., "2 minutes ago")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return formatDate(date);
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  // Format to custom patterns
  static String formatDateCustom(DateTime date, {DateFormat? customPattern}) {
    final patterns = {
      'fullDate': DateFormat.yMMMMd(),
      'shortTime': DateFormat.jm(),
      'fullDateTime': DateFormat.yMMMMd().add_jm(),
      'dayMonth': DateFormat.MMMMd(),
      'weekday': DateFormat.EEEE(),
    };

    return customPattern?.format(date) ?? patterns['fullDate']!.format(date);
  }



  static String formatDuration(Duration? duration) {
    if (duration == null) return "00:00"; // Handle null case
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    // Extract hours, minutes, and seconds from duration
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      // If duration is greater than one hour, format with hours
      return "$hours:${twoDigits(minutes)}:${twoDigits(seconds)}";
    } else {
      // If duration is less than one hour, format without hours
      return "${twoDigits(minutes)}:${twoDigits(seconds)}";
    }
  }
}
