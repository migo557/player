// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart' as pth;

class FileService {
  //-- Get File Extension
  String _getFileExtension(String path) {
    return path.split('.').last;
  }

  //-- Delete a file at the specific path
  Future<void> deleteFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      rethrow;
    }
  }

  //-- Rename a file at the specific path
  Future<void> renameFile(String oldFilePath, String newFileName) async {
    try {
      final oldFile = File(oldFilePath);
      if (await oldFile.exists()) {
        final ext = pth.extension(oldFilePath);
        final newFilePath = '${oldFile.parent.path}/$newFileName$ext';
         await oldFile.rename(newFilePath);
      }
    } catch (e) {
      rethrow;
    }
  }

  String getFileNameWithExtension(String path) {
  return  pth.basenameWithoutExtension(path);
  }
}
