import 'package:color_log/color_log.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:floating/floating.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<bool> storagePermission() async {
    try {
      final androidInfo = await _deviceInfo.androidInfo;
      final androidVersion = int.parse(androidInfo.version.release);
      clog.checkSuccess(
          true, 'Requesting storage permissions for Android $androidVersion');

      if (androidVersion >= 13) {
        return await _requestAndroid13Permissions();
      } else {
        return await _requestLegacyPermissions();
      }
    } catch (e) {
      clog.error('Error requesting permissions: $e');
      return false;
    }
  }

  static Future<bool> _requestAndroid13Permissions() async {
    final permissions = [
      Permission.audio,
      Permission.videos,
      Permission.photos,
      Permission.manageExternalStorage,
    ];

    for (final permission in permissions) {
      await _requestPermission(permission);
    }

    return await _checkManageExternalStoragePermission();
  }

  static Future<bool> _requestLegacyPermissions() async {
    if (!(await Permission.storage.status).isGranted) {
      final status = await Permission.storage.request();
      clog.checkSuccess(
          status.isGranted, 'Storage permission status: ${status.toString()}');

      if (!status.isGranted) {
        await _openAppSettings();
      }
      return status.isGranted;
    }
    clog.checkSuccess(true, "We have storage access");
    return true;
  }

  static Future<void> _requestPermission(Permission permission) async {
    if (!(await permission.status).isGranted) {
      final status = await permission.request();
      clog.checkSuccess(status.isGranted,
          '${permission.toString()} status: ${status.toString()}');

      if (!status.isGranted) {
        await _openAppSettings();
      }
    }
  }

  static Future<bool> notificationPermission() async {
    try {
      if (!(await Permission.notification.status).isGranted) {
        final status = await Permission.notification.request();
        clog.checkSuccess(status.isGranted,
            'Notification permission status: ${status.toString()}');

        if (!status.isGranted) {
          await _openAppSettings();
        }
          clog.checkSuccess(true, "We have notification permission");
        return status.isGranted;
      }
      return true;
    } catch (e) {
      clog.error('Error requesting notification permission: $e');
      return false;
    }
  }

  static Future<bool> _checkManageExternalStoragePermission() async {
    final status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await _openAppSettings();
    }
      clog.checkSuccess(true, "We have external storage access");
    return status.isGranted;
  }

  static Future<void> _openAppSettings() async {
    await openAppSettings();
  }

//  static Future<bool> checkPipStatus() async {
//     final floating = locator<Floating>();

//     final canUsePiP = await floating.isPipAvailable;
//     return canUsePiP;
//   }
}
