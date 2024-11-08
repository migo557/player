// storage_service.dart
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageService {
  Future<Directory> getApplicationDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }
}
