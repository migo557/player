import 'package:color_log/color_log.dart';
import 'package:flutter/services.dart';

class SystemService {
 static Future<void> setOrientationPortraitOnly() async {
    // Set preferred screen orientations
    clog.info('Setting preferred orientations');
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

 static Future<void> setUIModeEdgeToEdge() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    clog.checkSuccess(true, 'Preferred orientations set to Potrait Up Only');
  }
}
